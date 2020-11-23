import 'dart:math';
import 'main.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'model_opart.dart';
import 'opart_page.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'model_settings.dart';

class CanvasWidget extends StatefulWidget {
  bool _fullScreen;
  CanvasWidget(this._fullScreen);
  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

bool showControls = false;
AnimationController animationController;

class _CanvasWidgetState extends State<CanvasWidget>
    with TickerProviderStateMixin {
  bool playing = true;
  Animation<double> currentAnimation;
  double _timeDilation = 1;

  @override
  void initState() {
    bool playing = true;
    _forward = true;
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
    rebuildCircularProgressIndicator.value = 2;
    super.initState();
  }

  Hero hero1;
  Hero hero2;
  bool _forward = true;

  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _baseScaleFactor = _scaleFactor;
        print('onScaleStart');
      },
      onScaleUpdate: (details){
        print('onScaleUpdate');
        _scaleFactor = _baseScaleFactor * details.scale;
        SettingsModel zoomOpArt = opArt.attributes.firstWhere((element) => element.name=='zoomOpArt');
        if (zoomOpArt != null){
          double zoom = zoomOpArt.value * details.scale /_baseScaleFactor;
          zoom = (zoom < zoomOpArt.min) ? zoomOpArt.min : zoom;
          zoom = (zoom > zoomOpArt.max) ? zoomOpArt.max : zoom;
          zoomOpArt.value = zoom;
          rebuildCanvas.value++;
        }
      },
      onScaleEnd: (details){
        opArt.saveToCache();
        rebuildCanvas.value++;
      },

      onDoubleTap: (){
        if (!showSettings) {
          opArt.randomizeSettings();
          opArt.randomizePalette();
          opArt.saveToCache();
          enableButton = false;
          rebuildCanvas.value++;
        }
      },
      child: Stack(
        children: [
          ValueListenableBuilder<int>(
              valueListenable: rebuildCanvas,
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Screenshot(
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
                    ),


                  ],
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
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      showControls
                                          ? RotatedBox(
                                              quarterTurns: 2,
                                              child: _controlButton(
                                                Icons.fast_forward,
                                                () {
                                                  if (timeDilation < 8) {
                                                    timeDilation =
                                                        timeDilation * 2;
                                                  }
                                                },
                                                playing ? true : false,
                                              ))
                                          : Container(),
                                      showControls
                                          ? RotatedBox(
                                              quarterTurns: 2,
                                              child: _controlButton(
                                                  Icons.play_arrow, () {
                                                setState(() {
                                                  animationController.reverse();
                                                  playing = true;
                                                  _forward = false;
                                                });
                                              }, _forward ? true : false))
                                          : Container(),
                                      showControls
                                          ? _controlButton(Icons.pause, () {
                                              if (animationController != null) {
                                                setState(() {
                                                  animationController.stop();
                                                  playing = false;
                                                });
                                              }
                                            }, playing ? true : false)
                                          : Container(),
                                      showControls
                                          ? _controlButton(
                                              Icons.play_arrow,
                                              () {
                                                setState(() {
                                                  animationController.forward();
                                                  playing = true;
                                                  _forward = true;
                                                });
                                              },
                                              !_forward || !playing
                                                  ? true
                                                  : false,
                                            )
                                          : Container(),
                                      showControls
                                          ? _controlButton(
                                              Icons.fast_forward,
                                              () {
                                                if (timeDilation > 0.2) {
                                                  timeDilation =
                                                      timeDilation / 2;
                                                }
                                              },
                                              playing ? true : false,
                                            )
                                          : Container(),
                                      _controlButton(
                                          showControls
                                              ? Icons.close
                                              : MdiIcons.playPause, () {
                                        setState(() {
                                          showControls = !showControls;
                                        });
                                      }, true),
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
          // ValueListenableBuilder<int>(
          //     valueListenable: rebuildCircularProgressIndicator,
          //     builder: (context, value, child) {
          //       print(rebuildCircularProgressIndicator.value);
          //       if (rebuildCircularProgressIndicator.value.isEven) {
          //         return Center(
          //             child:
          //             CircularProgressIndicator(strokeWidth: 8, ));
          //       } else {
          //         return Container();
          //       }
          //     }),
        ],
      ),
    );
  }

  Widget _controlButton(IconData icon, Function onPressed, bool active) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: Colors.white)),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: FloatingActionButton(
            backgroundColor: active ? Colors.cyan : Colors.grey,
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
