import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'package:screenshot/screenshot.dart';


Random rnd;

List palette;
Color backgroundColor = Colors.grey;

int cellsX = 5;
bool cellsXLOCK = false;

int cellsY = 5;
bool cellsYLOCK = false;

int shape = 0;
bool shapeLOCK = false;

double driftX = 0;
bool driftXLOCK = false;

double driftXStep = 0;
bool driftXStepLOCK = false;

double driftY = 0;
bool driftYLOCK = false;

double driftYStep = 0;
bool driftYStepLOCK = false;

bool alternateDrift = true;
bool alternateDriftLOCK = false;

bool box = true;
bool boxLOCK = false;

double step = 0.3;
bool stepLOCK = false;

double stepStep = 0.9;
bool stepStepLOCK = false;

double ratio = 1;
bool ratioLOCK = false;

double offsetX = 0;
bool offsetXLOCK = false;

double offsetY = 0;
bool offsetYLOCK = false;

double rotate = 0;
bool rotateLOCK = false;

bool randomRotation = false;
bool randomRotationLOCK = false;

double rotateStep = 0.5;
bool rotateStepLOCK = false;

double squareness = 0.7;
bool squarenessLOCK = false;

double squeezeX = 1;
bool squeezeXLOCK = false;

double squeezeY = 1;
bool squeezeYLOCK = false;


int numberOfPetals = 7;
bool numberOfPetalsLOCK = false;

bool randomPetals = true;
bool randomPetalsLOCK = false;


double lineWidth = 0;
bool lineWidthLOCK = false;

Color lineColor = Colors.grey;
bool lineColorLOCK = false;

bool resetColours = true;
bool resetColoursLOCK = false;

bool randomColours = false;
bool randomColoursLOCK = false;

int numberOfColours = 12;
bool numberOfColoursLOCK = false;

int paletteType = 0;
bool paletteTypeLOCK = false;

double opacity = 1;
bool opacityLOCK = false;

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

randomiseSettings() {

  // cellsX 1 to 10
  if (cellsXLOCK == false) {
    cellsX = rnd.nextInt(9) + 1;
  }

  // cellsY 1 to 10
  if (cellsYLOCK == false) {
    cellsY = rnd.nextInt(9) + 1;
    if (rnd.nextBool()) {
      cellsY = cellsX;
    }
  }

  // shape 0 to 2
  if (shapeLOCK == false) {
    shape = rnd.nextInt(3);
  }

  // driftX -20 to 20
  if (driftXLOCK == false){
    if (rnd.nextBool()) {
      driftX = 0;
    } else if (rnd.nextBool()) {
      driftX = rnd.nextDouble() * 10 - 5;
    } else if (rnd.nextBool()) {
      driftX = rnd.nextDouble() * 20 - 10;
    } else if (rnd.nextBool()) {
      driftX = rnd.nextDouble() * 40 - 20;
    }
  }

  // driftY -20 to 20
  if (driftYLOCK == false){
    if (rnd.nextBool()) {
      driftY = 0;
    } else if (rnd.nextBool()) {
      driftY = rnd.nextDouble() * 10 - 5;
    } else if (rnd.nextBool()) {
      driftY = rnd.nextDouble() * 20 - 10;
    } else if (rnd.nextBool()) {
      driftY = rnd.nextDouble() * 40 - 20;
    }
  }

  // driftXStep -2 to 2
  if (driftXStepLOCK == false){
    if (rnd.nextBool()) {
      driftXStep = 0;
    } else if (rnd.nextBool()) {
      driftXStep = rnd.nextDouble() * 1 - 0.5;
    } else if (rnd.nextBool()) {
      driftXStep = rnd.nextDouble() * 2 - 1;
    } else if (rnd.nextBool()) {
      driftXStep = rnd.nextDouble() * 4 - 2;
    }
  }

  // driftYStep -2 to 2
  if (driftYStepLOCK == false){
    if (rnd.nextBool()) {
      driftYStep = 0;
    } else if (rnd.nextBool()) {
      driftYStep = rnd.nextDouble() * 1 - 0.5;
    } else if (rnd.nextBool()) {
      driftYStep = rnd.nextDouble() * 2 - 1;
    } else if (rnd.nextBool()) {
      driftYStep = rnd.nextDouble() * 4 - 2;
    }
  }

  // alternateDrift
  if (alternateDriftLOCK == false) {
    alternateDrift = rnd.nextBool();
  }

  // box
  if (boxLOCK == false) {
    box = rnd.nextBool();
  }

  // step 0.05 to 1
  if (stepLOCK == false) {
    step = rnd.nextDouble() * 0.95 + 0.05;
  }

  // stepStep 0.5 to 1
  if (stepStepLOCK == false) {
    if (rnd.nextBool()) {
      stepStep = 1;
    } else {
      stepStep = rnd.nextDouble() * 0.5 + 0.5;
    }
  }

  // ratio 0.75 to 1.75
  if (ratioLOCK == false) {
    ratio = rnd.nextDouble() + 0.75;
  }

  // offsetX -50 to 50
  if (offsetXLOCK == false) {
    if (rnd.nextBool()) {
      offsetX = 0;
    } else if (rnd.nextBool()) {
      offsetX = rnd.nextDouble() * 10 - 5;
    } else if (rnd.nextBool()) {
      offsetX = rnd.nextDouble() * 20 - 10;
    } else if (rnd.nextBool()) {
      offsetX = rnd.nextDouble() * 50 - 25;
    } else if (rnd.nextBool()) {
      offsetX = rnd.nextDouble() * 100 - 50;
    }
  }

  // offsetY -50 to 50
  if (offsetYLOCK == false) {
    if (rnd.nextBool()) {
      offsetY = 0;
    } else if (rnd.nextBool()) {
      offsetY = rnd.nextDouble() * 10 - 5;
    } else if (rnd.nextBool()) {
      offsetY = rnd.nextDouble() * 20 - 10;
    } else if (rnd.nextBool()) {
      offsetY = rnd.nextDouble() * 50 - 25;
    } else if (rnd.nextBool()) {
      offsetY = rnd.nextDouble() * 100 - 50;
    }
  }

  // rotate 0 to 2
  if (rotateLOCK == false) {
    if (rnd.nextBool()) {
      rotate = 0;
    } else if (rnd.nextBool()) {
      rotate = rnd.nextDouble() * 2;
    }
    if (rnd.nextBool()) {
      rotateStep = 0;
    } else if (rnd.nextBool()) {
      rotateStep = rnd.nextDouble();
    }
  }

  // randomRotation
  if (randomRotationLOCK == false) {
    randomRotation = rnd.nextBool();
  }

  // squareness -2 to 2
  if (squarenessLOCK == false) {
    squareness = rnd.nextDouble() * 4 - 2;
  }

  // squeezeX 0.5 to 1.5
  if (squeezeXLOCK == false) {
    if (rnd.nextBool()) {
      squeezeX = 1;
    } else if (rnd.nextBool()) {
      squeezeX = rnd.nextDouble() * 1 + 0.5;
    }
  }

  // squeezeY 0.5 to 1.5
  if (squeezeYLOCK == false) {
    if (rnd.nextBool()) {
      squeezeY = 1;
    } else if (rnd.nextBool()) {
      squeezeY = rnd.nextDouble() * 1 + 0.5;
    }
  }

  // numberOfPetals 1 to 15
  if (numberOfPetalsLOCK == false) {
    numberOfPetals = rnd.nextInt(14) + 1;
  }
  
  // randomPetals
  if (randomPetalsLOCK == false) {
    randomPetals = rnd.nextBool();
  }
  
  numberOfColours = rnd.nextInt(34)+2;
  if (rnd.nextBool()){
    opacity=rnd.nextDouble();
  } else {
    opacity=1;
  }

  // randomColours 
  if (randomColoursLOCK == false) {
    randomColours = rnd.nextBool();
  }
  
  // resetColours
  if (resetColoursLOCK == false) {
    resetColours = rnd.nextBool();
  }
  
  // paletteType 0 to 3
  if (paletteTypeLOCK == false) {
    paletteType = rnd.nextInt(4);
  }

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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Flexible(
              flex: 1,
              child: FloatingActionButton.extended(
                label: Text('Randomise Palette'),
                icon: Icon(Icons.palette),
                //backgroundColor: Colors.pink,

                onPressed:() {
                  setState(() {

                    print('Randomise Palette');
                    palette = randomisePalette(numberOfColours, paletteType);

                  });
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 1,
              child: FloatingActionButton.extended(
                label: Text('Randomise All'),

                icon: Icon(Icons.refresh),

                onPressed:() {
                  setState(() {

                    print('Randomise All');
                    randomiseSettings();
                    palette = randomisePalette(numberOfColours, paletteType);

                  });
                },
              ),
            ),

          ],
        ),


        // cellsX
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
            flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (cellsXLOCK){
                          cellsXLOCK=false;
                        } else {
                          cellsXLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'cellsX:',
                          style: cellsXLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          cellsXLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: cellsXLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: cellsX.toDouble(),
                min: 1,
                max: 12,
                onChanged: cellsXLOCK ? null : (value) {
                  setState(() {
                    cellsX  = value.toInt();
                  });
                },
                label: '$cellsX ',
              ),
            ),
          ],
        ),

        // cellsY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (cellsYLOCK){
                          cellsYLOCK=false;
                        } else {
                          cellsYLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'cellsY:',
                          style: cellsYLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          cellsYLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: cellsYLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: cellsY.toDouble(),
                min: 1,
                max: 12,
                onChanged: cellsYLOCK ? null : (value) {
                  setState(() {
                    cellsY  = value.toInt();
                  });
                },
                label: '$cellsY ',
              ),
            ),
          ],
        ),


    // shape
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (shapeLOCK){
                          shapeLOCK=false;
                        } else {
                          shapeLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'shape:',
                          style: shapeLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          shapeLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: shapeLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: DropdownButton(
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
                onChanged: shapeLOCK ? null : (value) {
                  setState(() {
                    shape = value;
                  });
                },
              ),
            ),
          ],
        ),

        // driftX
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (driftXLOCK){
                          driftXLOCK=false;
                        } else {
                          driftXLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'driftX:',
                          style: driftXLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          driftXLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: driftXLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: driftX,
                min: -20,
                max: 20,
                onChanged: driftXLOCK ? null : (value) {
                  setState(() {
                    driftX  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // driftXStep
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (driftXStepLOCK){
                          driftXStepLOCK=false;
                        } else {
                          driftXStepLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'driftXStep:',
                          style: driftXStepLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          driftXStepLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: driftXStepLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: driftXStep,
                min: -2,
                max: 2,
                onChanged: driftXStepLOCK ? null : (value) {
                  setState(() {
                    driftXStep  = value;
                  });
                },
              ),
            ),
          ],
        ),


        // driftY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (driftYLOCK){
                          driftYLOCK=false;
                        } else {
                          driftYLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'driftY:',
                          style: driftYLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          driftYLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: driftYLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: driftY,
                min: -20,
                max: 20,
                onChanged: driftYLOCK ? null : (value) {
                  setState(() {
                    driftY  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // driftYStep
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (driftYStepLOCK){
                          driftYStepLOCK=false;
                        } else {
                          driftYStepLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'driftYStep:',
                          style: driftYStepLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          driftYStepLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: driftYStepLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: driftYStep,
                min: -2,
                max: 2,
                onChanged: driftYStepLOCK ? null : (value) {
                  setState(() {
                    driftYStep  = value;
                  });
                },
              ),
            ),
          ],
        ),


        // alternateDrift
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (alternateDriftLOCK){
                          alternateDriftLOCK=false;
                        } else {
                          alternateDriftLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'alternateDrift:',
                          style: alternateDriftLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          alternateDriftLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: alternateDriftLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Switch(
                value: alternateDrift,
                onChanged: alternateDriftLOCK ? null : (value) {
                  setState(() {
                    alternateDrift  = value;
                  });
                },
              ),
            ),

          ],
        ),


    // box
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (boxLOCK){
                          boxLOCK=false;
                        } else {
                          boxLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'box:',
                          style: boxLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          boxLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: boxLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Switch(
                value: box,
                onChanged: boxLOCK ? null : (value) {
                  setState(() {
                    box  = value;
                  });
                },
              ),
            ),

          ],
        ),

        // step
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (stepLOCK){
                          stepLOCK=false;
                        } else {
                          stepLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'step:',
                          style: stepLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          stepLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: stepLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex:2,
              child: Slider(
                value: step,
                min: 0.01,
                max: 1,
                onChanged: stepLOCK ? null : (value) {
                  setState(() {
                    step  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // stepStep
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (stepStepLOCK){
                          stepStepLOCK=false;
                        } else {
                          stepStepLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'stepStep:',
                          style: stepStepLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          stepStepLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: stepStepLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: stepStep,
                min: 0.5,
                max: 1,
                onChanged: stepStepLOCK ? null : (value) {
                  setState(() {
                    stepStep  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // ratio
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (ratioLOCK){
                          ratioLOCK=false;
                        } else {
                          ratioLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'ratio:',
                          style: ratioLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          ratioLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: ratioLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: ratio,
                min: 0,
                max: 2,
                onChanged: ratioLOCK ? null : (value) {
                  setState(() {
                    ratio  = value;
                  });
                },
              ),
            ),
          ],
        ),


        // offsetX
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (offsetXLOCK){
                          offsetXLOCK=false;
                        } else {
                          offsetXLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'offsetX:',
                          style: offsetXLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          offsetXLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: offsetXLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: offsetX,
                min: -50,
                max: 50,
                onChanged: offsetXLOCK ? null : (value) {
                  setState(() {
                    offsetX  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // offsetY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (offsetYLOCK){
                          offsetYLOCK=false;
                        } else {
                          offsetYLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'offsetY:',
                          style: offsetYLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          offsetYLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: offsetYLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: offsetY,
                min: -50,
                max: 50,
                onChanged: offsetYLOCK ? null : (value) {
                  setState(() {
                    offsetY  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // rotate
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (rotateLOCK){
                          rotateLOCK=false;
                        } else {
                          rotateLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'rotate:',
                          style: rotateLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          rotateLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: rotateLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex:2,
              child: Slider(
                value: rotate,
                min: 0,
                max: 2,
                onChanged: rotateLOCK ? null : (value) {
                  setState(() {
                    rotate  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // rotateStep
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (rotateStepLOCK){
                          rotateStepLOCK=false;
                        } else {
                          rotateStepLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'rotateStep:',
                          style: rotateStepLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          rotateStepLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: rotateStepLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex:2,
              child: Slider(
                value: rotateStep,
                min: 0,
                max: 1,
                onChanged: rotateStepLOCK ? null : (value) {
                  setState(() {
                    rotateStep  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // randomRotation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (randomRotationLOCK){
                          randomRotationLOCK=false;
                        } else {
                          randomRotationLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'randomRotation:',
                          style: randomRotationLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          randomRotationLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: randomRotationLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex:2,
              child: Switch(
                value: randomRotation,
                onChanged: randomRotationLOCK ? null : (value) {
                  setState(() {
                    randomRotation  = value;
                  });
                },
              ),
            ),

          ],
        ),

        // squareness
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (squarenessLOCK){
                          squarenessLOCK=false;
                        } else {
                          squarenessLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'squareness:',
                          style: squarenessLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          squarenessLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: squarenessLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex:2,
              child: Slider(
                value: squareness,
                min: -2,
                max: 2,
                onChanged: squarenessLOCK ? null : (value) {
                  setState(() {
                    squareness  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // squeezeX
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (squeezeXLOCK){
                          squeezeXLOCK=false;
                        } else {
                          squeezeXLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'squeezeX:',
                          style: squeezeXLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          squeezeXLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: squeezeXLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex:2,
              child: Slider(
                value: squeezeX,
                min: 0.1,
                max: 2,
                onChanged: squeezeXLOCK ? null : (value) {
                  setState(() {
                    squeezeX  = value;
                  });
                },
              ),
            ),
          ],
        ),

        // squeezeY
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (squeezeYLOCK){
                          squeezeYLOCK=false;
                        } else {
                          squeezeYLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'squeezeY:',
                          style: squeezeYLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          squeezeYLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: squeezeYLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex:2,
              child: Slider(
                value: squeezeY,
                min: 0.1,
                max: 2,
                onChanged: squeezeYLOCK ? null : (value) {
                  setState(() {
                    squeezeY  = value;
                  });
                },
              ),
            ),
          ],
        ),
    
    // numberOfPetals = rnd.nextInt(15);
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (numberOfPetalsLOCK){
                          numberOfPetalsLOCK=false;
                        } else {
                          numberOfPetalsLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'numberOfPetals:',
                          style: numberOfPetalsLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          numberOfPetalsLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: numberOfPetalsLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex:2,
              child: Slider(
                value: numberOfPetals.toDouble(),
                min: 1,
                max: 15,
                onChanged: numberOfPetalsLOCK ? null : (value) {
                  setState(() {
                    numberOfPetals  = value.toInt();
                  });
                },
                label: '$numberOfPetals',
              ),
            ),
          ],
        ),

    // randomPetals = rnd.nextBool();
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (randomPetalsLOCK){
                          randomPetalsLOCK=false;
                        } else {
                          randomPetalsLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'randomPetals:',
                          style: randomPetalsLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          randomPetalsLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: randomPetalsLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex:2,
              child: Switch(
                value: randomPetals,
                onChanged: randomPetalsLOCK ? null : (value) {
                  setState(() {
                    randomPetals  = value;
                  });
                },
              ),
            ),

          ],
        ),


    // numberOfColours
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex:1,
              child: GestureDetector(
                  onLongPress: (){
                    setState(() {
                      // toggle lock
                      if (numberOfColoursLOCK){
                        numberOfColoursLOCK=false;
                      } else {
                        numberOfColoursLOCK=true;
                      }
                    });
                  },
                  child: Row(
                    children:[
                      Text(
                        '# colours:',
                        style: numberOfColoursLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        numberOfColoursLOCK ? Icons.lock : Icons.lock_open,
                        size: 20,
                        color: numberOfColoursLOCK ? Colors.grey : Colors.black,
                      ),
                    ],
                  )
              ),
            ),
            Flexible(
              flex:2,
              child: Slider(
                value: numberOfColours.toDouble(),
                min: 2,
                max: 36,
                onChanged: numberOfColoursLOCK ? null : (value) {
                  setState(() {
                    if (numberOfColours<value){
                      palette = randomisePalette(value.toInt(), paletteType);
                    }
                    numberOfColours  = value.toInt();
                  });
                },
              ),
            ),
          ],
        ),

        // opacity
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
              child: GestureDetector(
                  onLongPress: (){
                    setState(() {
                      // toggle lock
                      if (opacityLOCK){
                        opacityLOCK=false;
                      } else {
                        opacityLOCK=true;
                      }
                    });
                  },
                  child: Row(
                    children:[
                      Text(
                        '# colours:',
                        style: opacityLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        opacityLOCK ? Icons.lock : Icons.lock_open,
                        size: 20,
                        color: opacityLOCK ? Colors.grey : Colors.black,
                      ),
                    ],
                  )
              ),
            ),
            Flexible(
              flex:2,
              child: Slider(
                value: opacity,
                min: 0,
                max: 1,
                onChanged: opacityLOCK ? null : (value) {
                  setState(() {
                    opacity  = value;
                  });
                },
              ),
            ),
          ],
        ),


        // randomColours
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex:1,
              child: GestureDetector(
                  onLongPress: (){
                    setState(() {
                      // toggle lock
                      if (randomColoursLOCK){
                        randomColoursLOCK=false;
                        print('randomColours UNLOCK');
                      } else {
                        randomColoursLOCK=true;
                        print('randomColours LOCK');
                      }
                    });
                  },
                  child: Row(
                    children:[
                      Text(
                        'randomColours:',
                        style: randomColoursLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        randomColoursLOCK ? Icons.lock : Icons.lock_open,
                        size: 20,
                        color: randomColoursLOCK ? Colors.grey : Colors.black,
                      ),
                    ],
                  )
              ),
            ),
            Flexible(
              flex:2,
              child: Switch(
                value: randomColours,
                onChanged: randomColoursLOCK ? null : (value) {
                  setState(() {
                    randomColours  = value;
                  });
                },
              ),
            ),

          ],
        ),

        // resetColours
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex:1,
                child: Text('resetColours')),
            Flexible(
              flex:2,
              child: Switch(
                value: resetColours,
                onChanged: (value) {
                  setState(() {
                    resetColours  = value;
                  });
                },
              ),
            ),

          ],
        ),


        // paletteType
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex:1,
              child: GestureDetector(
                  onLongPress: (){
                    setState(() {
                      // toggle lock
                      if (paletteTypeLOCK){
                        paletteTypeLOCK=false;
                        print('paletteType UNLOCK');
                      } else {
                        paletteTypeLOCK=true;
                        print('paletteType LOCK');
                      }
                    });
                  },
                  child: Row(
                    children:[
                      Text(
                        'paletteType:',
                        style: paletteTypeLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        paletteTypeLOCK ? Icons.lock : Icons.lock_open,
                        size: 20,
                        color: paletteTypeLOCK ? Colors.grey : Colors.black,
                      ),
                    ],
                  )
              ),
            ),
            Flexible(
              flex:2,
              child: DropdownButton(
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
                onChanged: paletteTypeLOCK ? null : (value) {
                  setState(() {
                    paletteType = value;
                    palette = randomisePalette(numberOfColours, value);
                  });
                },
              ),
            ),

          ],
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
                Flexible(flex: 2, child: bodyWidget()),
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
    // int numberOfPetals = rnd.nextInt(15);
    // bool randomPetals = rnd.nextBool();
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

          canvas.drawPath(path, Paint() ..style = PaintingStyle.fill ..color = nextColour.withOpacity(opacity));

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

              canvas.drawCircle(Offset(PO[0], PO[1]), stepRadius, Paint() ..style = PaintingStyle.fill ..color = nextColour.withOpacity(opacity));
              canvas.drawCircle(Offset(PO[0], PO[1]), stepRadius, Paint() ..style = PaintingStyle.stroke ..strokeWidth = lineWidth ..color = lineColor.withOpacity(opacity));

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
                    ..color = lineColor.withOpacity(opacity));
              canvas.drawPath(
                  squaricle,
                  Paint()
                    ..style = PaintingStyle.fill
                    ..color = nextColour.withOpacity(opacity));

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
                      ..color = lineColor.withOpacity(opacity));
                canvas.drawPath(
                    star,
                    Paint()
                      ..style = PaintingStyle.fill
                      ..color = nextColour.withOpacity(opacity));

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


        } while (k<40 && stepRadius > 0 && step > 0);

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