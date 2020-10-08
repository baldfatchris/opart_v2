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
    return
//      Scaffold(
//      drawer: DrawerWidget(),
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
////        leading: IconButton(
////          icon: const Icon(Icons.menu),
////          tooltip: 'Menu',
////          onPressed: () {
////            // scaffoldKey.currentState.showSnackBar(snackBar);
////          },
////        ),
//        title: Text(widget.title),
//        actions: <Widget>[
//          IconButton(
//            icon: const Icon(Icons.share),
//            tooltip: 'Share',
//            onPressed: () {
//              // openPage(context);
//            },
//          ),
//        ],
//      ),

       Stack(
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
      );

//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          print('FloatingActionButton.onPressed');
//        },
//        tooltip: 'Settings',
//        child: Icon(Icons.settings),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
  }
}

class OpArtWavesPainter extends CustomPainter {
  Random rnd;
  OpArtWavesPainter(this.rnd);

  @override
  void paint(Canvas canvas, Size size) {
    // define the paint object

    Random rnd = new Random();

    double canvasWidth = size.width;
    double canvasHeight = size.height;
    double borderX = 0;
    double borderY = 0;
    double imageWidth = canvasWidth;
    double imageHeight = canvasHeight;

    // aspectRation from 0.5 to 2 - or 33% of time fit to screen, 33% of time make it 1
    double aspectRatio = rnd.nextDouble()*1.5+0.5;
    if (rnd.nextInt(2)==0){
      aspectRatio = canvasWidth/canvasHeight;
    }
    else if (rnd.nextInt(1)==0){
      aspectRatio = 1;
    }

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

    // numberOfColours from 1 to 24
    int numberOfColours = rnd.nextInt(24)+1;
    print('numberOfColours: $numberOfColours');

    // opacity - from 0 to 1 - 50% of time =1
    double opacity = rnd.nextDouble();
    if (rnd.nextInt(2)==0){
      opacity = 1;
    }
    print('opacity: $opacity');

    // paletteType - 0=random; 1=blended random; 2=linear random; 3=linear complimentary;
    int paletteType = rnd.nextInt(4);
    print('paletteType: $paletteType');

    // randomise the palette
    List palette = [];
    switch(paletteType){

      // blended random
      case 1:{
        double blendColour = Random().nextDouble() * 0xFFFFFF;
        for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++){
          palette.add(Color(((blendColour + Random().nextDouble() * 0xFFFFFF)/2).toInt()).withOpacity(opacity));
        }
      }
      break;

    // linear random
      case 2:{
        List startColour = [rnd.nextInt(255),rnd.nextInt(255),rnd.nextInt(255)];
        List endColour = [rnd.nextInt(255),rnd.nextInt(255),rnd.nextInt(255)];
        for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++){
          palette.add(Color.fromRGBO(
              ((startColour[0]*colourIndex + endColour[0]*(numberOfColours-colourIndex))/numberOfColours).round(),
              ((startColour[1]*colourIndex + endColour[1]*(numberOfColours-colourIndex))/numberOfColours).round(),
              ((startColour[2]*colourIndex + endColour[2]*(numberOfColours-colourIndex))/numberOfColours).round(),
              opacity));
        }
      }
      break;

    // linear complementary
      case 2:{
        List startColour = [rnd.nextInt(255),rnd.nextInt(255),rnd.nextInt(255)];
        List endColour = [255-startColour[0],255-startColour[1],255-startColour[2]];
        for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++){
          palette.add(Color.fromRGBO(
              ((startColour[0]*colourIndex + endColour[0]*(numberOfColours-colourIndex))/numberOfColours).round(),
              ((startColour[1]*colourIndex + endColour[1]*(numberOfColours-colourIndex))/numberOfColours).round(),
              ((startColour[2]*colourIndex + endColour[2]*(numberOfColours-colourIndex))/numberOfColours).round(),
              opacity));
        }
      }
      break;

      // random
      default: {
        for (int colorIndex = 0; colorIndex < numberOfColours; colorIndex++){
          palette.add(Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity));
        }
      }
      break;

    }

    // randomColours - true or false
    bool randomColours = rnd.nextBool();
    randomColours = false;
    print('randomColours: $randomColours');

    int colourOrder = 0;
    Color backgroundColor = Colors.grey[200];


    // Now make some art

    // stepX - from 1 to 30
    double stepX = rnd.nextDouble()*29+1;
    print('stepX: $stepX');


    // stepY = from 10 to 100 - 50% of time = 0.1
    double stepY = rnd.nextDouble()*90+10;
    if (rnd.nextInt(2)==0){
      stepY = 0.1;
    }

    // amplitude = from 0 to width/5
    double amplitude = rnd.nextDouble()*imageWidth/5;
    print('amplitude: $amplitude');

    // frequency = from 0 to 3
    double frequency = rnd.nextDouble()*3;
    print('frequency: $frequency');


    double offset = 1;
    double start = 0 - amplitude;
    double end = imageWidth + stepX + amplitude;

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

      double j;
      for (j = 0; j < imageHeight + stepY; j+=stepY) {
        var delta = amplitude * sin(pi * 2 * (j / imageHeight * frequency + offset * i / imageWidth));
        if (j==0){
          wave.moveTo(borderX + i + delta, borderY + j);
        }
        else{
          wave.lineTo(borderX + i + delta, borderY + j);
        }
      }
      for (double k = j; k >= -stepY; k-=stepY) {
        var delta = amplitude * sin(pi * 2 * (k / imageHeight * frequency + offset * (i+stepX) / imageWidth));
        wave.lineTo(borderX + i + stepX + delta, borderY + k);
      }


//      wave.lineTo(borderX + imageWidth, borderY + imageHeight);
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
