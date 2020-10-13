import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:screenshot/screenshot.dart';

//void main() {
//  runApp(OpArtFibonacci());
//}
bool firstTimeThrough = true;


List palette  = [
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
void changeColor(int index, Color color) {
  palette.replaceRange(index, index + 1, [color]);
}


// pallette settings
int numberOfColours = 35;
Color backgroundColour = Colors.white;
double opacity = 1;
int paletteType = 0;
int gradientType = 0;
bool randomColours = false;
double lineWidth = 0;
Color lineColour = Colors.black;

// image settings
double angleIncrement = 1.6181;
double flowerFill = 1;
double petalToRadius = 0.03;
double ratio = 0.999;
double randomiseAngle = 0;
double petalPointiness = 1;
double petalRotation = 0;
double petalRotationRatio = 1;
int petalType = 0;
int maxPetals = 5000;
double radialOscAmplitude = 0;
double radialOscPeriod = 1;
bool direction = true;



class OpArtFibonacciStudio extends StatefulWidget {
  bool showSettings;
  ScreenshotController screenshotController;
  OpArtFibonacciStudio(this.showSettings, {this.screenshotController});

  @override
  _OpArtFibonacciStudioState createState() => _OpArtFibonacciStudioState();
}

class _OpArtFibonacciStudioState extends State<OpArtFibonacciStudio> {
  int _currentColor = 0;
  Widget settingsWidget() {
    return Column(
      children: [
        Text('Angle Increment'),
        Slider(
          value: angleIncrement,
          min: 0,
          max: pi,
          onChanged: (value) {
            setState(() {
              angleIncrement = value;
            });
          },
          label: '$angleIncrement',
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
          displayThumbColor: true,
          pickerAreaHeightPercent: 0.3,
          pickerAreaBorderRadius: BorderRadius.circular(10.0),
          pickerColor: palette[_currentColor],
          onColorChanged: (color) {
            setState(() {
              changeColor(_currentColor, color);
            });
          },
          showLabel: true,
        ),
      ],
    );
  }

  Random rnd;

  @override
  void initState() {
    rnd = Random();
  }



  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = widget.screenshotController;

    Widget bodyWidget() {
      return Screenshot(controller: screenshotController,
        child: Stack(
          children: [
            Visibility(
              visible: true,
              child: LayoutBuilder(
                builder: (_, constraints) => Container(
                  width: constraints.widthConstraints().maxWidth,
                  height: constraints.heightConstraints().maxHeight,
                  child: CustomPaint(painter: OpArtFibonacciPainter(rnd)),
                ),
              ),
            )
          ],
        ),
      );
    }
    return widget.showSettings
        ? ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: bodyWidget(),
              ),
              settingsWidget(),
            ],
          )
        : bodyWidget();
  }
}


class OpArtFibonacciPainter extends CustomPainter {


  Random rnd;
  OpArtFibonacciPainter(this.rnd);

  @override
  void paint(Canvas canvas, Size size) {


    print ('---------------------------------------------------------');
    print ('Fibonacci');
    print ('---------------------------------------------------------');


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


    double flowerCentreX = imageWidth / 2;
    double flowerCentreY = imageHeight / 2;
    print('flowerCentreX: $flowerCentreX');
    print('flowerCentreY: $flowerCentreY');

    print('firstTimeThrough: $firstTimeThrough');
    if (firstTimeThrough) {
      // randomise the palette
      palette = randomisePalette();

      // randomise the settings
      randomiseSettings();

      firstTimeThrough=false;
    }
    // colour in the canvas
    //a rectangle
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight), Paint()
      ..color = backgroundColour
      ..style = PaintingStyle.fill);




    generateFlower(
        canvas,
        imageWidth,
        imageHeight,
        borderX,
        borderY,
        flowerCentreX,
        flowerCentreY
    );

    // colour in the outer canvas
    Paint paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(0, 0) & Size(borderX, canvasHeight), paint1);
    canvas.drawRect(Offset(canvasWidth-borderX, 0) & Size(borderX, canvasHeight), paint1);

    canvas.drawRect(Offset(0, 0) & Size(canvasWidth, borderY ), paint1);
    canvas.drawRect(Offset(0, canvasHeight-borderY, ) & Size(canvasWidth, borderY), paint1);


  }


  generateFlower(
      Canvas canvas,
      double width,
      double height,
      double borderX,
      double borderY,
      flowerCentreX, flowerCentreY) {

    // start the colour order
    int colourOrder=0;
    Color nextColour;

    // clear the canvas
    //ctx.clearRect(0, 0, canvas.width, canvas.height);
    //canvas.clearRect(0, 0, canvas.width, canvas.height);


    List P0 = [flowerCentreX + borderX, flowerCentreY + borderY];
    double maxRadius = flowerFill * width / 2;
    double minRadius = 1;
    double angle = 0;

    // if direction = inward
    if (direction) {

      double radius = maxRadius;
      do {

        // Choose the next colour
        colourOrder++;
        nextColour = palette[colourOrder%numberOfColours];
        if (randomColours) {
          nextColour = palette[rnd.nextInt(numberOfColours)];
        }

        print('P0: $P0');
        drawPetal(canvas, P0, angle, radius, nextColour, null, petalToRadius, petalType, petalPointiness, petalRotation, petalRotationRatio, lineWidth, lineColour, randomiseAngle, gradientType, radialOscAmplitude, radialOscPeriod);

        angle = angle + angleIncrement;
        if (angle > 2 * pi) {
          angle = angle - 2 * pi;
        }

        radius = radius * ratio;

        maxPetals = maxPetals - 1;
      }
      while (radius > minRadius && radius < maxRadius && maxPetals > 0);
    }
    else {

      double radius = minRadius;
      do {

        // Choose the next colour
        colourOrder++;
        nextColour = palette[colourOrder%numberOfColours];
        if (randomColours) {
          nextColour = palette[rnd.nextInt(numberOfColours)];
        }

        drawPetal(canvas, P0, angle, radius, nextColour, null, petalToRadius, petalType, petalPointiness, petalRotation, petalRotationRatio, lineWidth, lineColour, randomiseAngle, gradientType, radialOscAmplitude, radialOscPeriod);

        angle = angle + angleIncrement;
        if (angle > 2 * pi) {
          angle = angle - 2 * pi;
        }

        radius = radius / ratio;

        maxPetals = maxPetals - 1;
      }
      while (radius > minRadius && radius < maxRadius && maxPetals > 0);

    }



  }


  drawPetal(canvas, P0, angle, radius, colour, colourGradient, petalToRadius, petalType, petalPointiness, petalRotation, petalRotationRatio, lineWidth, lineColour, randomiseAngle, gradientType, radialOscAmplitude, radialOscPeriod) {

    angle = angle + (rnd.nextDouble() - 0.5) * randomiseAngle;

    radius = radius + radius * (sin(radialOscPeriod * angle)+1)*radialOscAmplitude;

    switch (petalType) {
      case 0: //"circle":


        List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
        var petalRadius = radius * petalToRadius;

        canvas.drawCircle(Offset(P1[0], P1[1]), petalRadius, Paint() ..style = PaintingStyle.fill ..color = colour);
        canvas.drawCircle(Offset(P1[0], P1[1]), petalRadius, Paint() ..style = PaintingStyle.stroke ..strokeWidth = lineWidth ..color = lineColour);

        break;


      case 1: //"triangle":

        var P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
        var petalRadius = radius * petalToRadius;

        var PA = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio)];
        var PB = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * petalPointiness), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * petalPointiness)];
        var PC = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio - pi * petalPointiness), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio - pi * petalPointiness)];

        Path triangle = Path();
        triangle.moveTo(PA[0], PA[1]);
        triangle.lineTo(PB[0], PB[1]);
        triangle.lineTo(PC[0], PC[1]);
        triangle.close();

        canvas.drawPath(
            triangle,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = lineWidth
              ..color = lineColour);
        canvas.drawPath(
            triangle,
            Paint()
              ..style = PaintingStyle.fill
              ..color = colour);



        break;
      //
      // case "square":
      //
      //   var P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
      //   var petalRadius = radius * petalToRadius;
      //
      //   var PA = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * 0.0 + petalPointiness), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * 0.0 + petalPointiness)];
      //   var PB = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * 0.5 - petalPointiness), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * 0.5 - petalPointiness)];
      //   var PC = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * 1.0 + petalPointiness), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * 1.0 + petalPointiness)];
      //   var PD = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * 1.5 - petalPointiness), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * 1.5 - petalPointiness)];
      //
      //
      //   if (fullsize) {
      //     ctx.fillStyle = colour;
      //     ctx.strokeStyle = lineColour;
      //     ctx.lineWidth = lineWidth;
      //     ctx.lineJoin = "round";
      //
      //     if (gradientType != "none") {
      //
      //
      //       if (gradientType == "radial") {
      //         var grd = ctx.createLinearGradient(
      //           PA[0], PA[1],
      //           PC[0], PC[1],
      //         );
      //       }
      //       if (gradientType == "clockwise") {
      //         var grd = ctx.createLinearGradient(
      //           PB[0], PB[1],
      //           PD[0], PD[1],
      //         );
      //       }
      //       if (gradientType == "anticlockwise") {
      //         var grd = ctx.createLinearGradient(
      //           PD[0], PD[1],
      //           PB[0], PB[1],
      //         );
      //       }
      //
      //       grd.addColorStop(0, colour);
      //       grd.addColorStop(1, colourGradient);
      //       ctx.fillStyle = grd;
      //
      //     }
      //
      //
      //     ctx.beginPath();
      //     ctx.moveTo(PA[0], PA[1]);
      //     ctx.lineTo(PB[0], PB[1]);
      //     ctx.lineTo(PC[0], PC[1]);
      //     ctx.lineTo(PD[0], PD[1]);
      //     ctx.closePath();
      //     ctx.stroke();
      //     ctx.fill();
      //   }
      //   if (thumbnail) {
      //     canvas.fillStyle = colour;
      //     canvas.strokeStyle = lineColour;
      //     canvas.lineWidth = lineWidth;
      //     canvas.lineJoin = "round";
      //
      //     if (gradientType != "none") {
      //
      //
      //       if (gradientType == "radial") {
      //         var grd = canvas.createLinearGradient(
      //           PA[0], PA[1],
      //           PC[0], PC[1],
      //         );
      //       }
      //       if (gradientType == "clockwise") {
      //         var grd = canvas.createLinearGradient(
      //           PB[0], PB[1],
      //           PD[0], PD[1],
      //         );
      //       }
      //       if (gradientType == "anticlockwise") {
      //         var grd = canvas.createLinearGradient(
      //           PD[0], PD[1],
      //           PB[0], PB[1],
      //         );
      //       }
      //
      //       grd.addColorStop(0, colour);
      //       grd.addColorStop(1, colourGradient);
      //       canvas.fillStyle = grd;
      //
      //     }
      //
      //     canvas.beginPath();
      //     canvas.moveTo(PA[0], PA[1]);
      //     canvas.lineTo(PB[0], PB[1]);
      //     canvas.lineTo(PC[0], PC[1]);
      //     canvas.lineTo(PD[0], PD[1]);
      //     canvas.closePath();
      //     canvas.stroke();
      //     canvas.fill();
      //   }
      //
      //
      //   break;
      //
      // case "petal":
      //
      //   var P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
      //   var petalRadius = radius * petalToRadius;
      //
      //   var PA = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * 0.0), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * 0.0)];
      //   var PB = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * 0.5), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * 0.5)];
      //   var PC = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * 1.0), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * 1.0)];
      //   var PD = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * 1.5), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * 1.5)];
      //
      //
      //   if (fullsize) {
      //     ctx.fillStyle = colour;
      //     ctx.strokeStyle = lineColour;
      //     ctx.lineWidth = lineWidth;
      //     ctx.lineJoin = "round";
      //
      //     if (gradientType != "none") {
      //
      //
      //       if (gradientType == "radial") {
      //         var grd = ctx.createLinearGradient(
      //           PA[0], PA[1],
      //           PC[0], PC[1],
      //         );
      //       }
      //       if (gradientType == "clockwise") {
      //         var grd = ctx.createLinearGradient(
      //           PB[0], PB[1],
      //           PD[0], PD[1],
      //         );
      //       }
      //       if (gradientType == "anticlockwise") {
      //         var grd = ctx.createLinearGradient(
      //           PD[0], PD[1],
      //           PB[0], PB[1],
      //         );
      //       }
      //
      //       grd.addColorStop(0, colour);
      //       grd.addColorStop(1, colourGradient);
      //       ctx.fillStyle = grd;
      //
      //     }
      //
      //
      //     ctx.beginPath();
      //
      //     ctx.arc(PB[0], PB[1], petalRadius * 2, angle + petalRotation + angle*petalRotationRatio + pi * (0.5 + 2/3), angle + petalRotation + angle*petalRotationRatio + pi * (0.5+4/3));
      //     ctx.arc(PD[0], PD[1], petalRadius * 2, angle + petalRotation + angle*petalRotationRatio + pi * (1.5 + 2/3), angle + petalRotation + angle*petalRotationRatio + pi * (1.5+4/3));
      //
      //     ctx.closePath();
      //     ctx.stroke();
      //     ctx.fill();
      //   }
      //   if (thumbnail) {
      //     canvas.fillStyle = colour;
      //     canvas.strokeStyle = lineColour;
      //     canvas.lineWidth = lineWidth;
      //     canvas.lineJoin = "round";
      //
      //     if (gradientType != "none") {
      //
      //
      //       if (gradientType == "radial") {
      //         var grd = canvas.createLinearGradient(
      //           PA[0], PA[1],
      //           PC[0], PC[1],
      //         );
      //       }
      //       if (gradientType == "clockwise") {
      //         var grd = canvas.createLinearGradient(
      //           PB[0], PB[1],
      //           PD[0], PD[1],
      //         );
      //       }
      //       if (gradientType == "anticlockwise") {
      //         var grd = canvas.createLinearGradient(
      //           PD[0], PD[1],
      //           PB[0], PB[1],
      //         );
      //       }
      //
      //       grd.addColorStop(0, colour);
      //       grd.addColorStop(1, colourGradient);
      //       canvas.fillStyle = grd;
      //
      //     }
      //
      //     canvas.beginPath();
      //     canvas.arc(PB[0], PB[1], petalRadius * 2, angle + petalRotation + angle*petalRotationRatio + pi * (0.5 + 2/3), angle + petalRotation + angle*petalRotationRatio + pi * (0.5+4/3));
      //     canvas.arc(PD[0], PD[1], petalRadius * 2, angle + petalRotation + angle*petalRotationRatio + pi * (1.5 + 2/3), angle + petalRotation + angle*petalRotationRatio + pi * (1.5+4/3));
      //     canvas.closePath();
      //     canvas.stroke();
      //     canvas.fill();
      //   }
      //
      //
      //   break;
    }

  }

  randomisePalette(){

    //  backgroundColour
    backgroundColour = Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
    print('backgroundColor: $backgroundColour');

  // numberOfColours from 1 to 24
    numberOfColours = rnd.nextInt(24)+1;
    print('numberOfColours: $numberOfColours');

    // opacity - from 0 to 1 - 50% of time =1
    opacity = rnd.nextDouble();
    if (rnd.nextInt(2)==0){
      opacity = 1;
    }
    print('opacity: $opacity');

    // paletteType - 0=random; 1=blended random; 2=linear random; 3=linear complimentary;
    paletteType = rnd.nextInt(4);
    print('paletteType: $paletteType');

    // randomise the palette
    List palette = [];

    switch(paletteType){

    // blended random
      case 1:{
        double blendColour = rnd.nextDouble() * 0xFFFFFF;
        for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++){
          palette.add(Color(((blendColour + rnd.nextDouble() * 0xFFFFFF)/2).toInt()).withOpacity(opacity));
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
          palette.add(Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity));
        }
      }
      break;

    }

    // randomColours - true or false
    bool randomColours = rnd.nextBool();
    print('randomColours: $randomColours');

    // backgroundColor
    Color backgroundColor = Colors.grey[200];
    print('backgroundColor: $backgroundColor');

    // lineColour
    lineColour = Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity);
    print('lineColour: $lineColour');

    // gradientType
    gradientType = 0;
    print('gradientType: $gradientType');

    return palette;

  }

  randomiseSettings(){


    // lineWidth
    double lineWidth = rnd.nextDouble()*10;
    print('lineWidth: $lineWidth');

    // angleIncrement,
    angleIncrement = rnd.nextDouble()*pi;
    print('angleIncrement: $angleIncrement');

    // flowerFill
    flowerFill = rnd.nextDouble() * 0.75 + 0.5;
    print('flowerFill: $flowerFill');

    // petalToRadius
    petalToRadius = rnd.nextDouble()*0.2+0.01;
    print('petalToRadius: $petalToRadius');

    // ratio
    ratio = 1-rnd.nextDouble()/500;
    print('ratio: $ratio');

    // randomiseAngle
    randomiseAngle = rnd.nextDouble() * pi;
    if (rnd.nextDouble()>0.2) {
      randomiseAngle = 0;
    }
    print('randomiseAngle: $randomiseAngle');

    // petalPointiness
    petalPointiness = rnd.nextDouble();
    print('petalPointiness: $petalPointiness');


    // petalRotation,
    petalRotation = rnd.nextDouble() * pi;
    if (rnd.nextBool()) {
      petalRotation = 0;
    }
    print('petalRotation: $petalRotation');

    // petalRotationRatio,
    petalRotationRatio = rnd.nextDouble();
    if (rnd.nextBool()) {
      petalRotationRatio = 0;
    }
    print('petalRotationRatio: $petalRotationRatio');

    // petalType,
    petalType = rnd.nextInt(2);
    print('petalType: $petalType');

    // maxPetals,
    maxPetals = 20000;
    print('maxPetals: $maxPetals');

    // radialOscAmplitude,
    radialOscAmplitude = rnd.nextDouble();
    if (rnd.nextBool()) {
      radialOscAmplitude = 0;
    }
    print('radialOscAmplitude: $radialOscAmplitude');

    // radialOscPeriod,
    radialOscPeriod = rnd.nextDouble();
    if (rnd.nextBool()) {
      radialOscPeriod = 0;
    }
    print('radialOscPeriod: $radialOscPeriod');

    // direction
    direction = rnd.nextBool();
    direction = true;
    print('direction: $direction');




  }

  @override
  bool shouldRepaint(OpArtFibonacciPainter oldDelegate) => false;
}
