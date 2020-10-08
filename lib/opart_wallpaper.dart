import 'package:flutter/material.dart';
import 'dart:math';

import 'side_drawer.dart';

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
    return  Stack(
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

    int cellsX = 5;
    int cellsY = 5;
    print('cellsX: $cellsX');
    print('cellsY: $cellsY');
    
    // aspectRatio determined from cellsY and cellsX
    double aspectRatio = cellsX/cellsY;

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
    print('randomColours: $randomColours');
    
    // keep track of the colour order
    int colourOrder = 0;

    Color backgroundColor = Colors.grey[200];
    print('backgroundColor: $backgroundColor');
    double lineWidth = rnd.nextDouble()*10;
    print('lineWidth: $lineWidth');
    Color lineColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity);
    print('lineColor: $lineColor');



    // Now make some art

    // fill
    bool fill = true; // rnd.nextBool();
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

    double stepStep = rnd.nextDouble() * 2;
    if (rnd.nextBool()) {stepStep= 0;}
    print('stepStep: $stepStep');

    // Ratio
    double ratio = 1;
    print('ratio: $ratio');

    // offsetX & offsetY
    double offsetX = rnd.nextDouble()*20-10;
    double offsetY = rnd.nextDouble()*20-10;
    if (rnd.nextBool()){
      offsetX=0;
      offsetY=0;
    }
    print('offsetX: $offsetX');
    print('offsetY: $offsetY');

    // Squeeze
    double squeezeX = 1;
    double squeezeY = 1;

    // Rotate
    double rotate = rnd.nextDouble() * pi * 2;
    if (rnd.nextBool()){rotate = 0;}
    print('rotate: $rotate');
    bool randomRotation = rnd.nextBool();
    print('randomRotation: $randomRotation');
    
    double rotateStep = rnd.nextDouble()*5;
    if (rnd.nextBool()){rotateStep = 0;}
    print('rotateStep: $rotateStep');

    
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
    int shape = rnd.nextInt(3);
    print('shape: $shape');

    // driftX & driftY
    double driftX = rnd.nextDouble() * 5;
    double driftY = rnd.nextDouble() * 5;
    if (rnd.nextBool()){
      driftX=0;
      driftY=0;
    }
    print('driftX: $driftX');
    print('driftY: $driftY');

    double driftXStep = rnd.nextDouble() *2;
    double driftYStep = rnd.nextDouble() *2;
    if (rnd.nextBool()){
      driftXStep=0;
      driftYStep=0;
    }
    print('driftXStep: $driftXStep');
    print('driftYStep: $driftYStep');

    // squareness
    double squareness = rnd.nextDouble()*2;
    if (rnd.nextBool()){
      squareness=rnd.nextDouble()/2+0.5;
    }

    // Number of petals
    int numberOfPetals = rnd.nextInt(15);
    bool randomPetals = rnd.nextBool();
    print('numberOfPetals: $numberOfPetals');
    print('randomPetals: $randomPetals');




    for (int j = 0 - extraCellsY; j < cellsY + extraCellsY; j++) {
      for (int i = 0 - extraCellsX; i < cellsX + extraCellsX; i++) {
        int k = 0; // count the steps

        double localOffsetX = 0;
        double localOffsetY = 0;

        double dX = 0;
        double dY = 0;

        double localDriftX = driftX;
        double localDriftY = driftY;
        if (alternateDrift && (i + j) % 2 == 0) {
          localDriftX = -driftX;
          localDriftY = -driftY;
        }

        double stepRadius = radius * ratio;
        double localStep = step;

        double localRotate = rotate;
        if (randomRotation) {
          localRotate = rnd.nextDouble() * rotate;
        }
        if (alternateDrift && (i + j ) % 2 == 0) {
          localRotate = 0 - localRotate;
        }

        // Number of petals
        var localNumberOfPetals = numberOfPetals;
        if (randomPetals) {
          localNumberOfPetals =  rnd.nextInt(numberOfPetals-3) + 3;
        }

        // Centre of the square
        List PO = [
          borderX + radius * (1 - squeezeX) + localOffsetX + (offsetX * j) + (i * 2 + 1) * radius * squeezeX,
          borderY + radius * (1 - squeezeY) + localOffsetY + (offsetY * i) + (j * 2 + 1) * radius * squeezeY
        ];
        // print('i: $i j: $j');
        // print('PO: $PO');

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


        if (box) {

          // Choose the next colour
          colourOrder++;
          nextColour = palette[colourOrder%numberOfColours];
          if (randomColours) {
            nextColour = palette[rnd.nextInt(numberOfColours)];
          }

          // fill the square
          Path path = Path();
          path.moveTo(PA[0], PA[1]);
          path.lineTo(PB[0], PB[1]);
          path.lineTo(PC[0], PC[1]);
          path.lineTo(PD[0], PD[1]);
          path.close();

          canvas.drawPath(path, Paint() ..style = PaintingStyle.fill ..color = nextColour);
          
          // if (lineWidth > 0) {
          //   canvas.drawPath(path, Paint() ..style = PaintingStyle.stroke ..strokeWidth = lineWidth ..color = lineColor);
          // }

        }



        do {

          // drift...
          PO = [PO[0] + dX, PO[1] + dY];

          switch (shape) {
            case 0: // "circle":

                // Choose the next colour
                colourOrder++;
                nextColour = palette[colourOrder%numberOfColours];
                if (randomColours) {
                  nextColour = palette[rnd.nextInt(numberOfColours)];
                }

                canvas.drawCircle(Offset(PO[0], PO[1]), stepRadius, Paint() ..style = PaintingStyle.fill ..color = nextColour);
                canvas.drawCircle(Offset(PO[0], PO[1]), stepRadius, Paint() ..style = PaintingStyle.stroke ..strokeWidth = lineWidth ..color = lineColor);

              break;

            case 1: // squaricle

              List PA = [
                PO[0] + stepRadius * sqrt(2) * cos(pi * (1 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (1 / 4 + localRotate))
              ];
              List PB = [
                PO[0] + stepRadius * sqrt(2) * cos(pi * (3 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (3 / 4 + localRotate))
              ];
              List PC = [
                PO[0] + stepRadius * sqrt(2) * cos(pi * (5 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (5 / 4 + localRotate))
              ];
              List PD = [
                PO[0] + stepRadius * sqrt(2) * cos(pi * (7 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (7 / 4 + localRotate))
              ];


              // 16 points - 2 on each edge and 8 curve centres

              List P1 = edgePoint(PA, PB, 0.5 + squareness / 2);
              List P2 = edgePoint(PA, PB, 0.5 - squareness / 2);

              List P4 = edgePoint(PB, PC, 0.5 + squareness / 2);
              List P5 = edgePoint(PB, PC, 0.5 - squareness / 2);

              List P7 = edgePoint(PC, PD, 0.5 + squareness / 2);
              List P8 = edgePoint(PC, PD, 0.5 - squareness / 2);

              List P10 = edgePoint(PD, PA, 0.5 + squareness / 2);
              List P11 = edgePoint(PD, PA, 0.5 - squareness / 2);

              Path squaricle = Path();
              
              squaricle.moveTo(P1[0], P1[1]);
              squaricle.lineTo(P2[0], P2[1]);
              squaricle.quadraticBezierTo(PB[0], PB[1], P4[0], P4[1]);
              squaricle.lineTo(P5[0], P5[1]);
              squaricle.quadraticBezierTo(PC[0], PC[1], P7[0], P7[1]);
              squaricle.lineTo(P8[0], P8[1]);
              squaricle.quadraticBezierTo(PD[0], PD[1], P10[0], P10[1]);
              squaricle.lineTo(P11[0], P11[1]);
              squaricle.quadraticBezierTo(PA[0], PA[1], P1[0], P1[1]);
              squaricle.close();

              // Choose the next colour
              colourOrder++;
              nextColour = palette[colourOrder%numberOfColours];
              if (randomColours) {
                nextColour = palette[rnd.nextInt(numberOfColours)];
              }

              canvas.drawPath(
                  squaricle,
                  Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = lineWidth
                    ..color = lineColor);
              canvas.drawPath(
                  squaricle,
                  Paint()
                    ..style = PaintingStyle.fill
                    ..color = nextColour);

              break;
              
            case 2: //"star":
              for (var p = 0; p < localNumberOfPetals; p++) {

                List petalPoint = [PO[0] + stepRadius * cos(localRotate * pi + p * pi * 2 / localNumberOfPetals),
                  PO[1] + stepRadius * sin(localRotate * pi + p * pi * 2 / localNumberOfPetals)];
                
                List petalMidPointA = [PO[0] + (squareness) * stepRadius * cos(localRotate * pi + (p - 1) * pi * 2 / localNumberOfPetals),
                  PO[1] + (squareness) * stepRadius * sin(localRotate * pi + (p - 1) * pi * 2 / localNumberOfPetals)];

                List petalMidPointP = [PO[0] + (squareness) * stepRadius * cos(localRotate * pi + (p + 1) * pi * 2 / localNumberOfPetals),
                  PO[1] + (squareness) * stepRadius * sin(localRotate * pi + (p + 1) * pi * 2 / localNumberOfPetals)];

                Path star = Path();

                star.moveTo(PO[0], PO[1]);
                star.quadraticBezierTo(petalMidPointA[0], petalMidPointA[1], petalPoint[0], petalPoint[1]);
                star.quadraticBezierTo(petalMidPointP[0], petalMidPointP[1], PO[0], PO[1]);
                star.close();


                // Choose the next colour
                colourOrder++;
                nextColour = palette[colourOrder%numberOfColours];
                if (randomColours) {
                  nextColour = palette[rnd.nextInt(numberOfColours)];
                }

                canvas.drawPath(
                    star,
                    Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = lineWidth
                      ..color = lineColor);
                canvas.drawPath(
                    star,
                    Paint()
                      ..style = PaintingStyle.fill
                      ..color = nextColour);

              }

              break;
              
              
          }





          // Drift & Rotate
          localDriftX = localDriftX + driftXStep;
          localDriftY = localDriftY + driftYStep;
          if (alternateDrift && (i + j) % 2 == 0) {
            dX = dX - localDriftX;
            dY = dY - localDriftY;
            localRotate = localRotate - rotateStep;
          }
          else {
            dX = dX + localDriftX;
            dY = dY + localDriftY;
            localRotate = localRotate + rotateStep;
          }

          localStep = localStep + stepStep;
          stepRadius = stepRadius - localStep;
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

List edgePoint(List Point1, List Point2, double ratio) {
  return [Point1[0] * (ratio) + Point2[0] * (1 - ratio), Point1[1] * (ratio) + Point2[1] * (1 - ratio)];
}
