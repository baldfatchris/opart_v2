import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
import 'package:shake/shake.dart';
import 'main.dart';

import 'package:opart_v2/tabs/color_picker_widget.dart';
import 'bottom_app_bar.dart';
import 'model_opart.dart';
import 'download_high_resolution.dart';
import 'canvas.dart';
import 'tabs/tab_widget.dart';

import 'dart:async';
import 'package:purchases_flutter/purchases_flutter.dart';


class OpArtPage extends StatefulWidget {
  OpArtType opArtType;
  Map<String, dynamic> opArtSettings;
  OpArtPage(this.opArtType, {this.opArtSettings});
  @override
  _OpArtPageState createState() => _OpArtPageState();
}

int currentTab = -1;

bool showSettings = false;
bool tabOut = false;
File imageFile;
bool showCustomColorPicker = false;
OpArt opArt;

bool highDefDownloadAvailable = false;
String highDefPrice;

class _OpArtPageState extends State<OpArtPage> {
  @override
  void initState() {
    opArt = OpArt(opArtType: widget.opArtType);
    if(widget.opArtSettings != null){
      seed = widget.opArtSettings['seed'];
      for (int i = 0; i < opArt.attributes.length; i++) {
        opArt.attributes[i].value = widget.opArtSettings[opArt.attributes[i].label];
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
        setState(() {
          imageFile = image;
        });

        // find the product
        print(offerings.current.availablePackages);
        Package p0001 = offerings.current.availablePackages.firstWhere((element) => element.product.identifier == "p0001");
        if (p0001 != null){
          highDefDownloadAvailable = true;
          highDefPrice = p0001.product.priceString;
          print('highDefPrice: $highDefPrice');
        }


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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        Flexible(flex: 2,
                            child: Text('Low definition - suitable for sharing.')),
                        Flexible(
                          child: FloatingActionButton(onPressed:() async {
                          },
                            child: Text('Free!'),
                          ),
                        )

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.file(
                              image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Flexible(flex: 2, child: Text('High definition -  suitable for printing.')),
                        Flexible(
                          child: FloatingActionButton(onPressed:() async {

                            print('buy the thing!');
                            try {
                              Purchases.setFinishTransactions(true);
                              PurchaserInfo purchaserInfo = await Purchases.purchasePackage(p0001);
                              print('Bought it!!');
                              print(purchaserInfo.allPurchasedProductIdentifiers);
                              // if (purchaserInfo.entitlements.all["my_entitlement_identifier"].isActive) {
                              //   // Unlock that great "pro" content
                              // }

                              List<String> purchases = purchaserInfo.allPurchasedProductIdentifiers;
                              purchases.forEach((element) {
                                if (element == 'p0001'){
                                  // Process the high definition download
                                  print('you can now download the image');
                                }
                              });

                            } on PlatformException catch (e) {
                              var errorCode = PurchasesErrorHelper.getErrorCode(e);
                              if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
                                print(e);
                              }
                            }
                          },
                            child: Text(highDefPrice),
                          ),
                        )

                      ],
                    ),
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
            floatingActionButton: showSettings? Padding(
              padding: const EdgeInsets.only(top: 130.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: Colors.white)),
                child: Builder(
                  builder: (context) => FloatingActionButton(
                      backgroundColor: Colors.cyan,
                      heroTag: null,
                      onPressed: () {
                        opArt.saveToLocalDB();
                        Scaffold.of(context).removeCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.white.withOpacity(0.8),
                            duration: Duration(seconds: 2),
                            content: Container(
                              child: Container(
                                height: 70,
                                child: Center(
                                  child: Text(
                                    'Saved to My Gallery',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ),
                            )));
                      },
                      child: Icon(Icons.save)),
                ),
              ),
            ): Container(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
                                    pixelRatio: 2)
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
                          if (showCustomColorPicker) {
                            opArt.saveToCache();
                          }
                          showControls = false;
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

                // showSettings || currentTab == 0
                //     ? TabWidget(80, animationController, ChoosePaletteTab(),
                //         -0.5, Icons.portrait, 0)
                //     : Container(),
                showSettings || tabOut
                    ? TabWidget(50, 0.2, Icons.palette, true)
                    : Container(),
                showSettings || tabOut
                    ? TabWidget(90, -0.5, MdiIcons.tools, false)
                    : Container(),
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
          );
        });
  }
}
