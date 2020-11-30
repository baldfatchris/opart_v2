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

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  GeneralTab tab;


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: rebuildTab,
        builder: (context, value, child) {
          return Positioned(
            left: tab.left
                ? tab.animation.value - tab.width
                : MediaQuery.of(context).size.width -
                    tab.width +
                    (tab.width - tab.animation.value) -
                    45,
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 120, bottom: 70.0),
              child: GestureDetector(onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      tab.left ? tab.openTab() : tab.closeTab();

                    }
                    if (details.delta.dx < 0) {
                      tab.left ? tab.closeTab() : tab.openTab();

                    }},
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
    return ClipRRect(borderRadius: BorderRadius.circular(30),
      child: Container(color: Colors.white.withOpacity(0.8),
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
    tab.animationController =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    tab.animation =
        Tween<double>(begin: 0, end: tab.width).animate(tab.animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              tab.open = true;
              rebuildOpArtPage.value++;
            }
            if (status == AnimationStatus.dismissed) {
              tab.open = false;
              tab.startOpening = false;
              rebuildOpArtPage.value++;
            }
          });


    super.initState();
  }
}

// class TabWidget extends StatefulWidget {
// GeneralTab tab;
//   TabWidget(this.tab);
//   @override
//   _TabWidgetState createState() => _TabWidgetState();
// }
//
// class _TabWidgetState extends State<TabWidget>
//     with SingleTickerProviderStateMixin {
//   GeneralTab tab;
//   @override
//   void initState() {
//      // tab = widget.tab;
//      //  tab.animationController = AnimationController(
//      //      duration: const Duration(milliseconds: 500), vsync: this);
//      //  tab.animation = Tween<double>(begin: tab.left? -tab.width: 0, end: tab.left? 0: tab.width)
//      //      .animate(animationController)
//      //        ..addListener(() {
//      //          tab.rebuildTab.value++;
//      //        });
// super.initState();
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<int>(
//         valueListenable: tab.rebuildTab,
//         builder: (context, value, child) {
//           return Positioned(
//               top: 0,
//               bottom: 0,
//               //right: widget.left? null:MediaQuery.of(context).size.width,
//
//               // left: tab.left?
//               //      tab.animation.value
//               //     : MediaQuery.of(context).size.width -
//               //         45 +
//               //         tab.animation.value,
//               child: WillPopScope(
//                 onWillPop: () async {
//                   return false;
//                 },
//                 child: GestureDetector(
//                   onPanUpdate: (details) {
//                     if (details.delta.dx > 0) {
//                       tab.left ? tab.openTab() : tab.closeTab();
//                     }
//                     if (details.delta.dx < 0) {
//                       tab.left ? tab.closeTab() : tab.openTab();
//                     }
//                   },
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 120,
//                         width: tab.width + 45,
//                       ),
//                       Expanded(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             tab.left
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(30),
//                                       color: Colors.white.withOpacity(0.8),
//                                     ),
//                                     height: MediaQuery.of(context).size.height,
//                                     width: tab.width,
//                                     child: tab.left
//                                         ? paletteTabWidget(context)
//                                         : ToolBoxTab())
//                                 : Container(),
//                             Align(
//                               alignment: Alignment(0, tab.tabHeight),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   if (!tab.open) {
//                                     tab.openTab();
//                                     tab.open = true;
//                                   } else {
//                                     tab.closeTab();
//                                     tab.open = false;
//                                   }
//                                 },
//                                 child: RotatedBox(
//                                   quarterTurns: tab.left ? 0 : 2,
//                                   child: ClipPath(
//                                     clipper: CustomMenuClipper(),
//                                     child: Container(
//                                         color: Colors.white.withOpacity(0.8),
//                                         height: 100,
//                                         width: 45,
//                                         child: RotatedBox(
//                                           quarterTurns: tab.left ? 0 : 2,
//                                           child: Icon(tab.icon,
//                                               color: Colors.cyan, size: 35),
//                                         )),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             !tab.left
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                     child: Container(
//                                         color: Colors.white.withOpacity(0.8),
//                                         height:
//                                             MediaQuery.of(context).size.height,
//                                         width: slider == 100
//                                             ? tab.width
//                                             : tab.width + 40,
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 0.0),
//                                           child: tab.left
//                                               ? paletteTabWidget(context)
//                                               : ToolBoxTab(),
//                                         )),
//                                   )
//                                 : Container(),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                       ),
//                     ],
//                   ),
//                 ),
//               ));
//         });
//   }
// }
//
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
