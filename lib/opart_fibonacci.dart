import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'package:screenshot/screenshot.dart';

Random rnd;
List palette;

// Settings
double aspectRatio = pi/2;
bool aspectRatioLOCK = false;

// image settings
double angleIncrement = 1.6181;
bool angleIncrementLOCK = false;

double flowerFill = 1;
bool flowerFillLOCK = false;

double petalToRadius = 0.03;
bool petalToRadiusLOCK = false;

double ratio = 0.999;
bool ratioLOCK = false;

double randomiseAngle = 0;
bool randomiseAngleLOCK = false;

double petalPointiness = 1;
bool petalPointinessLOCK = false;

double petalRotation = 0;
bool petalRotationLOCK = false;

double petalRotationRatio = 1;
bool petalRotationRatioLOCK = false;

int petalType = 0;
bool petalTypeLOCK = false;

int maxPetals = 5000;
bool maxPetalsLOCK = true;

double radialOscAmplitude = 0;
bool radialOscAmplitudeLOCK = false;

double radialOscPeriod = 1;
bool radialOscPeriodLOCK = false;

bool direction = true;
bool directionLOCK = false;


// palette settings
Color backgroundColour = Colors.grey;

Color lineColour = Colors.grey;
double lineWidth = 0;

bool randomColours = false;
bool randomColoursLOCK = false;

int numberOfColours = 12;
bool numberOfColoursLOCK = false;

int paletteType = 2;
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

  // aspectRatioLOCK 0.5 to 1.5 - or pi/2 to set to the aspect ratio of the device
  if (aspectRatioLOCK == false) {
    aspectRatio = rnd.nextDouble() + 0.5;
    if (rnd.nextBool()){
      aspectRatio=pi/2;
    }
  }

  // angleIncrement 0 - pi
  if (angleIncrementLOCK == false) {
    angleIncrement = rnd.nextDouble()*pi;
  }

  // flowerFill 0.01 - 1
  if (flowerFillLOCK == false) {
    flowerFill = rnd.nextDouble() * 0.5 + 0.5;
  }

  // petalToRadius - 0 01 to 0.1
  if (petalToRadiusLOCK == false) {
    petalToRadius = rnd.nextDouble() * 0.09 + 0.01;
  }

  // ratio 0.99 - 1
  if (ratioLOCK == false) {
    ratio = rnd.nextDouble() * 0.01+0.99;
  }

  // randomiseAngle 0 to 0.2
  if (randomiseAngleLOCK == false){
    randomiseAngle = 0;
    if (rnd.nextDouble() > 0.8) {
      randomiseAngle = rnd.nextDouble() * 0.2;
    }
  }

  // petalPointiness: 0 to pi
  if (petalPointinessLOCK == false) {
    petalPointiness = rnd.nextDouble() * pi;
  }

  // petalRotation: 0 to pi
  if (petalRotationLOCK == false) {
    petalRotation = rnd.nextDouble() * pi;
  }

  // petalRotationRatio 0 to 4
  if (petalRotationRatioLOCK == false) {
    petalRotationRatio = rnd.nextDouble() * 4;
    if (rnd.nextDouble() > 0.3) {
      petalRotationRatio = rnd.nextInt(4).toDouble();
    }
  }

  // petalType = 0/1  circle/square
  if (petalTypeLOCK == false) {
    petalType = rnd.nextInt(1);
  }


  // maxPetals = 1000 to 10000;
  if (maxPetalsLOCK == false) {
    petalType = rnd.nextInt(9000)+1000;
  }


  // radialOscAmplitude 0 to 5
  if (radialOscAmplitudeLOCK == false) {
    radialOscAmplitude = 0;
    if (rnd.nextDouble()>0.7){
      radialOscAmplitude = rnd.nextDouble() * 5;
    }
  }


  // radialOscPeriod 0 to 2
  if (radialOscPeriodLOCK == false) {
    radialOscPeriod = rnd.nextDouble() * 2;
  }



  // numberOfColours 2 to 36
  if (numberOfColoursLOCK == false) {
    numberOfColours = rnd.nextInt(34) + 2;
  }

  // randomColours
  if (randomColoursLOCK == false) {
    randomColours = rnd.nextBool();
  }

  // paletteType 0 to 3
  if (paletteTypeLOCK == false) {
    paletteType = rnd.nextInt(4);
  }
}




class OpArtFibonacciStudio extends StatefulWidget {

  int seed;
  bool showSettings;
  ScreenshotController screenshotController;

  OpArtFibonacciStudio(this.seed, this.showSettings, {this.screenshotController});

  @override
  _OpArtFibonacciStudioState createState() => _OpArtFibonacciStudioState();
}

class _OpArtFibonacciStudioState extends State<OpArtFibonacciStudio> {
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
                //backgroundColour: Colors.pink,

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

        // aspectRatio
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (aspectRatioLOCK){
                          aspectRatioLOCK=false;
                        } else {
                          aspectRatioLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'aspectRatio:',
                          style: aspectRatioLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          aspectRatioLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: aspectRatioLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: aspectRatio,
                min: 0.5,
                max: 2,
                onChanged: aspectRatioLOCK ? null : (value) {
                  setState(() {
                    aspectRatio  = value;
                  });
                },
                label: '$aspectRatio ',
              ),
            ),
          ],
        ),


        // angleIncrement
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (angleIncrementLOCK){
                          angleIncrementLOCK=false;
                        } else {
                          angleIncrementLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'angleIncrement:',
                          style: angleIncrementLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          angleIncrementLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: angleIncrementLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: angleIncrement,
                min: 0,
                max: 2*pi,
                onChanged: angleIncrementLOCK ? null : (value) {
                  setState(() {
                    angleIncrement  = value;
                  });
                },
                label: '$angleIncrement ',
              ),
            ),
          ],
        ),

        // flowerFill
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (flowerFillLOCK){
                          flowerFillLOCK=false;
                        } else {
                          flowerFillLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'flowerFill:',
                          style: flowerFillLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          flowerFillLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: flowerFillLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: flowerFill,
                min: 0.1,
                max: 2,
                onChanged: flowerFillLOCK ? null : (value) {
                  setState(() {
                    flowerFill  = value;
                  });
                },
                label: '$flowerFill ',
              ),
            ),
          ],
        ),

        // petalToRadius
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (petalToRadiusLOCK){
                          petalToRadiusLOCK=false;
                        } else {
                          petalToRadiusLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'petalToRadius:',
                          style: petalToRadiusLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          petalToRadiusLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: petalToRadiusLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: petalToRadius,
                min: 0.001,
                max: 0.5,
                onChanged: petalToRadiusLOCK ? null : (value) {
                  setState(() {
                    petalToRadius  = value;
                  });
                },
                label: '$petalToRadius ',
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
                min: 0.99,
                max: 0.9999,
                onChanged: ratioLOCK ? null : (value) {
                  setState(() {
                    ratio  = value;
                  });
                },
                label: '$ratio ',
              ),
            ),
          ],
        ),

        // randomiseAngle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (randomiseAngleLOCK){
                          randomiseAngleLOCK=false;
                        } else {
                          randomiseAngleLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'randomiseAngle:',
                          style: randomiseAngleLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          randomiseAngleLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: randomiseAngleLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: randomiseAngle,
                min: 0,
                max: 0.2,
                onChanged: randomiseAngleLOCK ? null : (value) {
                  setState(() {
                    randomiseAngle  = value;
                  });
                },
                label: '$randomiseAngle ',
              ),
            ),
          ],
        ),

        // petalPointiness
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (petalPointinessLOCK){
                          petalPointinessLOCK=false;
                        } else {
                          petalPointinessLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'petalPointiness:',
                          style: petalPointinessLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          petalPointinessLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: petalPointinessLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: petalPointiness,
                min: 0,
                max: pi,
                onChanged: petalPointinessLOCK ? null : (value) {
                  setState(() {
                    petalPointiness  = value;
                  });
                },
                label: '$petalPointiness ',
              ),
            ),
          ],
        ),


        // petalRotation 0 to pi
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (petalRotationLOCK){
                          petalRotationLOCK=false;
                        } else {
                          petalRotationLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'petalRotation:',
                          style: petalRotationLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          petalRotationLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: petalRotationLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: petalRotation,
                min: 0,
                max: pi,
                onChanged: petalRotationLOCK ? null : (value) {
                  setState(() {
                    petalRotation  = value;
                  });
                },
                label: '$petalRotation ',
              ),
            ),
          ],
        ),



      // petalRotationRatio 0 to 4
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (petalRotationRatioLOCK){
                          petalRotationRatioLOCK=false;
                        } else {
                          petalRotationRatioLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'rotationRatio:',
                          style: petalRotationRatioLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          petalRotationRatioLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: petalRotationRatioLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: petalRotationRatio,
                min: 0,
                max: 4,
                onChanged: petalRotationRatioLOCK ? null : (value) {
                  setState(() {
                    petalRotationRatio  = value;
                  });
                },
                label: '$petalRotationRatio ',
              ),
            ),
          ],
        ),

        // petalType
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex:1,
              child: GestureDetector(
                  onLongPress: (){
                    setState(() {
                      // toggle lock
                      if (petalTypeLOCK){
                        petalTypeLOCK=false;
                        print('petalType UNLOCK');
                      } else {
                        petalTypeLOCK=true;
                        print('petalType LOCK');
                      }
                    });
                  },
                  child: Row(
                    children:[
                      Text(
                        'petalType:',
                        style: petalTypeLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        petalTypeLOCK ? Icons.lock : Icons.lock_open,
                        size: 20,
                        color: petalTypeLOCK ? Colors.grey : Colors.black,
                      ),
                    ],
                  )
              ),
            ),
            Flexible(
              flex:2,
              child: DropdownButton(
                value: petalType,
                items: [
                  DropdownMenuItem(
                    child: Text("circle"),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text("triangle"),
                    value: 1,
                  ),
                ],
                onChanged: petalTypeLOCK ? null : (value) {
                  setState(() {
                    petalType = value;
                  });
                },
              ),
            ),

          ],
        ),


// maxPetals 1000 to 10000
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (maxPetalsLOCK){
                          maxPetalsLOCK=false;
                        } else {
                          maxPetalsLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'maxPetals:',
                          style: maxPetalsLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          maxPetalsLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: maxPetalsLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: maxPetals.toDouble(),
                min: 1,
                max: 10000,
                onChanged: maxPetalsLOCK ? null : (value) {
                  setState(() {
                    maxPetals  = value.toInt();
                  });
                },
                label: '$maxPetals ',
              ),
            ),
          ],
        ),

        // radialOscAmplitude
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (radialOscAmplitudeLOCK){
                          radialOscAmplitudeLOCK=false;
                        } else {
                          radialOscAmplitudeLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'radialOscAmp:',
                          style: radialOscAmplitudeLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          radialOscAmplitudeLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: radialOscAmplitudeLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: radialOscAmplitude,
                min: 0,
                max: 5,
                onChanged: radialOscAmplitudeLOCK ? null : (value) {
                  setState(() {
                    radialOscAmplitude  = value;
                  });
                },
                label: '$radialOscAmplitude ',
              ),
            ),
          ],
        ),

// radialOscPeriod
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (radialOscPeriodLOCK){
                          radialOscPeriodLOCK=false;
                        } else {
                          radialOscPeriodLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'radialOscAmp:',
                          style: radialOscPeriodLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          radialOscPeriodLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: radialOscPeriodLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: radialOscPeriod,
                min: 0,
                max: 2,
                onChanged: radialOscPeriodLOCK ? null : (value) {
                  setState(() {
                    radialOscPeriod  = value;
                  });
                },
                label: '$radialOscPeriod ',
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
                child: CustomPaint(painter: OpArtFibonacciPainter(widget.seed, rnd)),
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
                  child: CustomPaint(painter: OpArtFibonacciPainter(widget.seed, rnd)),
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

class OpArtFibonacciPainter extends CustomPainter {
  int seed;
  Random rnd;

  OpArtFibonacciPainter( this.seed, this.rnd);

  @override
  void paint(Canvas canvas, Size size) {

    print('----------------------------------------------------------------');
    print('Fibonacci');
    print('----------------------------------------------------------------');

    rnd = Random(seed);
    print('seed: $seed');

    double canvasWidth = size.width;
    double canvasHeight = size.height;
    print('canvasWidth: $canvasWidth');
    print('canvasHeight: $canvasHeight');
    print('canvasWidth / canvasHeight = ${canvasWidth / canvasHeight}');

    double borderX = 0;
    double borderY = 0;
    double imageWidth = canvasWidth;
    double imageHeight = canvasHeight;

    if (aspectRatio == pi/2){
      aspectRatio = canvasWidth/canvasHeight;
    }

    if (canvasWidth / canvasHeight < aspectRatio) {
      borderY = (canvasHeight - canvasWidth / aspectRatio) / 2;
      imageHeight = imageWidth /aspectRatio;
    }
    else {
      borderX = (canvasWidth - canvasHeight * aspectRatio) / 2;
      imageWidth = imageHeight * aspectRatio;
    }

    double flowerCentreX = imageWidth / 2;
    double flowerCentreY = imageHeight / 2;

    print('aspectRatio = $aspectRatio');
    print('imageWidth = $imageWidth');
    print('imageHeight = $imageHeight');
    print('borderX = $borderX');
    print('borderY = $borderY');
    print('flowerCentreX: $flowerCentreX');
    print('flowerCentreY: $flowerCentreY');

    print('numberOfColours: $numberOfColours');
    print('opacity: $opacity');
    print('paletteType: $paletteType');

    // set the initial palette
    if (palette == null) {
      print('randomisePalette: $numberOfColours, $paletteType');
      palette = randomisePalette(numberOfColours, paletteType);
    }

    print('randomColours: $randomColours');


    int colourOrder = 0;
    Color backgroundColour = Colors.grey[200];


    // Now make some art


    // colour in the canvas
    //a rectangle
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight*2), Paint()
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
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(0, 0) & Size(borderX, canvasHeight), paint1);
    canvas.drawRect(Offset(canvasWidth-borderX, 0) & Size(borderX, canvasHeight), paint1);

    canvas.drawRect(Offset(0, 0) & Size(canvasWidth, borderY ), paint1);
    canvas.drawRect(Offset(0, canvasHeight-borderY, ) & Size(canvasWidth, borderY+canvasHeight*2), paint1);




  }


  generateFlower(
      Canvas canvas,
      double width,
      double height,
      double borderX,
      double borderY,
      flowerCentreX,
      flowerCentreY) {

    int maxPetalCount = maxPetals;

    // start the colour order
    int colourOrder=0;
    Color nextColour;

    // clear the canvas
    //ctx.clearRect(0, 0, canvas.width, canvas.height);
    //canvas.clearRect(0, 0, canvas.width, canvas.height);


    List P0 = [flowerCentreX + borderX, flowerCentreY + borderY];

    double maxRadius = (width<height) ? flowerFill * width / 2 : flowerFill * height / 2;
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
        drawPetal(canvas, P0, angle, radius, nextColour, null, petalToRadius, petalType, petalPointiness, petalRotation, petalRotationRatio, lineWidth, lineColour, randomiseAngle, radialOscAmplitude, radialOscPeriod);

        angle = angle + angleIncrement;
        if (angle > 2 * pi) {
          angle = angle - 2 * pi;
        }

        radius = radius * ratio;

        maxPetalCount = maxPetalCount - 1;
      }
      while (radius > minRadius && radius < maxRadius && maxPetalCount > 0);
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

        drawPetal(canvas, P0, angle, radius, nextColour, null, petalToRadius, petalType, petalPointiness, petalRotation, petalRotationRatio, lineWidth, lineColour, randomiseAngle, radialOscAmplitude, radialOscPeriod);

        angle = angle + angleIncrement;
        if (angle > 2 * pi) {
          angle = angle - 2 * pi;
        }

        radius = radius / ratio;

        maxPetalCount = maxPetalCount - 1;
      }
      while (radius > minRadius && radius < maxRadius && maxPetalCount > 0);

    }



  }


  drawPetal(canvas, P0, angle, radius, colour, colourGradient, petalToRadius, petalType, petalPointiness, petalRotation, petalRotationRatio, lineWidth, lineColour, randomiseAngle, radialOscAmplitude, radialOscPeriod) {

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

  @override
  bool shouldRepaint(OpArtFibonacciPainter oldDelegate) => false;
}
