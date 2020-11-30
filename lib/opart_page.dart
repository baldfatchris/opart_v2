import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:opart_v2/tabs/general_tab.dart';
import 'package:opart_v2/tabs/choose_pallette_widget.dart';
import 'package:share/share.dart';
import 'package:shake/shake.dart';
import 'main.dart';

import 'package:opart_v2/tabs/color_picker_widget.dart';
import 'bottom_app_bar.dart';
import 'model_opart.dart';
import 'download_high_resolution.dart';
import 'canvas.dart';
import 'mygallery.dart';
import 'tabs/tools_widget.dart';
import 'tabs/tab_widget.dart';

import 'dart:async';
import 'package:purchases_flutter/purchases_flutter.dart';

class OpArtPage extends StatefulWidget {
  OpArtType opArtType;
  Map<String, dynamic> opArtSettings;
  bool downloadNow;
  OpArtPage(
    this.opArtType,
    this.downloadNow, {
    this.opArtSettings,
  });
  @override
  _OpArtPageState createState() => _OpArtPageState();
}

bool showSettings = false;
File imageFile;
bool showCustomColorPicker = false;
OpArt opArt;
bool changeSettingsView = true;
bool highDefDownloadAvailable = false;
String highDefPrice;
bool downloadNow = false;

class _OpArtPageState extends State<OpArtPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showProgressIndicator = false;
  @override
  void initState() {
    downloadNow = widget.downloadNow;
    if (downloadNow) {
      showProgressIndicator = true;
    }
    slider = 100;
    opArt = OpArt(opArtType: widget.opArtType);
    if (widget.opArtSettings != null) {
      seed = widget.opArtSettings['seed'];
      for (int i = 0; i < opArt.attributes.length; i++) {
        opArt.attributes[i].value =
            widget.opArtSettings[opArt.attributes[i].label];
      }
      opArt.palette.paletteName = widget.opArtSettings['paletteName'];

      opArt.palette.colorList = widget.opArtSettings['colors'];
      rebuildCanvas.value++;
    }

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      opArt.saveToCache();
      toolsTab.openTab();
    });
  }

  _downloadHighResFile() async {
    downloadNow = false;
    imageFile = null;
    screenshotController
        .capture(delay: Duration(milliseconds: 100), pixelRatio: 10)
        .then((File image) async {
      print(image);
      setState(() {
        imageFile = image;

        if (Platform.isAndroid) {
          Share.shareFiles(
            [imageFile.path],
            subject: 'Created using OpArt Lab - download the free app now!',
            text: 'Created using OpArt Lab - download the free app now!',
          );
        } else {
          Share.shareFiles(
            [imageFile.path],
            sharePositionOrigin: Rect.fromLTWH(
                0,
                0,
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 2),
            subject: 'Created using OpArt Lab - download the free app now!',
          );
        }
        showProgressIndicator = false;
        rebuildOpArtPage.value++;
      });
    });
  }

  Future<bool> _shareImage(Size size) async {
    if (Platform.isAndroid) {
      Share.shareFiles(
        [imageFile.path],
        subject: 'Created using OpArt Lab - download the free app now!',
        text: 'Created using OpArt Lab - download the free app now!',
      );
    } else {
      Share.shareFiles(
        [imageFile.path],
        sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2),
        subject: 'Created using OpArt Lab - download the free app now!',
      );
    }
    return true;
  }

  AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    if (downloadNow) {
      WidgetsBinding.instance.addPostFrameCallback((value) {
        _downloadHighResFile();
      });
    }
    ;
    toolsTab = ToolsTab();
    paletteTab = PaletteTab(context);
    choosePaletteTab = ChoosePaletteTab();
    Size size = MediaQuery.of(context).size;
    Future<void> _paymentDialog() async {
      if (animationController != null) {
        animationController.stop();
      }
      imageFile = null;
      screenshotController
          .capture(delay: Duration(milliseconds: 100), pixelRatio: 0.2)
          .then((File image) async {
        setState(() {
          imageFile = image;
        });
        Package p0001;
        // find the product
        //   print(offerings.current.availablePackages);
        if (offerings != null) {
          p0001 = offerings.current.availablePackages
              .firstWhere((element) => element.product.identifier == "p0001");
          if (p0001 != null) {
            highDefDownloadAvailable = true;
            highDefPrice = p0001.product.priceString;
            print('highDefPrice: $highDefPrice');
          }
        }
        return showDialog<void>(
          context: context,
          barrierDismissible: true, // user must tap button!
          builder: (BuildContext context) {
            return SimpleDialog(
              children: [
                Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Download Options',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 2,
                                    child: Text(
                                        'Low definition - suitable for sharing.')),
                                Flexible(
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      imageFile = null;
                                      screenshotController
                                          .capture(
                                              delay:
                                                  Duration(milliseconds: 100),
                                              pixelRatio: 2)
                                          .then((File image) async {
                                        print(image);
                                        setState(() {
                                          imageFile = image;
                                          Navigator.pop(context);
                                          _shareImage(size);
                                        });
                                      });
                                    },
                                    child: Text('Free!'),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 2,
                                    child: Text(
                                        'High definition -  suitable for printing.')),
                                Flexible(
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      showProgressIndicator = true;
                                      rebuildOpArtPage.value++;
                                      try {
                                        Purchases.setFinishTransactions(true);
                                        PurchaserInfo purchaserInfo =
                                            await Purchases.purchasePackage(
                                                p0001);
                                        print('Bought it!!');
                                        print(purchaserInfo
                                            .allPurchasedProductIdentifiers);
                                        List<String> purchases = purchaserInfo
                                            .allPurchasedProductIdentifiers;
                                        purchases.forEach((element) {
                                          if (element == 'p0001') {
                                            // Process the high definition download
                                            imageFile = null;

                                            screenshotController
                                                .capture(
                                                    delay: Duration(
                                                        milliseconds: 100),
                                                    pixelRatio: 10)
                                                .then((File image) async {
                                              print('image saved');

                                              imageFile = image;
                                              _shareImage(size).then((value) {
                                                opArt
                                                    .saveToLocalDB(true)
                                                    .then((value) async {
                                                  rebuildMain.value++;
                                                  rebuildGallery.value++;

                                                  showProgressIndicator = false;

                                                  Navigator.pushReplacement(
                                                      _scaffoldKey
                                                          .currentContext,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyGallery(
                                                                  value + 10,
                                                                  true)));
                                                });
                                              });
                                            });
                                          }
                                        });
                                      } on PlatformException catch (e) {
                                        var errorCode =
                                            PurchasesErrorHelper.getErrorCode(
                                                e);
                                        if (errorCode !=
                                            PurchasesErrorCode
                                                .purchaseCancelledError) {
                                          print(e);
                                        }
                                      }
                                    },
                                    child: Text(highDefPrice != null
                                        ? highDefPrice
                                        : 'doh!'),
                                    backgroundColor: highDefPrice != null
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Material(
                        child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      });
      return null;
    }

    SystemChrome.setEnabledSystemUIOverlays([]);

    return ValueListenableBuilder<int>(
        valueListenable: rebuildOpArtPage,
        builder: (context, value, child) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: _scaffoldKey,
              // floatingActionButton: showSettings
              //     ? Padding(
              //         padding: const EdgeInsets.only(top: 130.0),
              //         child: Container(
              //           height: 50,
              //           width: 50,
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               border: Border.all(width: 3, color: Colors.white)),
              //           child: Builder(
              //             builder: (context) => FloatingActionButton(
              //                 backgroundColor: Colors.cyan,
              //                 heroTag: null,
              //                 onPressed: () {
              //                   opArt.saveToLocalDB();
              //                   Scaffold.of(context).removeCurrentSnackBar();
              //                   Scaffold.of(context).showSnackBar(SnackBar(
              //                       backgroundColor:
              //                           Colors.white.withOpacity(0.8),
              //                       duration: Duration(seconds: 2),
              //                       content: Container(
              //                         child: Container(
              //                           height: 70,
              //                           child: Center(
              //                             child: Text(
              //                               'Saved to My Gallery',
              //                               style: TextStyle(
              //                                   color: Colors.black,
              //                                   fontSize: 18),
              //                             ),
              //                           ),
              //                         ),
              //                       )));
              //                 },
              //                 child: Icon(Icons.save)),
              //           ),
              //         ),
              //       )
              //     : Container(),
              // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
                          rebuildMain.value++;
                          showDelete = false;
                          showControls = false;
                          showCustomColorPicker = false;
                          opArt.setDefault();
                          opArt.clearCache();
                          SystemChrome.setEnabledSystemUIOverlays(
                              SystemUiOverlay.values);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                        },
                      ),
                      actions: [
                        IconButton(
                            icon: Icon(Icons.save, color: Colors.black),
                            onPressed: () {
                              opArt.saveToLocalDB(false);
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        child: Container(
                                      height: 150,
                                      width: 200,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: (Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Saved to My \nGallery',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(height: 12),
                                                  RaisedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      rebuildMain.value++;
                                                      showDelete = false;
                                                      showControls = false;
                                                      showCustomColorPicker =
                                                          false;
                                                      opArt.setDefault();
                                                      opArt.clearCache();
                                                      SystemChrome
                                                          .setEnabledSystemUIOverlays(
                                                              SystemUiOverlay
                                                                  .values);
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MyGallery(
                                                                      savedOpArt
                                                                          .length,
                                                                      false)));
                                                    },
                                                    child:
                                                        Text('View My Gallery'),
                                                  )
                                                ])),
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Material(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CloseButton(),
                                              )))
                                        ],
                                      ),
                                    ));
                                  });
                            }),
                        IconButton(
                            icon: Icon(Icons.share, color: Colors.black),
                            onPressed: () async {
                              _paymentDialog();
                            }),
                      ],
                    )
                  : null,
              body: Stack(
                children: [
                  GestureDetector(
                      onDoubleTap: () {
                        if (!showSettings) {
                          opArt.randomizeSettings();
                          opArt.randomizePalette();
                          opArt.saveToCache();
                          enableButton = false;
                          rebuildCanvas.value++;
                        }
                      },
                      onTap: () {
                        if (changeSettingsView) {
                          changeSettingsView = false;
                          setState(() {
                            if (showSettings) {
                              slider = 100;
                              if (showCustomColorPicker) {
                                opArt.saveToCache();
                              }
                              showControls = false;
                              showSettings = false;

                              showCustomColorPicker = false;
                            } else {
                              showSettings = true;
                              showCustomColorPicker = false;
                            }
                          });
                          Future.delayed(const Duration(seconds: 1));
                          changeSettingsView = true;
                        }
                      },
                      child: Stack(
                        children: [
                          InteractiveViewer(
                            child: ClipRect(
                                child: CanvasWidget(
                              showSettings,
                            )),
                          ),
                          showProgressIndicator
                              ? Container(
                                  color: Colors.white.withOpacity(0.4),
                                  child: Center(
                                      child: CircularProgressIndicator()))
                              : Container()
                        ],
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
                                              itemCount:
                                                  opArt.cacheListLength(),
                                              reverse: false,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 4),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      opArt
                                                          .revertToCache(index);
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
                  showSettings ? TabWidget(choosePaletteTab) : Container(),
                  showSettings ? TabWidget(toolsTab) : Container(),
                  showSettings ? TabWidget(paletteTab) : Container(),
                  showCustomColorPicker
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: ColorPickerWidget())
                      : Container(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: showSettings
                        ? customBottomAppBar(context: context, opArt: opArt)
                        : BottomAppBar(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
