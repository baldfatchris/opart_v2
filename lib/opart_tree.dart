import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:screenshot/screenshot.dart';

Random rnd;
List palette;


// Settings
double aspectRatio = pi/2;
bool aspectRatioLOCK = false;

double trunkWidth = 10;
bool trunkWidthLOCK = false;

double widthDecay = 0.92;
bool widthDecayLOCK = false;

double segmentLength= 35;
bool segmentLengthLOCK = false;

double segmentDecay = 0.92;
bool segmentDecayLOCK = false;

double branch = 0.7;
bool branchLOCK = false;

double angle = 0.5;
bool angleLOCK = false;

double ratio = 0.7;
bool ratioLOCK = false;

double bulbousness = 1.5;
bool bulbousnessLOCK = false;

int maxDepth = 20;
bool maxDepthLOCK = false;

int leavesAfter = 5;
bool leavesAfterLOCK = false;

double leafAngle = 0.5;
bool leafAngleLOCK = false;

double leafLength = 8;
bool leafLengthLOCK = false;

double randomLeafLength = 3.0;
bool randomLeafLengthLOCK = false;

double leafSquareness = 1;
bool leafSquarenessLOCK = false;

double leafDecay = 0.95;
bool leafDecayLOCK = false;

// palette settings
Color backgroundColor = Colors.grey;
bool backgroundColorLOCK = false;

Color trunkFillColor = Colors.grey;
bool trunkFillColorLOCK = false;

Color trunkOutlineColour = Colors.black;
bool trunkOutlineColourLOCK = false;

double trunkStrokeWidth = 0.1;
bool trunkStrokeWidthLOCK = false;


bool randomColours = false;
bool randomColoursLOCK = false;

int numberOfColours = 12;
bool numberOfColoursLOCK = false;

int paletteType = 2;
bool paletteTypeLOCK = false;

double opacity = 0.5;
bool opacityLOCK = false;

randomisePalette(int numberOfColours, int paletteType){
  print('Randomise Palette');
  print('numberOfColours: $numberOfColours paletteType: $paletteType');
  print('opacity: $opacity');

  rnd = Random(DateTime.now().millisecond);

  // backgroundColor
  if (backgroundColorLOCK == false) {
    backgroundColor = Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
  }
  print('backgroundColor $backgroundColor');

  // trunkFillColor
  if (trunkFillColorLOCK == false) {
    trunkFillColor = Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity);
  }
  print('trunkFillColor $trunkFillColor');

  // trunkOutlineColour
  if (trunkOutlineColourLOCK == false) {
    trunkOutlineColour = Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity);
  }
  print('trunkOutlineColour $trunkOutlineColour');

  List palette = [];

  switch(paletteType){

  // blended random
    case 1:{
      print('blended random');
      double blendColour = rnd.nextDouble() * 0xFFFFFF;
      for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++){
        palette.add(Color(((blendColour + rnd.nextDouble() * 0xFFFFFF)/2).toInt()).withOpacity(opacity));
      }
    }
    break;

  // linear random
    case 2:{
      print('linear random');
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
      print('linear complementary');
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
      print('random');
      for (int colorIndex = 0; colorIndex < numberOfColours; colorIndex++){
        palette.add(Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity));
      }
    }
    break;

  }

  print('palette: $palette');

  return palette;
}

randomiseSettings() {

  print('RANDOMISE SETTINGS');

  // trunkWidth 0 to 50
  if (trunkWidthLOCK == false) {
    trunkWidth = rnd.nextDouble() * 50;
  }

  // widthDecay 0.7-1
  if (widthDecayLOCK == false) {
    widthDecay = rnd.nextDouble() * 0.3 + 0.7;
  }

  // segmentLength 10 to 50
  if (segmentLengthLOCK == false) {
    segmentLength = rnd.nextDouble() * 40 + 10;
  }

  // segmentDecay 0.7 - 1
  if (segmentDecayLOCK == false) {
    segmentDecay = rnd.nextDouble() * 0.3 + 0.7;
  }

  // branch 0.4 - 1
  if (branchLOCK == false) {
    branch = rnd.nextDouble() * 0.6 + 0.4;
  }

  // angle 0.1 - 0.7
  if (angleLOCK == false) {
    angle = rnd.nextDouble() * 0.6 + 0.1;
  }

  // ratio 0.5 - 1.5
  if (ratioLOCK == false) {
    ratio = rnd.nextDouble() + 0.5;
  }

  // bulbousness 0-2
  if (bulbousnessLOCK == false) {
    bulbousness = rnd.nextDouble() * 2;
  }

  // maxDepth 10 - 28
  if (maxDepthLOCK == false) {
    maxDepth = rnd.nextInt(18) +10;
  }

  // leavesAfter 0 to maxDepth
  if (leavesAfterLOCK == false) {
    leavesAfter = rnd.nextInt(maxDepth);
  }

  // leafAngle 0.2 - 0.8
  if (leafAngleLOCK == false) {
    leafAngle = rnd.nextDouble() * 0.6 + 0.2;
  }

  // leafLength 0 to 20
  if (leafLengthLOCK == false) {
    leafLength = rnd.nextDouble() * 20;
  }

  // randomLeafLength 0 to 20
  if (randomLeafLengthLOCK == false) {
    randomLeafLength = rnd.nextDouble() * 20;
  }

  // leafSquareness 0 -3
  if (leafSquarenessLOCK == false) {
    leafSquareness = rnd.nextDouble() * 2;
  }

  // leafDecay 0.9 - 1
  if (leafDecayLOCK == false) {
    leafDecay = rnd.nextDouble() * 0.1+0.9;
  }



  // opacity 0.5-1
  if (opacityLOCK == false) {
    if (rnd.nextBool()) {
      opacity = rnd.nextDouble() * 0.5 + 0.5;
    } else {
      opacity = 1;
    }
  }


  // numberOfColours 1 to 36
  if (numberOfColoursLOCK == false) {
    numberOfColours = rnd.nextInt(35) + 1;
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

class TreeSettings {

  int id;
  List palette;
  Color backgroundColor;
  Color trunkFillColor;
  Color trunkOutlineColour;
  double opacity = 1;
  double trunkWidth = 10.0;
  double widthDecay = 0.92;
  double segmentLength = 35.0;
  double segmentDecay = 0.92;
  double branch = 0.7;
  double angle = 0.5;
  double ratio = 0.7;
  double bulbousness = 1.5;
  int maxDepth = 20;
  int leavesAfter = 10;
  double leafAngle = 0.5;
  double leafLength = 8;
  double randomLeafLength  = 4;
  double leafSquareness  = 1.5;
  double leafDecay  = 0.95;

  File image = null;
  TreeSettings(
      {
        this.id,
        this.palette,
        this.backgroundColor,
        this.trunkFillColor,
        this.trunkOutlineColour,
        this.opacity,
        this.trunkWidth,
        this.widthDecay,
        this.segmentDecay,
        this.segmentLength,
        this.branch,
        this.angle,
        this.ratio,
        this.bulbousness,
        this.maxDepth,
        this.leavesAfter,
        this.leafAngle,
        this.leafLength,
        this.randomLeafLength ,
        this.leafSquareness ,
        this.leafDecay,
        this.image,
        }
      );
}

List<TreeSettings> treeSettingsList = [
  TreeSettings(
    id: 0,
    palette: [
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
    ],
      backgroundColor: Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity),
    trunkFillColor: Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity),
    trunkOutlineColour: Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity),
      opacity: 0.5,
      trunkWidth: 10.0,
      widthDecay: 0.92,
      segmentLength: 35.0,
      segmentDecay: 0.92,
      branch: 0.7,
      angle: 0.5,
      ratio: 0.7,
      bulbousness: 1.9,
      maxDepth: 18,
      leavesAfter: 10,
      leafAngle: 0.7,
    leafLength: 8,
    randomLeafLength : 18,
    leafSquareness : 1,
    leafDecay : 0.99,

  ),
  TreeSettings(
    id: 0,
    palette: [
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
    ],
    backgroundColor: Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity),
    trunkFillColor: Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity),
    trunkOutlineColour: Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity),
    opacity: 1,
    trunkWidth: 10.0,
    widthDecay: 0.92,
    segmentLength: 35.0,
    segmentDecay: 0.92,
    branch: 0.7,
    angle: 0.5,
    ratio: 0.7,
    bulbousness: 1.6,
    maxDepth: 18,
    leavesAfter: 10,
    leafAngle: 0.7,
    leafLength: 9,
    randomLeafLength : 9,
    leafSquareness : 1,
    leafDecay : 0.96,

  ),

];

int currentIndex = 0;

void changeColor(int index, Color color) {
  palette.replaceRange(index, index + 1, [color]);
}

class OpArtTreeStudio extends StatefulWidget {

  int seed;
  bool showSettings;
  ScreenshotController screenshotController;
  OpArtTreeStudio(this.seed, this.showSettings, {this.screenshotController});

  @override
  _OpArtTreeStudioState createState() => _OpArtTreeStudioState();
}

bool _showBackgroundColorPicker = false;

class _OpArtTreeStudioState extends State<OpArtTreeStudio> {
  int _counter = 0;
  File _imageFile;

  int _currentColor = 0;

  Widget settingsWidget() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          // child: Center(
          //     child: Text(
          //   'Settings',
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // )),
        ),
        Row(
          children: [
              Container(
              width: 300,
              height: 60,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: treeSettingsList.length,
                    itemBuilder: (context, index) {
                      if (treeSettingsList[index].image == null) {
                        return Container();
                      } else {
                        return GestureDetector(onTap: (){
                          setState(() {
                            currentIndex = index;
                            print('index: $index');
                            palette = treeSettingsList[currentIndex].palette;
                            backgroundColor = treeSettingsList[currentIndex].backgroundColor;
                            opacity = treeSettingsList[currentIndex].opacity;
                            trunkFillColor = treeSettingsList[currentIndex].trunkFillColor;
                            trunkOutlineColour = treeSettingsList[currentIndex].trunkOutlineColour;
                            trunkWidth = treeSettingsList[currentIndex].trunkWidth;
                            widthDecay = treeSettingsList[currentIndex].widthDecay;
                            segmentLength = treeSettingsList[currentIndex].segmentLength;
                            segmentDecay = treeSettingsList[currentIndex].segmentDecay;
                            branch = treeSettingsList[currentIndex].branch;
                            angle = treeSettingsList[currentIndex].angle;
                            ratio = treeSettingsList[currentIndex].ratio;
                            bulbousness = treeSettingsList[currentIndex].bulbousness;
                            maxDepth = treeSettingsList[currentIndex].maxDepth;
                            leavesAfter = treeSettingsList[currentIndex].leavesAfter;
                            leafAngle = treeSettingsList[currentIndex].leafAngle;
                            leafLength = treeSettingsList[currentIndex].leafLength;
                            randomLeafLength  = treeSettingsList[currentIndex].randomLeafLength ;
                            leafSquareness  = treeSettingsList[currentIndex].leafSquareness ;
                            leafDecay  = treeSettingsList[currentIndex].leafDecay ;


                          });
                        },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            treeSettingsList[index].image)))),
                          ),
                        );
                      }
                    }),
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                treeSettingsList.add(
                  TreeSettings(
                    id: treeSettingsList.length + 1,
                    palette: palette,
                    backgroundColor: backgroundColor,
                    trunkFillColor: trunkFillColor,
                    trunkOutlineColour: trunkOutlineColour,
                    opacity: opacity,
                    trunkWidth: trunkWidth,
                    widthDecay: widthDecay,
                    segmentLength: segmentLength,
                    segmentDecay: segmentDecay,
                    branch: branch,
                    angle: angle,
                    ratio: ratio,
                    bulbousness: bulbousness,
                    maxDepth: maxDepth,
                    leavesAfter: leavesAfter,
                    leafAngle: leafAngle,
                    leafLength: leafLength,
                    randomLeafLength : randomLeafLength ,
                    leafSquareness : leafSquareness ,
                    leafDecay : leafDecay ,
                  ),
                );
                widget.screenshotController
                    .capture(delay: Duration(milliseconds: 0), pixelRatio: 0.1)
                    .then((File image) async {
                  treeSettingsList[currentIndex].image = image;
                });
                await new Future.delayed(const Duration(seconds : 1)).then((value){
                  setState(() {
                    currentIndex = treeSettingsList.length-1;
                  });
                });


              },
            )
          ],
        ),

        SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            // Randomise Palette
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

            // Randomise All
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


        // backgroundColor
        Row(
          children: [
            Text('Background Color'),
            IconButton(
              icon: Icon(_showBackgroundColorPicker
                  ? Icons.arrow_drop_up
                  : Icons.arrow_drop_down),
              onPressed: () {
                setState(() {
                  _showBackgroundColorPicker = !_showBackgroundColorPicker;
                });
              },
            )
          ],
        ),
        _showBackgroundColorPicker
            ? ColorPicker(
                displayThumbColor: false,
                pickerAreaHeightPercent: 0.3,
                pickerAreaBorderRadius: BorderRadius.circular(10.0),
                pickerColor: backgroundColor,
                onColorChanged: (color) {
                  setState(() {
                    backgroundColor = color;
                  });
                },
                showLabel: false,
              )
            : Container(),


        // trunkWidth
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (trunkWidthLOCK){
                          trunkWidthLOCK=false;
                        } else {
                          trunkWidthLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'trunkWidth:',
                          style: trunkWidthLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          trunkWidthLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: trunkWidthLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: trunkWidth,
                min: 0,
                max: 50,
                onChanged: trunkWidthLOCK ? null : (value) {
                  setState(() {
                    trunkWidth  = value;
                  });
                },
                label: '$trunkWidth ',
              ),
            ),
          ],
        ),

        // widthDecay
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (widthDecayLOCK){
                          widthDecayLOCK=false;
                        } else {
                          widthDecayLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'widthDecay:',
                          style: widthDecayLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          widthDecayLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: widthDecayLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: widthDecay,
                min: 0.7,
                max: 1.1,
                onChanged: widthDecayLOCK ? null : (value) {
                  setState(() {
                    widthDecay  = value;
                  });
                },
                label: '$widthDecay ',
              ),
            ),
          ],
        ),


        // segmentLength
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (segmentLengthLOCK){
                          segmentLengthLOCK=false;
                        } else {
                          segmentLengthLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'segmentLength:',
                          style: segmentLengthLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          segmentLengthLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: segmentLengthLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: segmentLength,
                min: 10,
                max: 50,
                onChanged: segmentLengthLOCK ? null : (value) {
                  setState(() {
                    segmentLength  = value;
                  });
                },
                label: '$segmentLength ',
              ),
            ),
          ],
        ),



        // segmentDecay
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (segmentDecayLOCK){
                          segmentDecayLOCK=false;
                        } else {
                          segmentDecayLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'segmentDecay:',
                          style: segmentDecayLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          segmentDecayLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: segmentDecayLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: segmentDecay,
                min: 0.7,
                max: 1,
                onChanged: segmentDecayLOCK ? null : (value) {
                  setState(() {
                    segmentDecay  = value;
                  });
                },
                label: '$segmentDecay ',
              ),
            ),
          ],
        ),


        // branch
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (branchLOCK){
                          branchLOCK=false;
                        } else {
                          branchLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'branch:',
                          style: branchLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          branchLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: branchLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: branch,
                min: 0.4,
                max: 1,
                onChanged: branchLOCK ? null : (value) {
                  setState(() {
                    branch  = value;
                  });
                },
                label: '$branch ',
              ),
            ),
          ],
        ),




        // angle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (angleLOCK){
                          angleLOCK=false;
                        } else {
                          angleLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'angle:',
                          style: angleLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          angleLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: angleLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: angle,
                min: 0.1,
                max: 0.7,
                onChanged: angleLOCK ? null : (value) {
                  setState(() {
                    angle  = value;
                  });
                },
                label: '$angle ',
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
                min: 0.5,
                max: 1.5,
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


        // bulbousness
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (bulbousnessLOCK){
                          bulbousnessLOCK=false;
                        } else {
                          bulbousnessLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'bulbousness:',
                          style: bulbousnessLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          bulbousnessLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: bulbousnessLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: bulbousness,
                min: 0,
                max: 3,
                onChanged: bulbousnessLOCK ? null : (value) {
                  setState(() {
                    bulbousness  = value;
                  });
                },
                label: '$bulbousness ',
              ),
            ),
          ],
        ),

        // maxDepth
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (maxDepthLOCK){
                          maxDepthLOCK=false;
                        } else {
                          maxDepthLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'maxDepth:',
                          style: maxDepthLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          maxDepthLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: maxDepthLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: maxDepth.toDouble(),
                min: 10,
                max: 28,
                onChanged: maxDepthLOCK ? null : (value) {
                  setState(() {
                    maxDepth  = value.toInt();
                  });
                },
                label: '$maxDepth ',
              ),
            ),
          ],
        ),


        // leavesAfter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (leavesAfterLOCK){
                          leavesAfterLOCK=false;
                        } else {
                          leavesAfterLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'leavesAfter:',
                          style: leavesAfterLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          leavesAfterLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: leavesAfterLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: leavesAfter.toDouble(),
                min: 0,
                max: 28,
                onChanged: leavesAfterLOCK ? null : (value) {
                  setState(() {
                    leavesAfter  = (leavesAfter<maxDepth) ? value.toInt() : maxDepth;
                  });
                },
                label: '$leavesAfter ',
              ),
            ),
          ],
        ),

        // leafAngle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (leafAngleLOCK){
                          leafAngleLOCK=false;
                        } else {
                          leafAngleLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'leafAngle:',
                          style: leafAngleLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          leafAngleLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: leafAngleLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: leafAngle,
                min: 0.2,
                max: 0.8,
                onChanged: leafAngleLOCK ? null : (value) {
                  setState(() {
                    leafAngle  = value;
                  });
                },
                label: '$leafAngle ',
              ),
            ),
          ],
        ),

        // leafLength
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (leafLengthLOCK){
                          leafLengthLOCK=false;
                        } else {
                          leafLengthLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'leafLength:',
                          style: leafLengthLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          leafLengthLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: leafLengthLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: leafLength,
                min: 0,
                max: 20,
                onChanged: leafLengthLOCK ? null : (value) {
                  setState(() {
                    leafLength  = value;
                  });
                },
                label: '$leafLength ',
              ),
            ),
          ],
        ),



        // randomLeafLength
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (randomLeafLengthLOCK){
                          randomLeafLengthLOCK=false;
                        } else {
                          randomLeafLengthLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'randomLength:',
                          style: randomLeafLengthLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          randomLeafLengthLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: randomLeafLengthLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: randomLeafLength,
                min: 0,
                max: 20,
                onChanged: randomLeafLengthLOCK ? null : (value) {
                  setState(() {
                    randomLeafLength  = value;
                  });
                },
                label: '$randomLeafLength ',
              ),
            ),
          ],
        ),



        // leafSquareness
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (leafSquarenessLOCK){
                          leafSquarenessLOCK=false;
                        } else {
                          leafSquarenessLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'leafSquareness:',
                          style: leafSquarenessLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          leafSquarenessLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: leafSquarenessLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: leafSquareness,
                min: 0,
                max: 2,
                onChanged: leafSquarenessLOCK ? null : (value) {
                  setState(() {
                    leafSquareness  = value;
                  });
                },
                label: '$leafSquareness ',
              ),
            ),
          ],
        ),



        // leafDecay
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (leafDecayLOCK){
                          leafDecayLOCK=false;
                        } else {
                          leafDecayLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'leafDecay:',
                          style: leafDecayLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          leafDecayLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: leafDecayLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: leafDecay,
                min: 0.9,
                max: 1,
                onChanged: leafDecayLOCK ? null : (value) {
                  setState(() {
                    leafDecay  = value;
                  });
                },
                label: '$leafDecay ',
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
                        'opacity:',
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
                    opacity  = value;});
                },
              ),
            ),
          ],
        ),




      ],
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
                  color: backgroundColor,
                  width: constraints.widthConstraints().maxWidth,
                  height: constraints.heightConstraints().maxHeight,
                  child: CustomPaint(painter: OpArtTreePainter(widget.seed, rnd)),
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

class OpArtTreePainter extends CustomPainter {
  int seed;
  Random rnd;

  OpArtTreePainter(this.seed, this.rnd);

  @override
  void paint(Canvas canvas, Size size) {

    print('----------------------------------------------------------------');
    print('Tree');
    print('----------------------------------------------------------------');

    rnd = Random(seed);
    print('seed: $seed');

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


    // set the initial palette
    if (palette == null || palette == []) {
      print('randomisePalette: $numberOfColours, $paletteType');
      palette = randomisePalette(numberOfColours, paletteType);
    }

    // colour in the canvas
    var paint1 = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight), paint1);

    double direction = pi / 2;

    double lineWidth = 2;
    // Color trunkFillColor = Colors.grey[800];

    print('palette: $palette');
    print('backgroundColor: $backgroundColor');
    print('trunkFillColor: $trunkFillColor');
    print('trunkOutlineColour: $trunkOutlineColour');
    print('opacity: $opacity');
    print('trunkWidth: $trunkWidth');
    print('widthDecay: $widthDecay');
    print('segmentLength: $segmentLength');
    print('segmentDecay: $segmentDecay');
    print('branch: $branch');
    print('angle: $angle');
    print('ratio: $ratio');
    print('bulbousness: $bulbousness');
    print('maxDepth: $maxDepth');
    print('leavesAfter: $leavesAfter');
    print('leafAngle: $leafAngle');
    print('leafLength: $leafLength');
    print('randomLeafLength: $randomLeafLength');
    print('leafSquareness: $leafSquareness');
    print('leafDecay: $leafDecay');




    String leafStyle = 'quadratic';

    List treeBaseA = [
      (canvasWidth - trunkWidth) / 2,
      canvasHeight
    ];
    List treeBaseB = [
      (canvasWidth + trunkWidth) / 2,
      canvasHeight
    ];

    drawSegment(
        canvas,
        borderX,
        borderY,
        treeBaseA,
        treeBaseB,
        trunkWidth,
        segmentLength,
        direction,
        0,
        lineWidth,
        leafLength,
        leafStyle,
        false);
  }

  drawSegment(
    Canvas canvas,
    double borderX,
    double borderY,
    List rootA,
    List rootB,
    double width,
    double segmentLength,
    double direction,
    int currentDepth,
    double lineWidth,
    double leafLength,
    String leafStyle,
    bool justBranched,
  ) {
    List segmentBaseCentre = [
      (rootA[0] + rootB[0]) / 2,
      (rootA[1] + rootB[1]) / 2
    ];

    //branch

    if (!justBranched && rnd.nextDouble() < branch) {
      List rootX = [
        segmentBaseCentre[0] + width * cos(direction),
        segmentBaseCentre[1] - width * sin(direction)
      ];

      // draw the triangle
      drawTheTriangle(canvas, borderX, borderY, rootA, rootB, rootX);

      double directionA;
      double directionB;

      if (rnd.nextDouble() > 0.5) {
        directionA = direction + ratio * angle;
        directionB = direction - (1 - ratio) * angle;
      } else {
        directionA = direction - ratio * angle;
        directionB = direction + (1 - ratio) * angle;
      }

      if (rnd.nextDouble() > 0.5) {
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootA,
            rootX,
            width * widthDecay,
            segmentLength * segmentDecay,
            directionA,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true);
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootX,
            rootB,
            width * widthDecay,
            segmentLength * segmentDecay,
            directionB,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true);
      } else {
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootX,
            rootB,
            width * widthDecay,
            segmentLength * segmentDecay,
            directionB,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true);
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootA,
            rootX,
            width * widthDecay,
            segmentLength * segmentDecay,
            directionA,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true);
      }
    } else {
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
      drawTheTrunk(canvas, borderX, borderY, rootB, P2, P3, rootA, bulbousness);

      // Draw the leaves
      if (currentDepth > leavesAfter) {
        drawTheLeaf(
            canvas,
            borderX,
            borderY,
            P2,
            lineWidth,
            direction - leafAngle,
            leafLength,
            leafStyle);
        drawTheLeaf(
            canvas,
            borderX,
            borderY,
            P3,
            lineWidth,
            direction + leafAngle,
            leafLength,
            leafStyle);
      }

      // next
      if (currentDepth < maxDepth) {
        drawSegment(
            canvas,
            borderX,
            borderY,
            P3,
            P2,
            width * widthDecay,
            segmentLength * segmentDecay,
            direction,
            currentDepth + 1,
            lineWidth,
            leafLength * leafDecay,
            leafStyle,
            false);
      }
    }
  }

  drawTheTrunk(
    Canvas canvas,
    double borderX,
    double borderY,
    List P1,
    List P2,
    List P3,
    List P4,
    double bulbousness,
  ) {
    List PC = [
      (P1[0] + P2[0] + P3[0] + P4[0]) / 4,
      (P1[1] + P2[1] + P3[1] + P4[1]) / 4
    ];
    List P12 = [(P1[0] + P2[0]) / 2, (P1[1] + P2[1]) / 2];
    List PX = [
      PC[0] * (1 - bulbousness) + P12[0] * bulbousness,
      PC[1] * (1 - bulbousness) + P12[1] * bulbousness
    ];
    List P34 = [(P3[0] + P4[0]) / 2, (P3[1] + P4[1]) / 2];
    List PY = [
      PC[0] * (1 - bulbousness) + P34[0] * bulbousness,
      PC[1] * (1 - bulbousness) + P34[1] * bulbousness
    ];

    Path trunk = Path();
    trunk.moveTo(borderX + P1[0], -borderY + P1[1]);
    trunk.quadraticBezierTo(
        borderX + PX[0], -borderY + PX[1], borderX + P2[0], -borderY + P2[1]);
    trunk.lineTo(borderX + P3[0], -borderY + P3[1]);
    trunk.quadraticBezierTo(
        borderX + PY[0], -borderY + PY[1], borderX + P4[0], -borderY + P4[1]);
    trunk.close();

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.fill
          ..color = trunkFillColor.withOpacity(opacity));

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = trunkStrokeWidth
          ..color = trunkOutlineColour.withOpacity(opacity));
  }

  drawTheTriangle(
    Canvas canvas,
    double borderX,
    double borderY,
    List P1,
    List P2,
    List P3,
  ) {
    Path trunk = Path();
    trunk.moveTo(borderX + P1[0], -borderY + P1[1]);
    trunk.lineTo(borderX + P2[0], -borderY + P2[1]);
    trunk.lineTo(borderX + P3[0], -borderY + P3[1]);
    trunk.close();

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.fill
          ..color = trunkFillColor.withOpacity(opacity));

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = trunkStrokeWidth
          ..color = trunkOutlineColour.withOpacity(opacity));

  }

  drawTheLeaf(
    Canvas canvas,
    double borderX,
    double borderY,
    List leafPosition,
    double lineWidth,
    double leafAngle,
    double leafLength,
    String leafStyle,
  ) {
    double leafAssymetery = 0.75;

    // pick a random color
    print('drawTheLeaf: oopacity: $opacity');
    Color leafColor = palette[rnd.nextInt(palette.length)].withOpacity(opacity);

    var leafRadius = leafLength + rnd.nextDouble() * randomLeafLength;

    // find the centre of the leaf
    List PC = [
      leafPosition[0] + leafRadius * cos(leafAngle),
      leafPosition[1] - leafRadius * sin(leafAngle)
    ];

//    List PN = [PC[0] - leafRadius * cos(leafAngle), PC[1] + leafRadius * sin(leafAngle)];

    // find the tip of the leaf
    List PS = [
      PC[0] - leafRadius * cos(leafAngle + pi),
      PC[1] + leafRadius * sin(leafAngle + pi)
    ];

    // find the offset centre of the leaf
    List POC = [
      PC[0] + leafAssymetery * leafRadius * cos(leafAngle + pi),
      PC[1] - leafAssymetery * leafRadius * sin(leafAngle + pi)
    ];

    List PE = [
      POC[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 0.5),
      POC[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 0.5)
    ];
    List PW = [
      POC[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 1.5),
      POC[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 1.5)
    ];

    // List PSE = [PS[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 0.5), PS[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 0.5)];
    // List PSW = [PS[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 1.5), PS[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 1.5)];

    switch (leafStyle) {
      case "quadratic":
        Path leaf = Path();
        leaf.moveTo(borderX + leafPosition[0], -borderY + leafPosition[1]);
        leaf.quadraticBezierTo(borderX + PE[0], -borderY + PE[1],
            borderX + PS[0], -borderY + PS[1]);
        leaf.quadraticBezierTo(borderX + PW[0], -borderY + PW[1],
            borderX + leafPosition[0], -borderY + leafPosition[1]);
        leaf.close();

        canvas.drawPath(
            leaf,
            Paint()
              ..style = PaintingStyle.fill
              ..color = leafColor);

        break;
    }
  }

  @override
  bool shouldRepaint(OpArtTreePainter oldDelegate) => false;
}
