import 'dart:math';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'model.dart';
import 'opart_page.dart';

class CanvasWidget extends StatefulWidget {
  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

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
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
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
                  child:
                  CustomPaint(
                    painter: OpArtPainter(seed, rnd, animation.value),
                  ),
                ),
              ),
            ),
          );
        });
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