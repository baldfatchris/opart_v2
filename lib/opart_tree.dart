import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:io';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share/share.dart';

//void main() {
//  runApp(OpArtTree());
//}
File _imageFile;

//Create an instance of ScreenshotController
ScreenshotController screenshotController = ScreenshotController();
List palette = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.white,
  Colors.redAccent,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.deepPurpleAccent,
  Colors.indigoAccent,
  Colors.blueAccent,
  Colors.lightBlueAccent,
  Colors.cyanAccent,
  Colors.tealAccent,
  Colors.greenAccent,
  Colors.lightGreenAccent,
  Colors.limeAccent,
  Colors.yellowAccent,
  Colors.amberAccent,
  Colors.orangeAccent,
  Colors.deepOrangeAccent,
];
Color backgroundColor = Color(0xff638965);
void changeColor(int index, Color color) {
  palette.replaceRange(index, index + 1, [color]);
}

double trunkWidth = 10.0;
double widthDecay = 0.92;
double segmentLength = 35.0;
double segmentDecay = 0.92;
double branch = 0.7;
double angle = 0.5;
double ratio = 0.7;

class OpArtTreeStudio extends StatefulWidget {
  bool showSettings;
  OpArtTreeStudio(this.showSettings);

  @override
  _OpArtTreeStudioState createState() => _OpArtTreeStudioState();
}

bool _showBackgroundColorPicker = false;

class _OpArtTreeStudioState extends State<OpArtTreeStudio> {
  int _counter = 0;
  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  int _currentColor = 0;
  Widget settingsWidget() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            'Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text('Background Color'),
            IconButton(
              icon: Icon(_showBackgroundColorPicker
                  ? Icons.arrow_drop_up
                  : Icons.arrow_drop_down),
              onPressed: () {
                setState(() {
                  _showBackgroundColorPicker = !_showBackgroundColorPicker;
                });
              },
            )
          ],
        ),
        _showBackgroundColorPicker
            ? ColorPicker(
                displayThumbColor: false,
                pickerAreaHeightPercent: 0.3,
                pickerAreaBorderRadius: BorderRadius.circular(10.0),
                pickerColor: backgroundColor,
                onColorChanged: (color) {
                  setState(() {
                    backgroundColor = color;
                  });
                },
                showLabel: false,
              )
            : Container(),
        Text('Trunk Width'),
        Slider(
          value: trunkWidth,
          min: 0,
          max: 15,
          onChanged: (value) {
            setState(() {
              trunkWidth = value;
            });
          },
          label: '$trunkWidth',
        ),
        Text('Width Decay'),
        Slider(
          value: widthDecay,
          min: 0,
          max: 0.99,
          onChanged: (value) {
            setState(() {
              widthDecay = value;
            });
          },
          label: '$widthDecay',
        ),
        Text('Segment Length'),
        Slider(
          value: segmentLength,
          min: 20,
          max: 40,
          onChanged: (value) {
            setState(() {
              segmentLength = value;
            });
          },
          label: '$segmentLength',
        ),
        Container(
          height: 200,
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            scrollDirection: Axis.horizontal,
            itemCount: palette.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentColor = index;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border:
                              Border.all(width: _currentColor == index ? 3 : 0),
                          color: palette[index]),
                      height: 50,
                      width: 50),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        ColorPicker(
          displayThumbColor: false,
          pickerAreaHeightPercent: 0.3,
          pickerAreaBorderRadius: BorderRadius.circular(10.0),
          pickerColor: palette[_currentColor],
          onColorChanged: (color) {
            setState(() {
              changeColor(_currentColor, color);
            });
          },
          showLabel: false,
        ),
      ],
    );
  }

  Random rnd;

  @override
  void initState() {
    rnd = Random(1001);
  }

  Widget bodyWidget() {
    return Screenshot(
      controller: screenshotController,
      child: Stack(
        children: [
          Visibility(
            visible: true,
            child: LayoutBuilder(
              builder: (_, constraints) => Container(
                width: constraints.widthConstraints().maxWidth,
                height: constraints.heightConstraints().maxHeight,
                child: CustomPaint(painter: OpArtTreePainter(rnd)),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //we need this because there are two floating action buttons so each one needs a herotag.
    Hero btn1;
    _saved(File image) async {
      final result = await ImageGallerySaver.saveImage(image.readAsBytesSync());
      print("File Saved to Gallery");
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
        heroTag: btn1,
        onPressed: () {
          _imageFile = null;
          screenshotController
              .capture(delay: Duration(milliseconds: 0))
              .then((File image) async {
            setState(() {
              _imageFile = image;
              Share.shareFiles([_imageFile.path]);
            });

          });

        },
        tooltip: 'Increment',
        child: Icon(Icons.camera_alt),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 7,
            child: widget.showSettings
                ? Column(
                    children: [
                      Flexible(flex: 3, child: bodyWidget()),
                      Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: settingsWidget(),
                          )),
                    ],
                  )
                : bodyWidget(),
          ),
          Flexible(
              flex: 1,
              child: _imageFile != null ? Image.file(_imageFile) : Container()),
        ],
      ),
    );
  }
}

class OpArtTreePainter extends CustomPainter {
  Random rnd;
  OpArtTreePainter(this.rnd);
  @override
  void paint(Canvas canvas, Size size) {
    // define the paint object

    double canvasWidth = size.width;
    double canvasHeight = size.height;

    double aspectRatio = 1;
    double borderX = 0;
    double borderY = 0;
    double imageWidth = canvasWidth;
    double imageHeight = canvasHeight;

    if (canvasWidth / canvasHeight < aspectRatio) {
      borderY = (canvasHeight - canvasWidth / aspectRatio) / 2;
      imageHeight = imageWidth / aspectRatio;
    } else {
      borderX = (canvasWidth - canvasHeight * aspectRatio) / 2;
      imageWidth = imageHeight * aspectRatio;
    }

//    print('width: ${canvasWidth}');
//    print('height: ${canvasHeight}');
//    print('canvasWidth / canvasHeight = ${canvasWidth / canvasHeight}');
//    print('aspectRatio = $aspectRatio');
//    print('borderX = $borderX');
//    print('borderY = $borderY');
//    print('imageWidth = $imageWidth');
//    print('imageHeight = $imageHeight');

    // colour in the canvas
    var paint1 = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    //a rectangle
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight), paint1);

    double direction = pi / 2;

    double lineWidth = 2;
    Color trunkLineColor = Colors.grey[900];
    Color trunkFillColor = Colors.grey[800];

    double bulbousness = 2.5;
    int maxDepth = 20;
    int leavesAfter = 5;

    double leafAngle = 0.5;
    double leafLength = 8;
    double randomLeafLength = 3.0;
    double leafSquareness = 1;
    double leafDecay = 1.01;
    String leafStyle = 'quadratic';

    List treeBaseA = [(canvasWidth - trunkWidth) / 2, canvasHeight];
    List treeBaseB = [(canvasWidth + trunkWidth) / 2, canvasHeight];

    drawSegment(
        canvas,
        borderX,
        borderY,
        treeBaseA,
        treeBaseB,
        trunkWidth,
        branch,
        angle,
        ratio,
        widthDecay,
        segmentLength,
        segmentDecay,
        direction,
        0,
        maxDepth,
        leavesAfter,
        lineWidth,
        trunkLineColor,
        trunkFillColor,
        bulbousness,
        palette,
        leafAngle,
        leafLength,
        randomLeafLength,
        leafSquareness,
        leafDecay,
        leafStyle,
        false);
  }

  drawSegment(
    Canvas canvas,
    double borderX,
    double borderY,
    List rootA,
    List rootB,
    double width,
    double branch,
    double angle,
    double ratio,
    double widthDecay,
    double segmentLength,
    double segmentDecay,
    double direction,
    int currentDepth,
    int maxDepth,
    int leavesAfter,
    double lineWidth,
    Color trunkLineColor,
    Color trunkFillColor,
    double bulbousness,
    List palette,
    double leafAngle,
    double leafLength,
    double randomLeafLength,
    double leafSquareness,
    double leafDecay,
    String leafStyle,
    bool justBranched,
  ) {
    List segmentBaseCentre = [
      (rootA[0] + rootB[0]) / 2,
      (rootA[1] + rootB[1]) / 2
    ];

    //branch

    if (!justBranched && rnd.nextDouble() < branch) {
      List rootX = [
        segmentBaseCentre[0] + width * cos(direction),
        segmentBaseCentre[1] - width * sin(direction)
      ];

      // draw the triangle
      drawTheTriangle(canvas, borderX, borderY, rootA, rootB, rootX, lineWidth,
          trunkLineColor, trunkFillColor);

      double directionA;
      double directionB;

      if (rnd.nextDouble() > 0.5) {
        directionA = direction + ratio * angle;
        directionB = direction - (1 - ratio) * angle;
      } else {
        directionA = direction - ratio * angle;
        directionB = direction + (1 - ratio) * angle;
      }

      if (rnd.nextDouble() > 0.5) {
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootA,
            rootX,
            width * widthDecay,
            branch,
            angle,
            ratio,
            widthDecay,
            segmentLength * segmentDecay,
            segmentDecay,
            directionA,
            currentDepth + 1,
            maxDepth,
            leavesAfter,
            lineWidth,
            trunkLineColor,
            trunkFillColor,
            bulbousness,
            palette,
            leafAngle,
            leafLength,
            randomLeafLength,
            leafSquareness,
            leafDecay,
            leafStyle,
            true);
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootX,
            rootB,
            width * widthDecay,
            branch,
            angle,
            ratio,
            widthDecay,
            segmentLength * segmentDecay,
            segmentDecay,
            directionB,
            currentDepth + 1,
            maxDepth,
            leavesAfter,
            lineWidth,
            trunkLineColor,
            trunkFillColor,
            bulbousness,
            palette,
            leafAngle,
            leafLength,
            randomLeafLength,
            leafSquareness,
            leafDecay,
            leafStyle,
            true);
      } else {
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootX,
            rootB,
            width * widthDecay,
            branch,
            angle,
            ratio,
            widthDecay,
            segmentLength * segmentDecay,
            segmentDecay,
            directionB,
            currentDepth + 1,
            maxDepth,
            leavesAfter,
            lineWidth,
            trunkLineColor,
            trunkFillColor,
            bulbousness,
            palette,
            leafAngle,
            leafLength,
            randomLeafLength,
            leafSquareness,
            leafDecay,
            leafStyle,
            true);
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootA,
            rootX,
            width * widthDecay,
            branch,
            angle,
            ratio,
            widthDecay,
            segmentLength * segmentDecay,
            segmentDecay,
            directionA,
            currentDepth + 1,
            maxDepth,
            leavesAfter,
            lineWidth,
            trunkLineColor,
            trunkFillColor,
            bulbousness,
            palette,
            leafAngle,
            leafLength,
            randomLeafLength,
            leafSquareness,
            leafDecay,
            leafStyle,
            true);
      }
    } else {
      //grow
      List PD = [
        segmentBaseCentre[0] + segmentLength * cos(direction),
        segmentBaseCentre[1] - segmentLength * sin(direction)
      ];
      List P2 = [
        PD[0] + 0.5 * width * widthDecay * sin(direction),
        PD[1] + 0.5 * width * widthDecay * cos(direction)
      ];
      List P3 = [
        PD[0] - 0.5 * width * widthDecay * sin(direction),
        PD[1] - 0.5 * width * widthDecay * cos(direction)
      ];

      // draw the trunk
      drawTheTrunk(canvas, borderX, borderY, rootB, P2, P3, rootA, bulbousness,
          lineWidth, trunkLineColor, trunkFillColor);

      // Draw the leaves
      if (currentDepth > leavesAfter) {
        drawTheLeaf(
            canvas,
            borderX,
            borderY,
            palette,
            P2,
            lineWidth,
            direction - leafAngle,
            leafLength,
            randomLeafLength,
            leafSquareness,
            leafStyle);
        drawTheLeaf(
            canvas,
            borderX,
            borderY,
            palette,
            P3,
            lineWidth,
            direction + leafAngle,
            leafLength,
            randomLeafLength,
            leafSquareness,
            leafStyle);
      }

      // next
      if (currentDepth < maxDepth) {
        drawSegment(
            canvas,
            borderX,
            borderY,
            P3,
            P2,
            width * widthDecay,
            branch,
            angle,
            ratio,
            widthDecay,
            segmentLength * segmentDecay,
            segmentDecay,
            direction,
            currentDepth + 1,
            maxDepth,
            leavesAfter,
            lineWidth,
            trunkLineColor,
            trunkFillColor,
            bulbousness,
            palette,
            leafAngle,
            leafLength * leafDecay,
            randomLeafLength,
            leafSquareness,
            leafDecay,
            leafStyle,
            false);
      }
    }
  }

  drawTheTrunk(
    Canvas canvas,
    double borderX,
    double borderY,
    List P1,
    List P2,
    List P3,
    List P4,
    double bulbousness,
    double strokeWidth,
    Color trunkLineColor,
    Color trunkFillColor,
  ) {
    List PC = [
      (P1[0] + P2[0] + P3[0] + P4[0]) / 4,
      (P1[1] + P2[1] + P3[1] + P4[1]) / 4
    ];
    List P12 = [(P1[0] + P2[0]) / 2, (P1[1] + P2[1]) / 2];
    List PX = [
      PC[0] * (1 - bulbousness) + P12[0] * bulbousness,
      PC[1] * (1 - bulbousness) + P12[1] * bulbousness
    ];
    List P34 = [(P3[0] + P4[0]) / 2, (P3[1] + P4[1]) / 2];
    List PY = [
      PC[0] * (1 - bulbousness) + P34[0] * bulbousness,
      PC[1] * (1 - bulbousness) + P34[1] * bulbousness
    ];

    Path trunk = Path();
    trunk.moveTo(borderX + P1[0], -borderY + P1[1]);
    trunk.quadraticBezierTo(
        borderX + PX[0], -borderY + PX[1], borderX + P2[0], -borderY + P2[1]);
    trunk.lineTo(borderX + P3[0], -borderY + P3[1]);
    trunk.quadraticBezierTo(
        borderX + PY[0], -borderY + PY[1], borderX + P4[0], -borderY + P4[1]);
    trunk.close();

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = trunkLineColor);
    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = strokeWidth
          ..color = trunkFillColor);
  }

  drawTheTriangle(
    Canvas canvas,
    double borderX,
    double borderY,
    List P1,
    List P2,
    List P3,
    double strokeWidth,
    Color trunkLineColor,
    Color trunkFillColor,
  ) {
    Path trunk = Path();
    trunk.moveTo(borderX + P1[0], -borderY + P1[1]);
    trunk.lineTo(borderX + P2[0], -borderY + P2[1]);
    trunk.lineTo(borderX + P3[0], -borderY + P3[1]);
    trunk.close();

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = trunkLineColor);

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = strokeWidth
          ..color = trunkFillColor);
  }

  drawTheLeaf(
    Canvas canvas,
    double borderX,
    double borderY,
    List palette,
    List leafPosition,
    double lineWidth,
    double leafAngle,
    double leafLength,
    double randomLeafLength,
    double leafSquareness,
    String leafStyle,
  ) {
    double leafAssymetery = 0.75;

    // pick a random color
    Random rnd = new Random();
    Color leafColor = palette[rnd.nextInt(palette.length)];

    var leafRadius = leafLength + rnd.nextDouble() * randomLeafLength;

    // find the centre of the leaf
    List PC = [
      leafPosition[0] + leafRadius * cos(leafAngle),
      leafPosition[1] - leafRadius * sin(leafAngle)
    ];

//    List PN = [PC[0] - leafRadius * cos(leafAngle), PC[1] + leafRadius * sin(leafAngle)];

    // find the tip of the leaf
    List PS = [
      PC[0] - leafRadius * cos(leafAngle + pi),
      PC[1] + leafRadius * sin(leafAngle + pi)
    ];

    // find the offset centre of the leaf
    List POC = [
      PC[0] + leafAssymetery * leafRadius * cos(leafAngle + pi),
      PC[1] - leafAssymetery * leafRadius * sin(leafAngle + pi)
    ];

    List PE = [
      POC[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 0.5),
      POC[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 0.5)
    ];
    List PW = [
      POC[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 1.5),
      POC[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 1.5)
    ];

    // List PSE = [PS[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 0.5), PS[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 0.5)];
    // List PSW = [PS[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 1.5), PS[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 1.5)];

    switch (leafStyle) {
      case "quadratic":
        Path leaf = Path();
        leaf.moveTo(borderX + leafPosition[0], -borderY + leafPosition[1]);
        leaf.quadraticBezierTo(borderX + PE[0], -borderY + PE[1],
            borderX + PS[0], -borderY + PS[1]);
        leaf.quadraticBezierTo(borderX + PW[0], -borderY + PW[1],
            borderX + leafPosition[0], -borderY + leafPosition[1]);
        leaf.close();

        canvas.drawPath(
            leaf,
            Paint()
              ..style = PaintingStyle.fill
              ..color = leafColor);

        break;
    }
  }

  @override
  bool shouldRepaint(OpArtTreePainter oldDelegate) => false;
}
