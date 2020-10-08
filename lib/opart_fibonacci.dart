import 'package:flutter/material.dart';
import 'dart:math';
import 'side_drawer.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

//void main() {
//  runApp(OpArtFibonacci());
//}

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
void changeColor(int index, Color color) {
  palette.replaceRange(index, index + 1, [color]);
}

double angleIncrement = 1.6181;

class OpArtFibonacciStudio extends StatefulWidget {
  bool showSettings;
  OpArtFibonacciStudio(this.showSettings);

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
          min: 1.6,
          max: 1.7,
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
    rnd = Random(1001);
  }

  Widget bodyWidget() {
    return Stack(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.showSettings);
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
      ..color = Color(0xff638965)
      ..style = PaintingStyle.fill;
    //a rectangle
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight), paint1);


    Color backgroundColour = Colors.white;
    print('backgroundColor: $backgroundColour');

    int gradientType = 0;
    print('gradientType: $gradientType');

    int numberOfColours = palette.length;
    print('numberOfColours: $numberOfColours');

    bool randomColours = rnd.nextBool();
    print('randomColours: $randomColours');

    double lineWidth = 0; //rnd.nextDouble() * 10;
    print('lineWidth: $lineWidth');

    // opacity - from 0 to 1 - 50% of time =1
    double opacity = rnd.nextDouble();
    if (rnd.nextInt(2) == 0) {
      opacity = 1;
    }
    print('opacity: $opacity');

    Color lineColour = Color((Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(opacity);
    print('lineColour: $lineColour');

    double flowerCentreX = imageWidth / 2;
    double flowerCentreY = imageHeight / 2;
    print('flowerCentreX: $flowerCentreX');
    print('flowerCentreY: $flowerCentreY');

    double flowerFill = rnd.nextDouble() * 2 + 0.5;
    print('flowerFill: $flowerFill');

    double petalToRadius = 0.03;
    print('petalToRadius: $petalToRadius');

    double ratio = 0.999;
    print('ratio: $ratio');

    double randomiseAngle = rnd.nextDouble() * pi;
    if (rnd.nextBool()) {
      randomiseAngle = 0;
    }
    print('randomiseAngle: $randomiseAngle');

    // angleIncrement,
    double angleIncrement = rnd.nextDouble();
    if (rnd.nextBool()) {
      angleIncrement = 0;
    }
    print('angleIncrement: $angleIncrement');

    double petalPointiness = rnd.nextDouble();
    print('petalPointiness: $petalPointiness');


    // petalRotation,
    double petalRotation = rnd.nextDouble() * pi;
    if (rnd.nextBool()) {
      petalRotation = 0;
    }
    print('petalRotation: $petalRotation');

    // petalRotationRatio,
    double petalRotationRatio = rnd.nextDouble();
    if (rnd.nextBool()) {
      petalRotationRatio = 0;
    }
    print('petalRotationRatio: $petalRotationRatio');


    // petalType,
    int petalType = 0;
    print('petalType: $petalType');

    // maxPetals,
    int maxPetals = 5000;
    print('maxPetals: $maxPetals');


    // radialOscAmplitude,
    double radialOscAmplitude = rnd.nextDouble();
    if (rnd.nextBool()) {
      radialOscAmplitude = 0;
    }
    print('radialOscAmplitude: $radialOscAmplitude');

    // radialOscPeriod,
    double radialOscPeriod = rnd.nextDouble();
    if (rnd.nextBool()) {
      radialOscPeriod = 0;
    }
    print('radialOscPeriod: $radialOscPeriod');

    // direction
    bool direction = rnd.nextBool();
    direction = true;
    print('direction: $direction');


    generateFlower(
        canvas,
        imageWidth,
        imageHeight,
        borderX,
        borderY,
        backgroundColour,
        gradientType,
        numberOfColours,
        randomColours,
        palette,
        lineColour,
        lineWidth,
        opacity,
        flowerCentreX,
        flowerCentreY,
        flowerFill,
        petalToRadius,
        ratio,
        randomiseAngle,
        angleIncrement,
        petalPointiness,
        petalRotation,
        petalRotationRatio,
        petalType,
        maxPetals,
        radialOscAmplitude,
        radialOscPeriod,
        direction
    );

    // colour in the outer canvas
    paint1 = Paint()
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
      Color backgroundColour,
      gradientType, numberOfColours, randomColours, Colours, lineColour, lineWidth, opacity,
      flowerCentreX, flowerCentreY, flowerFill, petalToRadius, ratio, randomiseAngle, angleIncrement, petalPointiness, petalRotation, petalRotationRatio,
      petalType, maxPetals, radialOscAmplitude, radialOscPeriod, direction) {

    // start the colour order
    int colourOrder=0;
    Color nextColour;
    
    // clear the canvas
    //ctx.clearRect(0, 0, canvas.width, canvas.height);
    //ctxThumb.clearRect(0, 0, canvas.width, canvas.height);


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

      //
      // case "triangle":
      //
      //   var P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
      //   var petalRadius = radius * petalToRadius;
      //
      //   var PA = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio)];
      //   var PB = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio + pi * petalPointiness), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio + pi * petalPointiness)];
      //   var PC = [P1[0] + petalRadius * cos(angle + petalRotation + angle*petalRotationRatio - pi * petalPointiness), P1[1] + petalRadius * sin(angle + petalRotation + angle*petalRotationRatio - pi * petalPointiness)];
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
      //             P1[0] + petalRadius * cos(angle), P1[1] + petalRadius * sin(angle),
      //             P1[0] + petalRadius * cos(angle + pi), P1[1] + petalRadius * sin(angle + pi)
      //         );
      //       }
      //       if (gradientType == "clockwise") {
      //         var grd = ctx.createLinearGradient(
      //             P1[0] + petalRadius * cos(angle + pi/2), P1[1] + petalRadius * sin(angle + pi/2),
      //             P1[0] + petalRadius * cos(angle + pi * 3/2), P1[1] + petalRadius * sin(angle + pi * 3/2)
      //         );
      //       }
      //       if (gradientType == "anticlockwise") {
      //         var grd = ctx.createLinearGradient(
      //             P1[0] + petalRadius * cos(angle - pi/2), P1[1] + petalRadius * sin(angle - pi/2),
      //             P1[0] + petalRadius * cos(angle + pi/2), P1[1] + petalRadius * sin(angle + pi/2)
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
      //     ctx.closePath();
      //     ctx.stroke();
      //     ctx.fill();
      //   }
      //   if (thumbnail) {
      //     ctxThumb.fillStyle = colour;
      //     ctxThumb.strokeStyle = lineColour;
      //     ctxThumb.lineWidth = lineWidth;
      //     ctxThumb.lineJoin = "round";
      //
      //     if (gradientType != "none") {
      //
      //
      //       if (gradientType == "radial") {
      //         var grd = ctxThumb.createLinearGradient(
      //             P1[0] + petalRadius * cos(angle), P1[1] + petalRadius * sin(angle),
      //             P1[0] + petalRadius * cos(angle + pi), P1[1] + petalRadius * sin(angle + pi)
      //         );
      //       }
      //       if (gradientType == "clockwise") {
      //         var grd = ctxThumb.createLinearGradient(
      //             P1[0] + petalRadius * cos(angle + pi/2), P1[1] + petalRadius * sin(angle + pi/2),
      //             P1[0] + petalRadius * cos(angle + pi * 3/2), P1[1] + petalRadius * sin(angle + pi * 3/2)
      //         );
      //       }
      //       if (gradientType == "anticlockwise") {
      //         var grd = ctxThumb.createLinearGradient(
      //             P1[0] + petalRadius * cos(angle - pi/2), P1[1] + petalRadius * sin(angle - pi/2),
      //             P1[0] + petalRadius * cos(angle + pi/2), P1[1] + petalRadius * sin(angle + pi/2)
      //         );
      //       }
      //
      //       grd.addColorStop(0, colour);
      //       grd.addColorStop(1, colourGradient);
      //       ctxThumb.fillStyle = grd;
      //
      //     }
      //
      //     ctxThumb.beginPath();
      //     ctxThumb.moveTo(PA[0], PA[1]);
      //     ctxThumb.lineTo(PB[0], PB[1]);
      //     ctxThumb.lineTo(PC[0], PC[1]);
      //     ctxThumb.closePath();
      //     ctxThumb.stroke();
      //     ctxThumb.fill();
      //   }
      //
      //
      //   break;
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
      //     ctxThumb.fillStyle = colour;
      //     ctxThumb.strokeStyle = lineColour;
      //     ctxThumb.lineWidth = lineWidth;
      //     ctxThumb.lineJoin = "round";
      //
      //     if (gradientType != "none") {
      //
      //
      //       if (gradientType == "radial") {
      //         var grd = ctxThumb.createLinearGradient(
      //           PA[0], PA[1],
      //           PC[0], PC[1],
      //         );
      //       }
      //       if (gradientType == "clockwise") {
      //         var grd = ctxThumb.createLinearGradient(
      //           PB[0], PB[1],
      //           PD[0], PD[1],
      //         );
      //       }
      //       if (gradientType == "anticlockwise") {
      //         var grd = ctxThumb.createLinearGradient(
      //           PD[0], PD[1],
      //           PB[0], PB[1],
      //         );
      //       }
      //
      //       grd.addColorStop(0, colour);
      //       grd.addColorStop(1, colourGradient);
      //       ctxThumb.fillStyle = grd;
      //
      //     }
      //
      //     ctxThumb.beginPath();
      //     ctxThumb.moveTo(PA[0], PA[1]);
      //     ctxThumb.lineTo(PB[0], PB[1]);
      //     ctxThumb.lineTo(PC[0], PC[1]);
      //     ctxThumb.lineTo(PD[0], PD[1]);
      //     ctxThumb.closePath();
      //     ctxThumb.stroke();
      //     ctxThumb.fill();
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
      //     ctxThumb.fillStyle = colour;
      //     ctxThumb.strokeStyle = lineColour;
      //     ctxThumb.lineWidth = lineWidth;
      //     ctxThumb.lineJoin = "round";
      //
      //     if (gradientType != "none") {
      //
      //
      //       if (gradientType == "radial") {
      //         var grd = ctxThumb.createLinearGradient(
      //           PA[0], PA[1],
      //           PC[0], PC[1],
      //         );
      //       }
      //       if (gradientType == "clockwise") {
      //         var grd = ctxThumb.createLinearGradient(
      //           PB[0], PB[1],
      //           PD[0], PD[1],
      //         );
      //       }
      //       if (gradientType == "anticlockwise") {
      //         var grd = ctxThumb.createLinearGradient(
      //           PD[0], PD[1],
      //           PB[0], PB[1],
      //         );
      //       }
      //
      //       grd.addColorStop(0, colour);
      //       grd.addColorStop(1, colourGradient);
      //       ctxThumb.fillStyle = grd;
      //
      //     }
      //
      //     ctxThumb.beginPath();
      //     ctxThumb.arc(PB[0], PB[1], petalRadius * 2, angle + petalRotation + angle*petalRotationRatio + pi * (0.5 + 2/3), angle + petalRotation + angle*petalRotationRatio + pi * (0.5+4/3));
      //     ctxThumb.arc(PD[0], PD[1], petalRadius * 2, angle + petalRotation + angle*petalRotationRatio + pi * (1.5 + 2/3), angle + petalRotation + angle*petalRotationRatio + pi * (1.5+4/3));
      //     ctxThumb.closePath();
      //     ctxThumb.stroke();
      //     ctxThumb.fill();
      //   }
      //
      //
      //   break;
    }

  }


  @override
  bool shouldRepaint(OpArtFibonacciPainter oldDelegate) => false;
}
