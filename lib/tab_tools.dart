import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:opart_v2/opart_page.dart';
import 'settings_dialog.dart';
import 'model_opart.dart';
import 'model_palette.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'model_settings.dart';
import 'dart:math';
import 'choose_palette.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


int currentColor = 0;
bool isOpen = false;

AnimationController paletteAnimationController;
void openPaletteTab() {
  showSettings = false;
  showChoosePaletteTab = false;
  showPaletteTab = true;
  paletteAnimationController.forward();
  rebuildOpArtPage.value++;
}

void closePaletteTab() {
  showSettings = false;
  showChoosePaletteTab = false;
  showPaletteTab = false;
  paletteAnimationController.reverse();
  rebuildOpArtPage.value++;
}
class ToolsTab extends StatefulWidget {
  double width;
  ToolsTab(this.width);
  @override
  _ToolsTabState createState() => _ToolsTabState();
}

class _ToolsTabState extends State<ToolsTab>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  double height = (numberOfColors.value.toDouble() + 2) * 30;
  @override
  void initState() {
    paletteAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
    Tween<double>(begin: -200, end: 0).animate(paletteAnimationController)
      ..addListener(() {
        rebuildPalette.value++;
      });
  }

  @override
  void dispose() {
    paletteAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _opacityWidget() {
      return RotatedBox(
        quarterTurns: 1,
        child: Container(
          height: 40,
          width: 150,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(
              Radius.circular(5),
            ),
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFffffff).withOpacity(0.2),
                  const Color(0xFF303030),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.00),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Slider(
            value: opacity.value,
            min: 0.2,
            max: 1.0,
            onChanged: (value) {
              opacity.value = value;
              rebuildPalette.value++;
            },
          ),
        ),
      );
    }

    Widget _randomizeButton() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          child: IconButton(
              color: Colors.black,
              icon: Icon(Icons.refresh),
              onPressed: () {
                opArt.randomizePalette();
                rebuildPalette.value++;
                rebuildCanvas.value++;
                opArt.saveToCache();
              }),
        ),
      );
    }

    int paletteLength = opArt.palette.colorList.length;
    List<SettingsModel> tools = opArt.attributes.where((element) => element.settingCategory==SettingCategory.tool).toList();

    Widget _numberOfColors() {
      return Row(children: [
        IconButton(
          icon: Icon(
            Icons.remove,
          ),
          onPressed: () {
            numberOfColors.value--;
            if (numberOfColors.value > paletteLength) {
              opArt.palette.randomize(
                  paletteType.value.toString(), numberOfColors.value);
            }
            rebuildPalette.value++;
            rebuildCanvas.value++;
          },
        ),
        Text('Number of colors'),
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {
            numberOfColors.value++;
            opArt.attributes
                .firstWhere((element) => element.name == 'numberOfColors')
                .value = numberOfColors.value;
            if (numberOfColors.value > paletteLength) {
              String paletteType = opArt.attributes
                  .firstWhere((element) => element.name == 'paletteType')
                  .value
                  .toString();
              opArt.palette.randomize(paletteType, numberOfColors.value);
            }

            rebuildPalette.value++;
            rebuildCanvas.value++;
          },
        ),
      ]);
    }

    return ValueListenableBuilder<int>(
        valueListenable: rebuildPalette,
        builder: (context, value, child) {
          return Positioned(
              top: 0,
              bottom: 0,
              //  right: _animation.value,
              right: 0,
              left: _animation.value,
              child: GestureDetector(
                onVerticalDragStart: (value) {
                  print('drag');
                  paletteAnimationController.reverse();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

             Container(color: Colors.white.withOpacity(1),
              height: MediaQuery.of(context).size.height,width: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8),
                    itemCount: tools.length,
                    itemBuilder: (BuildContext context, int index) {
                      return (tools[index].proFeature && !proVersion)
                          ?Stack(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: () {
                              //  Navigator.pop(context);
                                settingsDialog(context, tools[index], opArt);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  tools[index].icon,
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        height: 40,
                                        child: Text(
                                          tools[index].name,
                                          textAlign: TextAlign.center,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),Container(color: Colors.white.withOpacity(0.5)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Align(alignment: Alignment.topRight,child:(Icon(Icons.lock, color: Colors.cyan[200].withOpacity(0.8)))),
                          )
                        ],
                      )

                          :GestureDetector(
                        onTap: () {
                        //  Navigator.pop(context);

                          if (tools[index].silent != null && tools[index].silent){
                            // print('silent');
                            tools[index].onChange();
                            opArt.saveToCache();
                            rebuildCanvas.value++;
                          }
                          else {
                            settingsDialog(context, tools[index], opArt);
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            tools[index].icon,
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                  height: 40,
                                  child: Text(
                                    tools[index].label,
                                    textAlign: TextAlign.center,
                                  )),
                            )
                          ],
                        ),
                      );
                    }),
              )),
                    Align(
                      alignment: Alignment(0, -0.6),
                      child: GestureDetector(
                        onTap: () {

                          if (!isOpen) {
                            print(isOpen);
                            openPaletteTab();
                            isOpen = true;
                          } else {
                            closePaletteTab();
                            isOpen = false;
                          }
                        },
                        child: ClipPath(
                          clipper: CustomMenuClipper(),
                          child: Container(
                              color: Colors.white.withOpacity(0.8),
                              height: 100,
                              width: 45,
                              child: Icon(MdiIcons.tools,
                                  color: Colors.blue, size: 35)),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });

    // showModalBottomSheet(
    //     backgroundColor: Colors.white.withOpacity(0.8),
    //     context: context,
    //     builder: (BuildContext bc) {
    //       return ValueListenableBuilder<int>(
    //           valueListenable: rebuildPalette,
    //           builder: (context, value, child) {
    //             return Container(
    //                 child: );
    //           });
    //     }).then((value) {
    //   opArt.saveToCache();
    // });
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
