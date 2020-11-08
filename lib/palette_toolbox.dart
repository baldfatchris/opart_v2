import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:opart_v2/opart_page.dart';
import 'settings_dialog.dart';
import 'model_opart.dart';
import 'model_palette.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'model_settings.dart';

import 'choose_palette.dart';

bool isOpen = false;
AnimationController paletteAnimationController;

class PaletteToolBox extends StatefulWidget {
  double width;
  PaletteToolBox(this.width);
  @override
  _PaletteToolBoxState createState() => _PaletteToolBoxState();
}

class _PaletteToolBoxState extends State<PaletteToolBox>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
double height = (numberOfColors.value.toDouble()+2)*30;
  @override
  void initState() {
    paletteAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: widget.width - 35, end: 0)
        .animate(paletteAnimationController)
          ..addListener(() {
            rebuildPalette.value++;
          });
  }

  @override
  void dispose() {
    paletteAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentColor = 0;
    _colorPicker() {
      return ColorPicker(
        displayThumbColor: true,
        pickerAreaHeightPercent: 0.2,
        //pickerAreaBorderRadius: BorderRadius.circular(10.0),
        pickerColor: opArt.palette.colorList[currentColor],
        onColorChanged: (color) {
          opArt.palette.colorList[currentColor] = color;
          rebuildCanvas.value++;
          rebuildPalette.value++;
        },
        showLabel: false,
      );
    }

    Widget _opacityWidget() {
      return Container(
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
      );
    }

    Widget _randomizeButton() {
      return FloatingActionButton(
          heroTag: null,
          child: Icon(Icons.refresh),
          onPressed: () {
            opArt.randomizePalette();
            rebuildPalette.value++;
            rebuildCanvas.value++;
            opArt.saveToCache();
          });
    }

    int paletteLength = opArt.palette.colorList.length;

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
              // right: _animation.value,
              right: 0,
              left: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      color: Colors.white.withOpacity(0.8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Container(height: 150, child: ChoosePalette()),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: _colorPicker(),
                          //     ),
                          //     Column(
                          //       children: [
                          //         _randomizeButton(),
                          //       ],
                          //     )
                          //   ],
                          // ),
                          Column(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    numberOfColors.value++;
                                    opArt.attributes
                                        .firstWhere((element) =>
                                            element.name == 'numberOfColors')
                                        .value = numberOfColors.value;
                                    if (numberOfColors.value > paletteLength) {
                                      String paletteType = opArt.attributes
                                          .firstWhere((element) =>
                                              element.name == 'paletteType')
                                          .value
                                          .toString();
                                      opArt.palette.randomize(
                                          paletteType, numberOfColors.value);
                                    }
                                    height = (numberOfColors.value.toDouble()+2)*30;
                                    if(height>MediaQuery.of(context).size.height * 0.7)
                                      {
                                        height = MediaQuery.of(context).size.height * 0.7;
                                      }
                                    rebuildPalette.value++;
                                    rebuildCanvas.value++;
                                  }),
                              Container(
                                height: height,
                                width: 30,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: numberOfColors.value,
                                    reverse: false,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          currentColor = index;
                                          rebuildPalette.value++;
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 30,
                                            color:
                                                opArt.palette.colorList[index]),
                                      );
                                    }),
                              ),
                              IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if(numberOfColors.value>2){
                                    numberOfColors.value--;
                                    if (numberOfColors.value > paletteLength) {
                                      opArt.palette.randomize(
                                          paletteType.value.toString(), numberOfColors.value);
                                    }
                                    height = (numberOfColors.value.toDouble()+2)*30;
                                    if(height>MediaQuery.of(context).size.height * 0.7)
                                    {
                                      height = MediaQuery.of(context).size.height * 0.7;
                                    }
                                    rebuildPalette.value++;
                                    rebuildCanvas.value++;}
                                  }),
                            ],
                          ),
                          // opacity.value != null
                          //     ? _opacityWidget()
                          //     : Container(),
                          // _numberOfColors(),
                        ],
                      )),
                  Align(
                    alignment: Alignment(0, -0.6),
                    child: GestureDetector(
                      onTap: () {
                        if (isOpen) {
                          paletteAnimationController.forward();
                          isOpen = false;
                        } else {
                          paletteAnimationController.reverse();
                          isOpen = true;
                        }
                      },
                      child: ClipPath(
                        clipper: CustomMenuClipper(),
                        child: Container(
                            color: Colors.white.withOpacity(0.8),
                            height: 100,
                            width: 35,
                            child: Icon(Icons.palette,
                                color: Colors.blue, size: 35)),
                      ),
                    ),
                  ),
                ],
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
