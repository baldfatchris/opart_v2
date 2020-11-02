import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.pinkAccent,
      ),
      home: ExampleScreen(),
    ),
  );
}

class ExampleScreen extends StatefulWidget {
  @override
  _ExampleScreenState createState() => new _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final _captureKey = GlobalKey<CaptureWidgetState>();
  Future<CaptureResult> _image;

  void _onCapturePressed() {
    setState(() {
      _image = _captureKey.currentState.captureImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CaptureWidget(
      key: _captureKey,
      capture: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'These widgets are not visible on the screen yet can still be captured by a RepaintBoundary.',
              ),
              SizedBox(height: 12.0),
              Container(
                width: 25.0,
                height: 25.0,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Widget To Image Demo'),
        ),
        body: FutureBuilder<CaptureResult>(
          future: _image,
          builder: (BuildContext context, AsyncSnapshot<CaptureResult> snapshot) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: RaisedButton(
                      child: Text('Capture Image'),
                      onPressed: _onCapturePressed,
                    ),
                  ),
                  if (snapshot.connectionState == ConnectionState.waiting)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (snapshot.hasData) ...[
                    Text(
                      '${snapshot.data.width} x ${snapshot.data.height}',
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 2.0),
                      ),
                      child: Image.memory(
                        snapshot.data.data,
                        scale: MediaQuery.of(context).devicePixelRatio,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CaptureWidget extends StatefulWidget {
  final Widget child;
  final Widget capture;

  const CaptureWidget({
    Key key,
    this.capture,
    this.child,
  }) : super(key: key);

  @override
  CaptureWidgetState createState() => CaptureWidgetState();
}

class CaptureWidgetState extends State<CaptureWidget> {
  final _boundaryKey = GlobalKey();

  Future<CaptureResult> captureImage() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final boundary = _boundaryKey.currentContext.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: pixelRatio);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return CaptureResult(data.buffer.asUint8List(), image.width, image.height);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight * 2;
        return Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            widget.child,
            Positioned(
              left: 0.0,
              right: 0.0,
              top: height,
              height: height,
              child: Center(
                child: RepaintBoundary(
                  key: _boundaryKey,
                  child: widget.capture,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CaptureResult {
  final Uint8List data;
  final int width;
  final int height;

  const CaptureResult(this.data, this.width, this.height);
}