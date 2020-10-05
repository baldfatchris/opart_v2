import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(OpArtWaves());
}

class OpArtWaves extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OpArtStudio(title: 'OpArt Waves'),
    );
  }
}

class OpArtStudio extends StatefulWidget {
  OpArtStudio({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _OpArtStudioState createState() => _OpArtStudioState();
}

class _OpArtStudioState extends State<OpArtStudio> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu',
          onPressed: () {
            // scaffoldKey.currentState.showSnackBar(snackBar);
          },
        ),
        title: Text(widget.title),
        actions: <Widget>[

          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () {
              // openPage(context);
            },
          ),
        ],
      ),

      body: Stack(
        children: [
          Visibility(
            visible: true,
            child: LayoutBuilder(
              builder: (_, constraints) => Container(
                width: constraints.widthConstraints().maxWidth,
                height: constraints.heightConstraints().maxHeight,


                child: CustomPaint(painter: OpArtWavesPainter()),

              ),
            ),

          )


        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){print('FloatingActionButton.onPressed');},
        tooltip: 'Settings',
        child: Icon(Icons.settings),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class OpArtWavesPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // define the paint object



    double canvasWidth = size.width;
    double canvasHeight = size.height;

    print('width: ${canvasWidth}');
    print('height: ${canvasHeight}');
    print('canvasWidth / canvasHeight = ${canvasWidth / canvasHeight}');

    double aspectRatio = 0.2;
    double borderX = 0;
    double borderY = 0;
    double imageWidth = canvasWidth;
    double imageHeight = canvasHeight;

    if (canvasWidth / canvasHeight < aspectRatio) {
      borderY = (canvasHeight - canvasWidth / aspectRatio) / 2;
      imageHeight = imageWidth /aspectRatio;
    }
    else {
      borderX = (canvasWidth - canvasHeight * aspectRatio) / 2;
      imageWidth = imageHeight * aspectRatio;
    }
    print('aspectRatio = $aspectRatio');
    print('borderX = $borderX');
    print('borderY = $borderY');
    print('imageWidth = $imageWidth');
    print('imageHeight = $imageHeight');

    var paint1 = Paint()
      ..color = Color(0xff638965)
      ..style = PaintingStyle.fill;
    //a rectangle
    canvas.drawRect(Offset(borderX, borderY) & Size(imageWidth, imageHeight), paint1);



    double trunkWidth = 10.0;
    double widthDecay = 0.92;
    double segmentLength = 50.0;
    double segmentDecay = 0.92;
    double branch = 0.7;
    double angle = 0.5;
    double ratio = 0.7;

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

    double direction = pi / 2;

    double lineWidth = 2;
    Color trunkLineColor = Colors.grey[900];
    Color trunkFillColor = Colors.grey[800];

    double bulbousness = 2.5;
    int maxDepth = 20;
    int leavesAfter = 5;

    double leafAngle = 0.5;
    double leafLength = 10;
    double randomLeafLength = 3.0;
    double leafSquareness = 1;
    double leafDecay = 1.01;
    String leafStyle = 'quadratic';


    List treeBaseA = [(canvasWidth-trunkWidth)/2, canvasHeight];
    List treeBaseB = [(canvasWidth+trunkWidth)/2, canvasHeight];

    //drawSegment(canvas, treeBaseA, treeBaseB, trunkWidth, branch, angle, ratio, widthDecay, segmentLength, segmentDecay, direction, 0, maxDepth, leavesAfter, lineWidth, trunkLineColor, trunkFillColor, bulbousness, palette, leafAngle, leafLength, randomLeafLength, leafSquareness, leafDecay, leafStyle, false);

  }

  drawSegment(
      Canvas canvas,
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
      )
  {
    List segmentBaseCentre = [(rootA[0] + rootB[0]) / 2, (rootA[1] + rootB[1]) / 2];

    //branch
    Random rnd = new Random();

    if (!justBranched && rnd.nextDouble() < branch) {

      List rootX = [segmentBaseCentre[0] + width * cos(direction), segmentBaseCentre[1] - width * sin(direction)];

      // draw the triangle
      drawTheTriangle(
          canvas,
          rootA,
          rootB,
          rootX,
          lineWidth,
          trunkLineColor,
          trunkFillColor);

      double directionA;
      double directionB;

      if (rnd.nextDouble() > 0.5) {
        directionA = direction + ratio * angle;
        directionB = direction - (1 - ratio) * angle;
      }
      else {
        directionA = direction - ratio * angle;
        directionB = direction + (1 - ratio) * angle;
      }


      if (rnd.nextDouble() > 0.5) {
        drawSegment(canvas, rootA, rootX, width * widthDecay, branch, angle, ratio, widthDecay, segmentLength * segmentDecay, segmentDecay,  directionA, currentDepth + 1, maxDepth, leavesAfter, lineWidth, trunkLineColor, trunkFillColor, bulbousness, palette, leafAngle, leafLength, randomLeafLength, leafSquareness, leafDecay, leafStyle, true);
        drawSegment(canvas, rootX, rootB, width * widthDecay, branch, angle, ratio, widthDecay, segmentLength * segmentDecay, segmentDecay,  directionB, currentDepth + 1, maxDepth, leavesAfter, lineWidth, trunkLineColor, trunkFillColor, bulbousness, palette, leafAngle, leafLength, randomLeafLength, leafSquareness, leafDecay, leafStyle, true);
      }
      else {
        drawSegment(canvas, rootX, rootB, width * widthDecay, branch, angle, ratio, widthDecay, segmentLength * segmentDecay, segmentDecay,  directionB, currentDepth + 1, maxDepth, leavesAfter, lineWidth, trunkLineColor, trunkFillColor, bulbousness, palette, leafAngle, leafLength, randomLeafLength, leafSquareness, leafDecay, leafStyle, true);
        drawSegment(canvas, rootA, rootX, width * widthDecay, branch, angle, ratio, widthDecay, segmentLength * segmentDecay, segmentDecay,  directionA, currentDepth + 1, maxDepth, leavesAfter, lineWidth, trunkLineColor, trunkFillColor, bulbousness, palette, leafAngle, leafLength, randomLeafLength, leafSquareness, leafDecay, leafStyle, true);
      }


    }
    else {
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
      drawTheTrunk(
          canvas,
          rootB,
          P2,
          P3,
          rootA,
          bulbousness,
          lineWidth,
          trunkLineColor,
          trunkFillColor);

      // Draw the leaves
      if (currentDepth > leavesAfter) {
        drawTheLeaf(canvas, palette, P2, lineWidth, direction - leafAngle, leafLength, randomLeafLength, leafSquareness, leafStyle);
        drawTheLeaf(canvas, palette, P3, lineWidth, direction + leafAngle, leafLength, randomLeafLength, leafSquareness, leafStyle);
      }

      // next
      if (currentDepth < maxDepth) {
        drawSegment(canvas, P3, P2, width * widthDecay, branch, angle, ratio, widthDecay, segmentLength * segmentDecay, segmentDecay,  direction, currentDepth + 1, maxDepth, leavesAfter, lineWidth, trunkLineColor, trunkFillColor, bulbousness, palette, leafAngle, leafLength * leafDecay, randomLeafLength, leafSquareness, leafDecay, leafStyle, false);
      }
    }
  }

  drawTheTrunk(
      Canvas canvas,
      List P1,
      List P2,
      List P3,
      List P4,
      double bulbousness,
      double strokeWidth,
      Color trunkLineColor,
      Color trunkFillColor,
      )
  {

    List PC = [(P1[0] + P2[0] + P3[0] + P4[0]) / 4, (P1[1] + P2[1] + P3[1] + P4[1]) / 4];
    List P12 = [(P1[0] + P2[0]) / 2, (P1[1] + P2[1]) / 2];
    List PX = [PC[0] * (1 - bulbousness) + P12[0] * bulbousness, PC[1] * (1 - bulbousness) + P12[1] * bulbousness];
    List P34 = [(P3[0] + P4[0]) / 2,(P3[1] + P4[1]) / 2];
    List PY = [PC[0] * (1 - bulbousness) + P34[0] * bulbousness, PC[1] * (1 - bulbousness) + P34[1] * bulbousness];

    Path trunk = Path();
    trunk.moveTo(P1[0], P1[1]);
    trunk.quadraticBezierTo(PX[0], PX[1], P2[0], P2[1]);
    trunk.lineTo(P3[0], P3[1]);
    trunk.quadraticBezierTo(PY[0], PY[1], P4[0], P4[1]);
    trunk.close();

    canvas.drawPath(trunk, Paint() ..style = PaintingStyle.stroke ..strokeWidth = strokeWidth ..color = trunkLineColor);
    canvas.drawPath(trunk, Paint() ..style = PaintingStyle.fill ..strokeWidth = strokeWidth..color = trunkFillColor);
  }

  drawTheTriangle(
      Canvas canvas,
      List P1,
      List P2,
      List P3,
      double strokeWidth,
      Color trunkLineColor,
      Color trunkFillColor,
      ) {

    Path trunk = Path();
    trunk.moveTo(P1[0], P1[1]);
    trunk.lineTo(P2[0], P2[1]);
    trunk.lineTo(P3[0], P3[1]);
    trunk.close();

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = trunkLineColor
    );

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = strokeWidth
          ..color = trunkFillColor
    );


  }


  drawTheLeaf(
      Canvas canvas,
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
    List PC = [leafPosition[0] + leafRadius * cos(leafAngle), leafPosition[1] - leafRadius * sin(leafAngle)];


//    List PN = [PC[0] - leafRadius * cos(leafAngle), PC[1] + leafRadius * sin(leafAngle)];

    // find the tip of the leaf
    List PS = [PC[0] - leafRadius * cos(leafAngle + pi), PC[1] + leafRadius * sin(leafAngle + pi)];

    // find the offset centre of the leaf
    List POC = [PC[0] + leafAssymetery * leafRadius * cos(leafAngle + pi), PC[1] - leafAssymetery * leafRadius * sin(leafAngle + pi)];

    List PE = [POC[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 0.5), POC[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 0.5)];
    List PW = [POC[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 1.5), POC[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 1.5)];

    // List PSE = [PS[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 0.5), PS[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 0.5)];
    // List PSW = [PS[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 1.5), PS[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 1.5)];


    switch (leafStyle) {
      case "quadratic":

        Path leaf = Path();
        leaf.moveTo(leafPosition[0], leafPosition[1]);
        leaf.quadraticBezierTo(PE[0], PE[1], PS[0], PS[1]);
        leaf.quadraticBezierTo(PW[0], PW[1], leafPosition[0], leafPosition[1]);
        leaf.close();

        canvas.drawPath(
            leaf,
            Paint()
              ..style = PaintingStyle.fill
              ..color = leafColor
        );

        break;


    }




  }

  @override
  bool shouldRepaint(OpArtWavesPainter oldDelegate) => false;
}