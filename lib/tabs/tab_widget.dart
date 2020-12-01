import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:opart_v2/opart_page.dart';
import 'package:opart_v2/tabs/general_tab.dart';
import 'package:opart_v2/tabs/tools_widget.dart';

import '../canvas.dart';
import '../model_opart.dart';

import 'palette_widget.dart';

class TabWidget extends StatefulWidget {
  GeneralTab tab;
  TabWidget(this.tab);
  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  GeneralTab tab;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: rebuildTab,
        builder: (context, value, child) {
          return AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: tab.left ? tab.position : null,
            right: tab.left ? null : tab.position,
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 120, bottom: 70.0),
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx > 0) {
                    tab.left ? tab.openTab() : tab.closeTab();
                  }
                  if (details.delta.dx < 0) {
                    tab.left ? tab.closeTab() : tab.openTab();
                  }
                },
                child: Row(
                  children: [
                    tab.left ? contentWidget(tab) : Container(),
                    tabWidget(tab),
                    !tab.left ? contentWidget(tab) : Container(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget contentWidget(GeneralTab tab) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
          color: Colors.white.withOpacity(0.8),
          width: tab.width,
          child: tab.content()),
    );
  }

  Widget tabWidget(GeneralTab tab) {
    return Align(
      alignment: Alignment(0, tab.tabHeight),
      child: GestureDetector(
        onTap: () {
          tab.open ? tab.closeTab() : tab.openTab();
        },
        child: RotatedBox(
          quarterTurns: tab.left ? 0 : 2,
          child: ClipPath(
            clipper: CustomMenuClipper(),
            child: Container(
                color: Colors.white.withOpacity(0.8),
                height: 100,
                width: 45,
                child: Icon(tab.icon, color: Colors.cyan, size: 35)),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    tab = widget.tab;
    super.initState();
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
