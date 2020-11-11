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

int currentColor = 0;
bool isOpen = false;
AnimationController choosePaletteAnimationController;
void openChoosePaletteTab() {
  showSettings = false;
  showChoosePaletteTab = true;
  showPaletteTab = false;
  choosePaletteAnimationController.forward();
  rebuildOpArtPage.value++;
}

void closeChoosePaletteTab() {
  showSettings = false;
  showChoosePaletteTab = false;
  showPaletteTab = false;
  choosePaletteAnimationController.reverse();
  rebuildOpArtPage.value++;
}

class ChoosePaletteTab extends StatefulWidget {

  ChoosePaletteTab();
  @override
  _ChoosePaletteTabState createState() => _ChoosePaletteTabState();
}

class _ChoosePaletteTabState extends State<ChoosePaletteTab>
    with SingleTickerProviderStateMixin {
  final double width = 120;
  Animation<double> _animation;

  @override
  void initState() {
    choosePaletteAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: -width, end: 0)
        .animate(choosePaletteAnimationController)
          ..addListener(() {
            rebuildPalette.value++;
          });
  }

  @override
  void dispose() {
    choosePaletteAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  choosePaletteAnimationController.reverse();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () {
                          showCustomColorPicker = false;
                          rebuildOpArtPage.value++;
                        },
                        child: Container(
                            color: Colors.white.withOpacity(0.8),
                            width: width,
                            height: MediaQuery.of(context).size.height,
                            child: ChoosePalette())),
                    Align(
                      alignment: Alignment(0, -0.3),
                      child: GestureDetector(
                        onTap: () {
                          if (!isOpen) {
                            openChoosePaletteTab();
                            isOpen = true;
                          } else {
                            closeChoosePaletteTab();
                            isOpen = false;
                          }
                        },
                        child: ClipPath(
                          clipper: CustomMenuClipper(),
                          child: Container(
                              color: Colors.white.withOpacity(0.8),
                              height: 100,
                              width: 45,
                              child: Icon(Icons.photo,
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
