import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opart_v2/tabs/tab_choose_palette.dart';
import 'bottom_app_bar.dart';
import 'model_opart.dart';
import 'tabs/tab_palette.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shake/shake.dart';

import 'package:share/share.dart';

import 'canvas.dart';
import 'download_high_resolution.dart';
import 'tabs/tab_tools.dart';

import 'tab_widget.dart';

class OpArtPage extends StatefulWidget {
  OpArtType opArtType;
  OpArtPage(this.opArtType);
  @override
  _OpArtPageState createState() => _OpArtPageState();
}

int currentTab = 10;

bool showSettings = false;
bool tabOut = false;
File imageFile;
bool showCustomColorPicker = false;
OpArt opArt;

class _OpArtPageState extends State<OpArtPage> {
  @override
  void initState() {
    opArt = OpArt(opArtType: widget.opArtType);
    showSettings = true;
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        opArt.randomizeSettings();
        opArt.randomizePalette();
        rebuildCanvas.value++;
        opArt.saveToCache();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => opArt.saveToCache());
  }

  AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    Future<void> _paymentDialog() async {
      if (animationController != null) {
        animationController.stop();
      }
      imageFile = null;
      screenshotController
          .capture(delay: Duration(milliseconds: 100), pixelRatio: 0.2)
          .then((File image) async {
        print(image);
        setState(() {
          imageFile = image;
        });

        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Download this image in high resolution.'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                        'For only 99p you can download this image in a resolution suitable for printing.'),
                    Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          image,
                          fit: BoxFit.fitWidth,
                        ))
                  ],
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text('Pay 99p'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DownloadHighRes()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('No thank you'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
      return null;
    }

    SystemChrome.setEnabledSystemUIOverlays([]);
    Size size = MediaQuery.of(context).size;

    return ValueListenableBuilder<int>(
        valueListenable: rebuildOpArtPage,
        builder: (context, value, child) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: showSettings
                ? AppBar(
                    backgroundColor: Colors.cyan[200].withOpacity(0.8),
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
                        SystemChrome.setEnabledSystemUIOverlays(
                            SystemUiOverlay.values);
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.file_download, color: Colors.black),
                          onPressed: () async {
                            _paymentDialog();
                          }),
                      IconButton(
                          icon: Icon(
//                  Platform.isAndroid? Icons.share: Icons.ios_share,
                            Icons.share,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            imageFile = null;
                            screenshotController
                                .capture(
                                    delay: Duration(milliseconds: 100),
                                    pixelRatio: 1)
                                .then((File image) async {
                              print(image);
                              setState(() {
                                imageFile = image;

                                if (Platform.isAndroid) {
                                  Share.shareFiles(
                                    [imageFile.path],
                                    subject:
                                        'Using Chris\'s fabulous OpArt App',
                                    text:
                                        'Created using OpArt Lab - check it out at opartlab.com',
                                  );
                                } else {
                                  Share.shareFiles(
                                    [imageFile.path],
                                    sharePositionOrigin: Rect.fromLTWH(
                                        0, 0, size.width, size.height / 2),
                                    subject:
                                        'Using Chris\'s fabulous OpArt App',
                                  );
                                }
                              });
                            });
                          })
                    ],
                  )
                : null,
            body: Stack(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (showSettings || tabOut) {
                          showSettings = false;
                          currentTab = 10;
                          tabOut = false;
                          showCustomColorPicker = false;
                        } else {
                          showSettings = true;

                          showCustomColorPicker = false;
                        }
                      });
                    },
                    child: InteractiveViewer(
                      child: ClipRect(
                          child: CanvasWidget(
                        showSettings,
                      )),
                    )),
                Align(
                  alignment: Alignment.topCenter,
                  child: showSettings
                      ? SafeArea(
                          child: Container(
                              color: Colors.white.withOpacity(0.8),
                              width: MediaQuery.of(context).size.width,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 4),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    opArt.revertToCache(index);
                                                  },
                                                  child: Image.file(opArt
                                                      .cache[index]['image']),
                                                ),
                                              );
                                            },
                                          );
                                  })),
                        )
                      : Container(height: 0),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: showSettings
                      ? customBottomAppBar(context: context, opArt: opArt)
                      : BottomAppBar(),
                ),
                showSettings || currentTab == 0
                    ? TabWidget(80, animationController, ChoosePaletteTab(),
                        -0.5, Icons.portrait, 0)
                    : Container(),
                showSettings || currentTab == 2
                    ? TabWidget(50, animationController, PaletteTab(context), 0,
                        Icons.palette, 2)
                    : Container(),
                showSettings || currentTab == 2
                    ? TabWidget(80, animationController, ToolBoxTab(), 0.5,
                        MdiIcons.tools, 2)
                    : Container(),
              ],
            ),
          );
        });
  }
}
