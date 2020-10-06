import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(OpArtWallpaper());
}

class OpArtWallpaper extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OpArtStudio(title: 'OpArt Wallpaper'),
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
                child: CustomPaint(painter: OpArtWallpaperPainter(rnd)),
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

class OpArtWallpaperPainter extends CustomPainter {
  Random rnd;
  OpArtWallpaperPainter(this.rnd);

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

    int cellsX = 8;
    int cellsY = 8;
    print('cellsX: $cellsX');
    print('cellsY: $cellsY');
    
    // aspectRatio determined from cellsY and cellsX
    double aspectRatio = cellsY/cellsX;

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
    print('backgroundColor: $backgroundColor');
    double lineWidth = rnd.nextDouble()*10;
    print('lineWidth: $lineWidth');
    Color lineColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity);
    print('lineColor: $lineColor');



    // Now make some art

    // fill
    bool fill = rnd.nextBool();
    print('fill: $fill');
    int extraCellsX = 0;
    int extraCellsY = 0;
    if (fill) {
      extraCellsX = cellsX * 2;
      extraCellsY = cellsY * 2;
    }

    // work out the radius from the width and the cells
    double radius = imageWidth / (cellsX * 2);
    print('radius: $radius');

    // Step
    double step = rnd.nextDouble() * radius;
    print('step: $step');

    // Ratio
    double ratio = 1;
    print('ratio: $ratio');

    // offsetX & offsetY
    double offsetX = 0;
    double offsetY = 0;

    // Squeeze
    double squeezeX = 1;
    double squeezeY = 1;

    // Rotate
    double rotate = rnd.nextDouble() * pi * 2;
    print('rotate: $rotate');
    bool randomRotation = rnd.nextBool();
    print('randomRotation: $randomRotation');

    // alternateDrift
    bool alternateDrift = rnd.nextBool();
    print('alternateDrift: $alternateDrift');

    // resetColours
    bool resetColours = rnd.nextBool();
    print('resetColours: $resetColours');

    // box
    bool box = rnd.nextBool();
    print('box: $box');

    // shape
    int shape = 0;
    print('shape: $shape');

    // driftX & driftY
    double driftX = rnd.nextDouble() *5 ;
    double driftY = rnd.nextDouble() *5 ;
    if (rnd.nextBool()){
      driftX=0;
      driftY=0;
    }
    print('driftX: $driftX');
    print('driftY: $driftY');


    for (int j = 0 - extraCellsY; j < cellsY + extraCellsY; j++) {
      for (int i = 0 - extraCellsX; i < cellsX + extraCellsX; i++) {
        int k = 0; // count the steps

        double localOffsetX = 0;
        double localOffsetY = 0;

        double dX = 0;
        double dY = 0;

        double stepRadius = radius * ratio;

        double localRotate = rotate;
        if (randomRotation) {
          localRotate = rnd.nextDouble() * rotate;
        }
        if (alternateDrift && (i + j ) % 2 == 0) {
          localRotate = 0 - localRotate;
        }


        // Centre of the square
        List PO = [
          borderX + radius * (1 - squeezeX) + localOffsetX + k * dX + (offsetX * j) + (i * 2 + 1) * radius * squeezeX,
          borderY + radius * (1 - squeezeY) + localOffsetY + k * dY + (offsetY * i) + (j * 2 + 1) * radius * squeezeY
        ];
        print('i: $i j: $j');
        print('PO: $PO');

        List PA = [
          PO[0] + stepRadius * sqrt(2) * cos(pi * (5 / 4 + localRotate)),
          PO[1] + stepRadius * sqrt(2) * sin(pi * (5 / 4 + localRotate))
        ];
        List PB = [
          PO[0] + stepRadius * sqrt(2) * cos(pi * (7 / 4 + localRotate)),
          PO[1] + stepRadius * sqrt(2) * sin(pi * (7 / 4 + localRotate))
        ];
        List PC = [
          PO[0] + stepRadius * sqrt(2) * cos(pi * (1 / 4 + localRotate)),
          PO[1] + stepRadius * sqrt(2) * sin(pi * (1 / 4 + localRotate))
        ];
        List PD = [
          PO[0] + stepRadius * sqrt(2) * cos(pi * (3 / 4 + localRotate)),
          PO[1] + stepRadius * sqrt(2) * sin(pi * (3 / 4 + localRotate))
        ];

        // reset the colours
        Color nextColour;
        if (resetColours) {
          colourOrder = 0;
        }

        // Choose the next colour
        colourOrder++;
        nextColour = palette[colourOrder%numberOfColours];
        if (randomColours) {
          nextColour = palette[rnd.nextInt(numberOfColours)];
        }

        if (box) {

          // fill the square
          Path path = Path();
          path.moveTo(PA[0], PA[1]);
          path.lineTo(PB[0], PB[1]);
          path.lineTo(PC[0], PC[1]);
          path.lineTo(PD[0], PD[1]);
          path.close();

          canvas.drawPath(path, Paint() ..style = PaintingStyle.fill ..color = nextColour);
          
          if (lineWidth > 0) {
            canvas.drawPath(path, Paint() ..style = PaintingStyle.stroke ..strokeWidth = lineWidth ..color = lineColor);
          }

        }



        do {


          var dX = driftX;
          var dY = driftY;

          if (alternateDrift && i % 2 == 1) {
            dX = -driftX;
          }
          if (alternateDrift && j % 2 == 1) {
            dY = -driftY;
          }

          if (k > 0) {
            PO = [PO[0] + dX, PO[1] + dY];
          }

          switch (shape) {
            case 0: // "circle":


                // Choose the next colour
                colourOrder++;
                nextColour = palette[colourOrder%numberOfColours];
                if (randomColours) {
                  nextColour = palette[rnd.nextInt(numberOfColours)];
                }

                canvas.drawCircle(Offset(PO[0], PO[1]), stepRadius, Paint() ..style = PaintingStyle.fill ..color = nextColour);
              break;
          }








              // if (alternateDrift && (i + j) % 2 == 0) {
        //   localRotate = localRotate - rotateStep;
        // }
        // else {
        //   localRotate = localRotate + rotateStep;
        // }
        //
        // step = step + stepStep;
        // driftX = driftX + driftXStep;
        // driftY = driftY + driftYStep;


        stepRadius = stepRadius - step;
        k++;


        } while (stepRadius > 0 && step > 0);

      }
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
  bool shouldRepaint(OpArtWallpaperPainter oldDelegate) => false;
}
