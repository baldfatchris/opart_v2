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
  // int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
    });
  }

  Random rnd;

  @override
  void initState() {
    rnd = Random();
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
                child: CustomPaint(painter: OpArtWavesPainter(rnd)),
              ),
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton.onPressed');
        },
        tooltip: 'Settings',
        child: Icon(Icons.settings),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class OpArtWavesPainter extends CustomPainter {
  Random rnd;
  OpArtWavesPainter(this.rnd);
  @override
  void paint(Canvas canvas, Size size) {
    // define the paint object

    double canvasWidth = size.width;
    double canvasHeight = size.height;

    double aspectRatio = 0.9;
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

    print('width: ${canvasWidth}');
    print('height: ${canvasHeight}');
    print('canvasWidth / canvasHeight = ${canvasWidth / canvasHeight}');
    print('aspectRatio = $aspectRatio');
    print('borderX = $borderX');
    print('borderY = $borderY');
    print('imageWidth = $imageWidth');
    print('imageHeight = $imageHeight');


    List palette = [];
    for (int colorIndex = 0; colorIndex < 24; colorIndex++){
      palette.add(Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    }


    Color backgroundColor = Colors.grey[200];

    // Now make some art
    Random rnd = new Random();

    double stepX = 10;
    double stepY = 0.1;
    double amplitude = 30;
    double frequency = 2;
    double offset = 1;
    double start = 0 - amplitude;
    double end = imageWidth + stepX + amplitude;
    int numberOfColours = rnd.nextInt(palette.length-1)+1;
    bool randomColours = false;
    int colourOrder = 0;

    for (double i = start; i < end; i+= stepX ) {

      Color waveColor;
      if (randomColours){
        waveColor = palette[rnd.nextInt(numberOfColours)];
      }
      else
      {
        colourOrder++;
        waveColor = palette[colourOrder%numberOfColours];
      }

      // var paint1 = Paint()
      //   ..color = waveColor
      //   ..style = PaintingStyle.fill;
      // canvas.drawRect(Offset(borderX + i, borderY) & Size(stepX, imageHeight), paint1);

      Path wave = Path();
      wave.moveTo(borderX + imageWidth, borderY);
      
      for (double j = 0; j < imageHeight + stepY; j+=stepY) {
        var delta = amplitude * sin(pi * 2 * (j / imageHeight * frequency + offset * i / imageWidth));

        wave.lineTo(borderX + i + delta, borderY + j);
      }
      wave.lineTo(borderX + imageWidth, borderY + imageHeight);
      wave.close();

      canvas.drawPath(
          wave,
          Paint()
            ..style = PaintingStyle.fill
            ..color = waveColor);

    }


    // colour in the outer canvas
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(0, 0) & Size(borderX, canvasHeight), paint1);
    canvas.drawRect(Offset(canvasWidth-borderX, 0) & Size(borderX, canvasHeight), paint1);

    canvas.drawRect(Offset(0, 0) & Size(canvasWidth, borderY ), paint1);
    canvas.drawRect(Offset(0, canvasHeight-borderY, ) & Size(canvasWidth, borderY), paint1);



  }



  @override
  bool shouldRepaint(OpArtWavesPainter oldDelegate) => false;
}
