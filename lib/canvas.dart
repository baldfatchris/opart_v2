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
bool showControls = false;
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
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      showControls
                                          ?RotatedBox(
                                          quarterTurns: 2,
                                          child: _controlButton(
                                              Icons.fast_forward, () {
                                            if (timeDilation < 8) {
                                              timeDilation = timeDilation * 2;
                                            }
                                          })): Container(),
                                      showControls
                                          ?RotatedBox(
                                          quarterTurns: 2,
                                          child: _controlButton(
                                              Icons.play_arrow, () {
                                            animationController.reverse();
                                          })): Container(),
                                      showControls
                                          ?_controlButton(Icons.pause, () {
                                        if (animationController != null) {
                                          animationController.stop();
                                        }
                                      }): Container(),
                                      showControls
                                          ?_controlButton(Icons.play_arrow, () {
                                        animationController.forward();
                                      }): Container(),
                                      showControls
                                          ?_controlButton(
                                        Icons.fast_forward,
                                        () {
                                          if (timeDilation > 0.2) {
                                            timeDilation = timeDilation / 2;
                                          }
                                        },
                                      ): Container(), _controlButton(
                                          showControls
                                              ? Icons.close
                                              : MdiIcons.playPause, () {
                                        setState(() {
                                          showControls = !showControls;
                                        });


                                      }),
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

  Widget _controlButton(IconData icon, Function onPressed) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: FloatingActionButton(
            backgroundColor: Colors.cyan,
            heroTag: null,
            onPressed: () {
              onPressed();
            },
            child: Icon(icon)),
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
