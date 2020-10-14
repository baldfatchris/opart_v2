import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'package:screenshot/screenshot.dart';


Random rnd;
List palette;
Color backgroundColor = Colors.grey;

int cellsX = 5;
int cellsY = 5;

int shape = 0;
double driftX = 0;
double driftXStep = 0;
double driftY = 0;
double driftYStep = 0;
bool alternateDrift = true;
bool box = true;
double step = 0.3;
double stepStep = 0.9;
double ratio = 1;
double offsetX = 0;
double offsetY = 0;
double rotate = 0;
bool randomRotation = false;
double rotateStep = 0.5;
double squareness = 0.7;
double squeezeX = 1;
double squeezeY = 1;



double lineWidth = 0;
Color lineColor = Colors.grey;
bool resetColours = true;

bool randomColours = false;
int numberOfColours = 12;
int paletteType = 0;
double opacity = 1;

void changeColor(int index, Color color) {
  palette.replaceRange(index, index + 1, [color]);
}

randomisePalette(int numberOfColours, int paletteType){
  print('numberOfColours: $numberOfColours paletteType: $paletteType');
  rnd = Random(DateTime.now().millisecond);


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
    case 3:{
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
  return palette;
}






class OpArtWallpaperStudio extends StatefulWidget {

  int seed;
  bool showSettings;
  ScreenshotController screenshotController;

  OpArtWallpaperStudio(this.seed, this.showSettings, {this.screenshotController});

  @override
  _OpArtWallpaperStudioState createState() => _OpArtWallpaperStudioState();
}
class _OpArtWallpaperStudioState extends State<OpArtWallpaperStudio> {
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

        // cellsX
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('cellsX: $cellsX'),
            Slider(
              value: cellsX.toDouble(),
              min: 1,
              max: 12,
              onChanged: (value) {
                setState(() {
                  cellsX  = value.toInt();
                });
              },
              label: '$cellsX ',
            ),
          ],
        ),

        // cellsY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('cellsY: $cellsY'),
            Slider(
              value: cellsY.toDouble(),
              min: 1,
              max: 12,
              onChanged: (value) {
                setState(() {
                  cellsY  = value.toInt();
                });
              },
              label: '$cellsY ',
            ),
          ],
        ),

    // shape
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('shape'),
            DropdownButton(
              value: shape,
              items: [
                DropdownMenuItem(
                  child: Text("circle"),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text("squaricle"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("star"),
                  value: 2,
                ),
              ],
              onChanged:(value) {
                setState(() {
                  shape = value;
                });
              },
            ),
          ],
        ),

        // driftX
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('driftX - ${driftX.toStringAsFixed(2)}'),
            Slider(
              value: driftX,
              min: -20,
              max: 20,
              onChanged: (value) {
                setState(() {
                  driftX  = value;
                });
              },
            ),
          ],
        ),

        // driftXStep
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('driftXStep - ${driftXStep.toStringAsFixed(2)}'),
            Slider(
              value: driftXStep,
              min: -2,
              max: 2,
              onChanged: (value) {
                setState(() {
                  driftXStep  = value;
                });
              },
            ),
          ],
        ),

        // driftY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('driftY - ${driftY.toStringAsFixed(2)}'),
            Slider(
              value: driftY,
              min: -20,
              max: 20,
              onChanged: (value) {
                setState(() {
                  driftY  = value;
                });
              },
            ),
          ],
        ),

        // driftYStep
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('driftYStep - ${driftYStep.toStringAsFixed(2)}'),
            Slider(
              value: driftYStep,
              min: -2,
              max: 2,
              onChanged: (value) {
                setState(() {
                  driftYStep  = value;
                });
              },
            ),
          ],
        ),

        // alternateDrift
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('alternateDrift'),
            Switch(
              value: alternateDrift,
              onChanged: (value) {
                setState(() {
                  alternateDrift  = value;
                });
              },
            ),

          ],
        ),


    // box
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('box'),
            Switch(
              value: box,
              onChanged: (value) {
                setState(() {
                  box  = value;
                });
              },
            ),

          ],
        ),

        // step
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('step - ${step.toStringAsFixed(2)}'),
            Slider(
              value: step,
              min: 0.01,
              max: 1,
              onChanged: (value) {
                setState(() {
                  step  = value;
                });
              },
            ),
          ],
        ),

        // stepStep
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('stepStep - ${stepStep.toStringAsFixed(2)}'),
            Slider(
              value: stepStep,
              min: 0.5,
              max: 1,
              onChanged: (value) {
                setState(() {
                  stepStep  = value;
                });
              },
            ),
          ],
        ),

        // ratio
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ratio - ${ratio.toStringAsFixed(2)}'),
            Slider(
              value: ratio,
              min: 0,
              max: 2,
              onChanged: (value) {
                setState(() {
                  ratio  = value;
                });
              },
            ),
          ],
        ),


        // offsetX
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('offsetX - ${offsetX.toStringAsFixed(2)}'),
            Slider(
              value: offsetX,
              min: -50,
              max: 50,
              onChanged: (value) {
                setState(() {
                  offsetX  = value;
                });
              },
            ),
          ],
        ),

        // offsetY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('offsetY - ${offsetY.toStringAsFixed(2)}'),
            Slider(
              value: offsetY,
              min: -50,
              max: 50,
              onChanged: (value) {
                setState(() {
                  offsetY  = value;
                });
              },
            ),
          ],
        ),

        // rotate
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('rotate - ${rotate.toStringAsFixed(2)}'),
            Slider(
              value: rotate,
              min: 0,
              max: 2,
              onChanged: (value) {
                setState(() {
                  rotate  = value;
                });
              },
            ),
          ],
        ),

        // rotateStep
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('rotateStep - ${rotateStep.toStringAsFixed(2)}'),
            Slider(
              value: rotateStep,
              min: 0,
              max: 1,
              onChanged: (value) {
                setState(() {
                  rotateStep  = value;
                });
              },
            ),
          ],
        ),

        // randomRotation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('randomRotation'),
            Switch(
              value: randomRotation,
              onChanged: (value) {
                setState(() {
                  randomRotation  = value;
                });
              },
            ),

          ],
        ),

        // squareness
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('squareness - ${squareness.toStringAsFixed(2)}'),
            Slider(
              value: squareness,
              min: -2,
              max: 2,
              onChanged: (value) {
                setState(() {
                  squareness  = value;
                });
              },
            ),
          ],
        ),

        // squeezeX
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('squeezeX - ${squeezeX.toStringAsFixed(2)}'),
            Slider(
              value: squeezeX,
              min: 0.1,
              max: 2,
              onChanged: (value) {
                setState(() {
                  squeezeX  = value;
                });
              },
            ),
          ],
        ),

        // squeezeY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('squeezeY - ${squeezeY.toStringAsFixed(2)}'),
            Slider(
              value: squeezeY,
              min: 0.1,
              max: 2,
              onChanged: (value) {
                setState(() {
                  squeezeY  = value;
                });
              },
            ),
          ],
        ),

        // numberOfColours
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('numberOfColours - $numberOfColours'),
            Slider(
              value: numberOfColours.toDouble(),
              min: 2,
              max: 36,
              onChanged: (value) {
                setState(() {
                  if (numberOfColours<value){
                    palette = randomisePalette(value.toInt(), paletteType);
                  }
                  numberOfColours  = value.toInt();
                });
              },
            ),
          ],
        ),

        // randomColours
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('randomColours'),
            Switch(
              value: randomColours,
              onChanged: (value) {
                setState(() {
                  randomColours  = value;
                });
              },
            ),

          ],
        ),

        // resetColours
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('resetColours'),
            Switch(
              value: resetColours,
              onChanged: (value) {
                setState(() {
                  resetColours  = value;
                });
              },
            ),

          ],
        ),


        // paletteType
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('paletteType'),

            DropdownButton(
              value: paletteType,
              items: [
                DropdownMenuItem(
                  child: Text("random"),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text("blended random"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("linear random"),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text("linear complementary"),
                  value: 3,
                ),
              ],
              onChanged:(value) {
                setState(() {
                  paletteType = value;
                  palette = randomisePalette(numberOfColours, value);
                });
              },
            ),

          ],
        ),



        FloatingActionButton.extended(
          label: Text('Randomise Palette'),
          icon: Icon(Icons.donut_large),
          //backgroundColor: Colors.pink,

          onPressed:() {
            setState(() {

              print('FloatingActionButton Pressed');
              palette = randomisePalette(numberOfColours, paletteType);
              print('line 208  palette: $palette');

            });
          },
        ),
      ],
    );
  }



  @override

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
                child: CustomPaint(painter: OpArtWallpaperPainter(widget.seed, rnd)),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = widget.screenshotController;
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
                  child: CustomPaint(painter: OpArtWallpaperPainter(widget.seed, rnd)),
                ),
              ),
            )
          ],
        ),
      );
    }



    return Scaffold(

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

        ],
      ),
    );
  }
}

class OpArtWallpaperPainter extends CustomPainter {
  int seed;//
  Random rnd;

  OpArtWallpaperPainter( this.seed, this.rnd);

  @override
  void paint(Canvas canvas, Size size) {
    // define the paint object

print('-----------------------------------------------------------');

    rnd = Random(seed);
    print('seed: $seed');

    print('cellsX: $cellsX');
    print('cellsY: $cellsY');

    double canvasWidth = size.width;
    double canvasHeight = size.height;
    double borderX = 0;
    double borderY = 0;

    double imageWidth = canvasWidth;
    double imageHeight = canvasHeight;

    // aspectRation from 0.5 to 2 - or 33% of time fit to screen, 33% of time make it 1
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
    print('numberOfColours: $numberOfColours');

    // opacity - from 0 to 1 - 50% of time =1
    print('opacity: $opacity');

    // paletteType - 0=random; 1=blended random; 2=linear random; 3=linear complimentary;
    print('paletteType: $paletteType');

    // randomise the palette
    if (palette == null) {
      print('randomisePalette: $numberOfColours, $paletteType');
      palette = randomisePalette(numberOfColours, paletteType);
    }
    print('palette: $palette');
    print('numberOfColours: $numberOfColours');

    int colourOrder = 0;


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
    // double step = rnd.nextDouble() * radius;
    print('step: $step');

    // double stepStep = rnd.nextDouble() * 2;
    // if (rnd.nextBool()) {stepStep= 0;}
    print('stepStep: $stepStep');

    // Ratio
    // double ratio = 1;
    print('ratio: $ratio');

    // offsetX & offsetY
    // double offsetX = rnd.nextDouble()*20-10;
    // double offsetY = rnd.nextDouble()*20-10;
    // if (rnd.nextBool()){
    //   offsetX=0;
    //   offsetY=0;
    // }
    print('offsetX: $offsetX');
    print('offsetY: $offsetY');

    // Squeeze
    // double squeezeX = 1;
    // double squeezeY = 1;
    print('squeezeX: $squeezeX');
    print('squeezeY: $squeezeY');

// Rotate
    // double rotate = rnd.nextDouble() * pi * 2;
    // if (rnd.nextBool()){rotate = 0;}
    print('rotate: $rotate');

    // bool randomRotation = rnd.nextBool();
    print('randomRotation: $randomRotation');

    // double rotateStep = rnd.nextDouble()*5;
    // if (rnd.nextBool()){rotateStep = 0;}
    print('rotateStep: $rotateStep');


    // alternateDrift
    // bool alternateDrift = rnd.nextBool();
    print('alternateDrift: $alternateDrift');

    // resetColours
    // bool resetColours = rnd.nextBool();
    print('resetColours: $resetColours');

    // box
    print('box: $box');

    // shape
    // int shape = rnd.nextInt(3);
    print('shape: $shape');

    // driftX & driftY
    // double driftX = rnd.nextDouble() * 5;
    // double driftY = rnd.nextDouble() * 5;
    // if (rnd.nextBool()){
    //   driftX=0;
    //   driftY=0;
    // }
    print('driftX: $driftX');
    print('driftY: $driftY');

    // double driftXStep = rnd.nextDouble() *2;
    // double driftYStep = rnd.nextDouble() *2;
    // if (rnd.nextBool()){
    //   driftXStep=0;
    //   driftYStep=0;
    // }
    print('driftXStep: $driftXStep');
    print('driftYStep: $driftYStep');

    // squareness
    // double squareness = rnd.nextDouble()*2;
    // if (rnd.nextBool()){
    //   squareness=rnd.nextDouble()/2+0.5;
    // }
    print('squareness: $squareness');

    // Number of petals
    int numberOfPetals = rnd.nextInt(15);
    bool randomPetals = rnd.nextBool();
    print('numberOfPetals: $numberOfPetals');
    print('randomPetals: $randomPetals');




    for (int j = 0 - extraCellsY; j < cellsY + extraCellsY; j++) {
      for (int i = 0 - extraCellsX; i < cellsX + extraCellsX; i++) {

        int k = 0; // count the steps

        double dX = 0;
        double dY = 0;

        double stepRadius = radius * ratio;
        double localStep = step * radius;

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
          localNumberOfPetals =  rnd.nextInt(numberOfPetals) + 3;
        }

        // Centre of the square
        List PO = [
          borderX + radius * (1 - squeezeX) + dX + (offsetX * j) + (i * 2 + 1) * radius * squeezeX,
          borderY + radius * (1 - squeezeY) + dY + (offsetY * i) + (j * 2 + 1) * radius * squeezeY
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
          if (alternateDrift && (i + j) % 2 == 0) {
            localRotate = localRotate - rotateStep;
          }
          else {
            localRotate = localRotate + rotateStep;
          }
          if (alternateDrift && (i) % 2 == 0) {
            dX = dX - driftX - k * driftXStep;
          }
          else {
            dX = dX + driftX + k * driftXStep;
          }
          if (alternateDrift && (j) % 2 == 0) {
            dY = dY - driftY - k * driftYStep;
          }
          else {
            dY = dY + driftY + k * driftYStep;
          }

          localStep = localStep * stepStep;
          stepRadius = stepRadius - localStep;
          k++;


        } while (k<50 && stepRadius > 0 && step > 0);

      }
    }

    // colour in the outer canvas
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(0, 0) & Size(borderX, canvasHeight), paint1);
    canvas.drawRect(Offset(canvasWidth-borderX, 0) & Size(borderX, canvasHeight), paint1);

    canvas.drawRect(Offset(0, 0) & Size(canvasWidth, borderY ), paint1);
    canvas.drawRect(Offset(0, canvasHeight-borderY, ) & Size(canvasWidth, borderY+1000), paint1);



  }

  @override
  bool shouldRepaint(OpArtWallpaperPainter oldDelegate) => false;
}

List edgePoint(List Point1, List Point2, double ratio) {
  return [Point1[0] * (ratio) + Point2[0] * (1 - ratio), Point1[1] * (ratio) + Point2[1] * (1 - ratio)];
}