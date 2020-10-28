import 'dart:math';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'model.dart';
import 'opart_page.dart';
import 'package:flutter/scheduler.dart';

class CanvasWidget extends StatefulWidget {
  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

bool _playing = true;

double _timeDilation = 1;

class _CanvasWidgetState extends State<CanvasWidget>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  AnimationController playPauseController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 72000),
    );
    CurvedAnimation(parent: animationController, curve: Curves.linear);

    Tween<double> animationTween = Tween(begin: 0, end: 1);

    animation = animationTween.animate(animationController)
      ..addListener(() {
        rebuildCanvas.value++;
      });
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animationController.repeat();
    //   } else if (status == AnimationStatus.dismissed) {
    //     animationController.forward();
    //   }
    // });

    animationController.forward();
    playPauseController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  Hero hero1;
  Hero hero2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 40),
            child: FloatingActionButton(onPressed: () {
              animationController.reverse();

            }, child: Icon(Icons.fast_rewind)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
                heroTag: hero2,
                onPressed: () {
                  if (_playing) {
                    playPauseController.forward(from: 0);
                    _playing = false;
                    animationController.stop();
                  } else {
                    playPauseController.reverse();
                    _playing = true;
                    animationController.forward();
                  }
                },
                child: AnimatedIcon(
                    icon: AnimatedIcons.pause_play,
                    progress: playPauseController)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<int>(
                valueListenable: rebuildCanvas,
                builder: (context, value, child) {
                  return Screenshot(
                    controller: screenshotController,
                    child: Visibility(
                      visible: true,
                      child: LayoutBuilder(
                        builder: (_, constraints) => Container(
                          width: constraints.widthConstraints().maxWidth,
                          height: constraints.heightConstraints().maxHeight,
                          child: CustomPaint(
                            painter: OpArtPainter(seed, rnd, animation.value),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Slider(
            value: _timeDilation,
            min: 0.1,
            max: 3,
            onChanged: (value) {
              setState(() {
                _timeDilation = value;
                timeDilation = 1 / value;
              });
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
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
