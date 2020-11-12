import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:opart_v2/opart_page.dart';
import 'package:opart_v2/tabs/tab_tools.dart';

import '../model_opart.dart';

import 'tab_palette.dart';

int currentColor = 0;
bool isOpen = false;
AnimationController paletteAnimationController;
Animation paletteAnimation;

AnimationController toolsAnimationController;
Animation toolsAnimation;

class TabWidget extends StatefulWidget {
  double width;

  double tabHeight;
  IconData icon;
  bool palette;
  TabWidget(this.width, this.tabHeight, this.icon, this.palette);
  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  void openTab() {
    tabOut = true;
    widget.palette
        ? paletteAnimationController.forward()
        : toolsAnimationController.forward();
    rebuildOpArtPage.value++;
  }

  void closeTab() {
    currentTab = 10;
    toolsAnimation = Tween<double>(begin: 0, end: -widget.width)
        .animate(toolsAnimationController)
          ..addListener(() {
            rebuildTab.value++;
          });
    //  tabOut = false;
    widget.palette ? showCustomColorPicker = false : null;
    widget.palette
        ? paletteAnimationController.reverse()
        : toolsAnimationController.reverse();

    showSettings = true;
    rebuildOpArtPage.value++;
  }

  @override
  void initState() {
    if (widget.palette) {
      paletteAnimationController = AnimationController(
          duration: const Duration(milliseconds: 300), vsync: this);
      paletteAnimation = Tween<double>(begin: -widget.width, end: 0)
          .animate(paletteAnimationController)
            ..addListener(() {
              rebuildTab.value++;
            });
    } else {
      toolsAnimationController = AnimationController(
          duration: const Duration(milliseconds: 300), vsync: this);
      toolsAnimation = Tween<double>(begin: 0, end: -widget.width)
          .animate(toolsAnimationController)
            ..addListener(() {
              rebuildTab.value++;
            });
    }
  }

  @override
  void dispose() {
    widget.palette
        ? paletteAnimationController.dispose()
        : toolsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: rebuildTab,
        builder: (context, value, child) {
          return Positioned(
              top: 115,
              bottom: 0,
              //right: widget.left? null:MediaQuery.of(context).size.width,
              left: widget.palette
                  ? paletteAnimation.value
                  : MediaQuery.of(context).size.width -
                      45 +
                      toolsAnimation.value,
              child: WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      // swiping in right direction
                      widget.palette ? openTab() : closeTab();
                    }
                    if (details.delta.dx < 0) {
                      widget.palette ? closeTab() : openTab();
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.palette
                          ? Container(
                              color: Colors.white.withOpacity(0.8),
                              height: MediaQuery.of(context).size.height,
                              width: widget.width,
                              child: widget.palette
                                  ? PaletteTab(context)
                                  : ToolBoxTab())
                          : Container(),
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
                          child: RotatedBox(
                            quarterTurns: widget.palette ? 0 : 2,
                            child: ClipPath(
                              clipper: CustomMenuClipper(),
                              child: Container(
                                  color: Colors.white.withOpacity(0.8),
                                  height: 100,
                                  width: 45,
                                  child: RotatedBox(
                                    quarterTurns: widget.palette ? 0 : 2,
                                    child: Icon(widget.icon,
                                        color: Colors.cyan, size: 35),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      !widget.palette
                          ? Container(
                              color: Colors.white.withOpacity(0.8),
                              height: MediaQuery.of(context).size.height,
                              width: slider == 100
                                  ? widget.width
                                  : widget.width + 40,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 70.0),
                                child: widget.palette
                                    ? PaletteTab(context)
                                    : ToolBoxTab(),
                              ))
                          : Container(),
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
