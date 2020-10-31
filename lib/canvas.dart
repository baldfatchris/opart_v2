import 'dart:math';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'model.dart';
import 'opart_page.dart';
import 'package:flutter/scheduler.dart';

class CanvasWidget extends StatefulWidget {
  bool _fullScreen;
  CanvasWidget(this._fullScreen);
  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

bool playing = true;

double _timeDilation = 1;
AnimationController animationController;

class _CanvasWidgetState extends State<CanvasWidget>
    with TickerProviderStateMixin {
  Animation<double> currentAnimation;
 
  AnimationController playPauseController;
  @override
  void initState() {
   if(opArt.animation){ animationController = AnimationController(
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

    animationController.forward();}
    playPauseController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  Hero hero1;
  Hero hero2;
  bool _forward = true;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(

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
                          builder: (_, constraints) => Container(color: Colors.white,
                            width: constraints.widthConstraints().maxWidth,
                            height: constraints.heightConstraints().maxHeight,
                            child: CustomPaint(
                              painter: OpArtPainter(seed, rnd, opArt.animation?currentAnimation.value: 1),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  fullScreen
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          opArt.animation? Container(
                            height: 100,
                            color: Colors.white.withOpacity(0.5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Slider(
                                    value: _timeDilation,
                                    min: 0.1,
                                    max: 8,
                                    onChanged: (value) {
                                      setState(() {
                                        _timeDilation = value;
                                        timeDilation = 1 / value;
                                      });
                                    },
                                    onChangeEnd: (value) async {
                                      // await new Future.delayed(
                                      //     const Duration(seconds: 1));
                                      // setState(() {
                                      //   _showTools = false;
                                      // });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: FloatingActionButton(
                                      onPressed: () {
                                        if(_forward) {
                                          setState(() {
                                            animationController.reverse();
                                            _forward = false;
                                          });

                                        }
                                        else{
                                          setState(() {
                                            animationController.forward();
                                            _forward = true;
                                          });

                                        }
                                      },
                                      child: Icon(_forward? Icons.fast_rewind: Icons.fast_forward)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FloatingActionButton(
                                      heroTag: hero2,
                                      onPressed: () {
                                        if (playing) {
                                          playPauseController.forward(from: 0);
                                          playing = false;
                                          animationController.stop();
                                        } else {
                                          playPauseController.reverse();
                                          playing = true;
                                          animationController.forward();
                                        }
                                      },
                                      child: AnimatedIcon(
                                          icon: AnimatedIcons.pause_play,
                                          progress: playPauseController)),
                                ),
                              ],
                            ),
                          ): Container(),
                          widget._fullScreen
                              ? Container(height: 70)
                              : Container(),
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
  opArt.animation?  animationController.dispose():null;
    playPauseController.dispose();
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
    opArt.paint(canvas, size, seed, rnd, animationVariable);
  }

  @override
  bool shouldRepaint(OpArtPainter oldDelegate) => false;
}
