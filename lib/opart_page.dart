import 'dart:io';

import 'package:flutter/material.dart';
import 'opart_fibonacci.dart';
// import 'opart_tree.dart';
// import 'opart_wallpaper.dart';
// import 'opart_wave.dart';
import 'bottom_app_bar_custom.dart';
import 'model.dart';
import 'toolbox.dart';
import 'package:shake/shake.dart';
import 'dart:math';
import 'package:share/share.dart';
import 'package:screenshot/screenshot.dart';

List<Map<String,dynamic>> opArtTypes = [{'name': 'Fibonacci', 'currentType': currentFibonacci }];


class OpArtPage extends StatefulWidget {
  int currentOpArt;
  OpArtPage(this.currentOpArt);
  @override
  _OpArtPageState createState() => _OpArtPageState();
}

bool showFullPage = true;
File imageFile;
Random rnd;

class _OpArtPageState extends State<OpArtPage> with TickerProviderStateMixin {

  AnimationController controller1;

  Animation<double> animation1;
  @override
  void initState() {

    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        opArtTypes[widget.currentOpArt]['currentType'].randomize();
        opArtTypes[widget.currentOpArt]['currentType'].randomizePalette();
        addToCache();
      });
    });

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 72000),
    );
    CurvedAnimation(parent: controller1, curve: Curves.linear);

    Tween<double> _angleTween = Tween(begin: 0, end: 2 * pi);

    animation1 = _angleTween.animate(controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });

    controller1.forward();

    addToCache();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget bodyWidget() {
      return ValueListenableBuilder<int>(
          valueListenable: rebuildCanvas,
          builder: (context, value, child) {
            return Screenshot(
              controller: screenshotController,
              child: Visibility(
                visible: true,
                child: LayoutBuilder(
                  builder: (_, constraints) => Container(
                    width: constraints.widthConstraints().maxWidth,
                    height: constraints.heightConstraints().maxHeight,
                    child: CustomPaint(
                        painter: OpArtFibonacciPainter(
                      seed, rnd,
                      animation1.value,
                      // animation2.value
                    )),
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[200],
        title: Text(
          'Fibonanacci',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Righteous',
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
//                  Platform.isAndroid? Icons.share: Icons.ios_share,
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () {
                print('sharing');
                imageFile = null;
                screenshotController
                    .capture(delay: Duration(milliseconds: 0), pixelRatio: 2)
                    .then((File image) async {
                  print(image);
                  setState(() {
                    imageFile = image;

                    if (Platform.isAndroid) {
                      Share.shareFiles(
                        [imageFile.path],
                        subject: 'Using Chris\'s fabulous OpArt App',
                        text: 'Download the OpArt App NOW!',
                      );
                    } else {
                      Share.shareFiles(
                        [imageFile.path],
                        sharePositionOrigin:
                            Rect.fromLTWH(0, 0, size.width, size.height / 2),
                        subject: 'Using Chris\'s fabulous OpArt App',
                      );
                    }
                  });
                });
              })
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(randomise: () {
        opArtTypes[widget.currentOpArt]['currentType'].randomize();
        opArtTypes[widget.currentOpArt]['currentType'].randomizePalette();
        rebuildCanvas.value++;
        addToCache();
      }, randomisePalette: () {
        opArtTypes[widget.currentOpArt]['currentType'].randomizePalette();
        rebuildCanvas.value++;
        addToCache();
      }, showToolBox: () {
        ToolBox(context, settingsList, addToCache);
      }),
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 60,
              child: ValueListenableBuilder<int>(
                  valueListenable: rebuildCache,
                  builder: (context, value, child) {
                    return cachedFibonacciList.length == 0
                        ? Container()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: scrollController,
                            itemCount: cachedFibonacciList.length,
                            reverse: false,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () {
                                    revertToCache(index);
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    width: 50,
                                    height: 50,
                                    child: Image.file(
                                        cachedFibonacciList[index]['image']),
                                  ),
                                ),
                              );
                            },
                          );
                  })),
          Expanded(child: ClipRect(child: bodyWidget())),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }
}
