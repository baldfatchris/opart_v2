import 'dart:math';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'model_opart.dart';
import 'opart_page.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CanvasWidget extends StatefulWidget {
  bool _fullScreen;
  CanvasWidget(this._fullScreen);
  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

bool playing = true;


AnimationController animationController;


class _CanvasWidgetState extends State<CanvasWidget>
    with TickerProviderStateMixin {
  Animation<double> currentAnimation;
  double _timeDilation = 1;

  @override
  void initState() {
    timeDilation = 1;

    if (opArt.animation) {
      animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 72000),
      );
      CurvedAnimation(parent: animationController, curve: Curves.linear);

      Tween<double> animationTween = Tween(begin: 0, end: 1);

      currentAnimation = animationTween.animate(animationController)
        ..addListener(() {
          rebuildCanvas.value++;
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animationController.repeat();
          } else if (status == AnimationStatus.dismissed) {
            animationController.forward();
          }
        });

      animationController.forward();
    }

  }

  Hero hero1;
  Hero hero2;
  bool _forward = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          ValueListenableBuilder<int>(
              valueListenable: rebuildCanvas,
              builder: (context, value, child) {
                return Screenshot(
                  controller: screenshotController,
                  child: Visibility(
                    visible: true,
                    child: LayoutBuilder(
                      builder: (_, constraints) => Container(
                        color: Colors.white,
                        width: constraints.widthConstraints().maxWidth,
                        height: constraints.heightConstraints().maxHeight,
                        child: CustomPaint(
                          painter: OpArtPainter(seed, rnd,
                              opArt.animation ? currentAnimation.value : 1),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          showSettings
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      opArt.animation
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Expanded(
                                      //   child: Slider(
                                      //     value: _timeDilation,
                                      //     min: 0.1,
                                      //     max: 8,
                                      //     onChanged: (value) {
                                      //       setState(() {
                                      //         _timeDilation = value;
                                      //         timeDilation = 1 / value;
                                      //       });
                                      //     },
                                      //     onChangeEnd: (value) async {
                                      //       // await new Future.delayed(
                                      //       //     const Duration(seconds: 1));
                                      //       // setState(() {
                                      //       //   _showTools = false;
                                      //       // });
                                      //     },
                                      //   ),
                                      // ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: FloatingActionButton(backgroundColor: Colors.cyan,
                                            heroTag: null,
                                            onPressed: () {
                                              if (timeDilation < 8) {
                                                timeDilation = timeDilation * 2;
                                              }
                                            },
                                            child: Transform.rotate(angle: pi, child: Icon(Icons.fast_forward))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: FloatingActionButton(backgroundColor: Colors.cyan,
                                          heroTag: null,
                                          onPressed: () {
                                            animationController.reverse();
                                          },
                                          child: Transform.rotate(
                                              angle: pi,
                                              child: Icon(Icons.play_arrow)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: FloatingActionButton(backgroundColor: Colors.cyan,
                                            heroTag: null,
                                            onPressed: () {
                                           animationController?.stop();
                                            },
                                            child: Icon(Icons.pause)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: FloatingActionButton(backgroundColor: Colors.cyan,
                                            heroTag: null,
                                            onPressed: () {
                                              animationController.forward();
                                            },
                                            child: Icon(Icons.play_arrow)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: FloatingActionButton(backgroundColor: Colors.cyan,
                                            heroTag: null,
                                            onPressed: () {
                                              if (timeDilation > 0.2) {
                                                timeDilation = timeDilation / 2;
                                              }
                                            },
                                            child: Icon(Icons.fast_forward)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      widget._fullScreen ? Container(height: 70) : Container(),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    opArt.animation ? animationController.dispose() : null;
    super.dispose();
  }
}

class OpArtPainter extends CustomPainter {
  int seed;
  Random rnd;
  double animationVariable;
  // double fill;

  OpArtPainter(
    this.seed,
    this.rnd,
    this.animationVariable,
    // this.fill
  );

  @override
  void paint(Canvas canvas, Size size) {
    opArt.paint(canvas, size, seed, animationVariable);
  }

  @override
  bool shouldRepaint(OpArtPainter oldDelegate) => false;
}
