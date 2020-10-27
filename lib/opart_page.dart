import 'dart:io';
import 'package:flutter/material.dart';
import 'bottom_app_bar.dart';
import 'model.dart';
import 'toolbox.dart';
import 'package:shake/shake.dart';
import 'dart:math';
import 'package:share/share.dart';
import 'package:screenshot/screenshot.dart';
import 'canvas.dart';

//Random rnd = Random();

class OpArtPage extends StatefulWidget {
  OpArtType opArtType;
  OpArtPage(this.opArtType);
  @override
  _OpArtPageState createState() => _OpArtPageState();
}

bool showFullPage = false;
File imageFile;

OpArt opArt;

class _OpArtPageState extends State<OpArtPage> {
  @override
  void initState() {
    opArt = OpArt(opArtType: OpArtType.Fibonacci);
    showFullPage = false;
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        opArt.randomize();
        opArt.palette.randomizePalette();
        rebuildCanvas.value++;
        opArt.saveToCache();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => opArt.saveToCache());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: showFullPage
          ? AppBar(
              backgroundColor: Colors.cyan[200],
              title: Text(
                opArt.name,
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
                  opArt.setDefault();
                  opArt.clearCache();

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
                          .capture(
                              delay: Duration(milliseconds: 0), pixelRatio: 2)
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
                              sharePositionOrigin: Rect.fromLTWH(
                                  0, 0, size.width, size.height / 2),
                              subject: 'Using Chris\'s fabulous OpArt App',
                            );
                          }
                        });
                      });
                    })
              ],
            )
          : AppBar(
              toolbarHeight: 0,
            ),
      bottomNavigationBar: showFullPage
          ? customBottomAppBar(context: context, opArt: opArt)
          : BottomAppBar(),
      body: Column(
        children: [
          showFullPage
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  height: 60,
                  child: ValueListenableBuilder<int>(
                      valueListenable: rebuildCache,
                      builder: (context, value, child) {
                        return opArt.cacheListLength() == 0
                            ? Container()
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: scrollController,
                                itemCount: opArt.cacheListLength(),
                                reverse: false,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        opArt.revertToCache(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        width: 50,
                                        height: 50,
                                        child: Image.file(
                                            opArt.cache[index]['image']),
                                      ),
                                    ),
                                  );
                                },
                              );
                      }))
              : Container(),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showFullPage = !showFullPage;
                    });
                  },
                  child: ClipRect(child: CanvasWidget()))),
        ],
      ),
    );
  }
}
