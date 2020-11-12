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

class TabWidget extends StatefulWidget {

  double width;
  AnimationController animationController;
  Widget content;
  double tabHeight;
  IconData icon;
  bool left;
  TabWidget(this.width, this.animationController, this.content, this.tabHeight,
      this.icon, this.left );
  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  void openTab() {tabOut = true;
  //  showSettings = false;

    animationController.forward();
    rebuildOpArtPage.value++;
  }

  void closeTab() {
    currentTab = 10;
  //  tabOut = false;
    animationController.reverse();
    showSettings = true;
    rebuildOpArtPage.value++;
  }

  Animation<double> _animation;
  @override
  void initState() {
    animationController = widget.animationController;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        Tween<double>(begin: widget.left? -widget.width:0, end: widget.left? 0:-widget.width ).animate(animationController)
          ..addListener(() {
            rebuildTab.value++;
          });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<int>(
        valueListenable: rebuildTab,
        builder: (context, value, child) {
          return Positioned(
              top: 115,
              bottom: 70,
              //right: widget.left? null:MediaQuery.of(context).size.width,
              left: widget.left?_animation.value: MediaQuery.of(context).size.width-45+_animation.value,
              child: WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: GestureDetector(
                 onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      // swiping in right direction
                      widget.left? openTab(): closeTab();
                    }
                    if(details.delta.dx<0){
                      widget.left?  closeTab():openTab();
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.left?
                      Container(
                          color: Colors.white.withOpacity(0.8),
                          height: MediaQuery.of(context).size.height,
                          width: widget.width,
                          child: widget.content):Container(),
                      Align(
                        alignment: Alignment(0, widget.tabHeight),
                        child: GestureDetector(
                          onTap: () {
                            if (!isOpen) {
                              openTab();
                              isOpen = true;
                            } else {
                              closeTab();
                              isOpen = false;
                            }
                          },
                          child: RotatedBox(quarterTurns: widget.left?0: 2,
                            child: ClipPath(
                              clipper: CustomMenuClipper(),
                              child: Container(
                                  color: Colors.white.withOpacity(0.8),
                                  height: 100,
                                  width: 45,
                                  child: RotatedBox(quarterTurns:widget.left?0: 2,
                                    child: Icon(widget.icon,
                                        color: Colors.blue, size: 35),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      !widget.left?
                      Container(
                          color: Colors.white.withOpacity(0.8),
                          height: MediaQuery.of(context).size.height,
                          width: widget.width,
                          child: widget.content):Container(),
                    ],
                  ),
                ),
              ));
        });
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
