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
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 72000),
    );
    CurvedAnimation(parent: controller, curve: Curves.linear);

    Tween<double> _angleTween = Tween(begin: 0, end: 2 * pi);

    animation = _angleTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
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
    controller.dispose();
    super.dispose();
  }
}
class OpArtPainter extends CustomPainter {
  int seed;
  Random rnd;
  double angle;
  // double fill;

  OpArtPainter(
      this.seed,
      this.rnd,
      this.angle,
      // this.fill
      );

  @override
  void paint(Canvas canvas, Size size) {
    opArt.paint(canvas, size, seed, rnd, angle);
  }
  @override
  bool shouldRepaint(OpArtPainter oldDelegate) => false;
}