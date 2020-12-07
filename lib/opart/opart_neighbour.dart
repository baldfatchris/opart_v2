import 'package:flutter/material.dart';
import '../main.dart';

import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';

List<String> list = List();

SettingsModel reDraw = SettingsModel(
  name: 'reDraw',
  settingType: SettingType.button,
  label: 'Redraw',
  tooltip: 'Re-draw the picture with a different random seed',
  defaultValue: false,
  icon: Icon(Icons.refresh),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  onChange: (){seed = DateTime.now().millisecond;},
  silent: true,
);

SettingsModel numberOfPoints = SettingsModel(
  settingType: SettingType.int,
  name: 'numberOfPoints',
  label: 'Number of Points',
  tooltip: 'The number of points',
  min: 1,
  max: 5000,
  randomMin: 1,
  randomMax: 2000,
  zoom: 100,
  defaultValue: 1000,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel numberToLink = SettingsModel(
  settingType: SettingType.int,
  name: 'numberToLink',
  label: 'Number to Link',
  tooltip: 'The number of points to link',
  min: 1,
  max: 50,
  zoom: 100,
  defaultValue: 15,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel skipPoints = SettingsModel(
  settingType: SettingType.int,
  name: 'skipPoints',
  label: 'Skip Points',
  tooltip: 'The number of points to skip',
  min: 0,
  max: 10,
  zoom: 100,
  defaultValue: 0,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel lines = SettingsModel(
  name: 'lines',
  settingType: SettingType.bool,
  label: 'Lines',
  tooltip: 'draw lines between each point',
  defaultValue: true,
  icon: Icon(Icons.timeline),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
);



SettingsModel lineWidth = SettingsModel(
  settingType: SettingType.double,
  name: 'lineWidth',
  label: 'Outline Width',
  tooltip: 'The width of the petal outline',
  min: 0.0,
  max: 10.0,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel randomColors = SettingsModel(
  name: 'randomColors',
  settingType: SettingType.bool,
  label: 'Random Colors',
  tooltip: 'randomize the colours',
  defaultValue: true,
  icon: Icon(Icons.gamepad),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
);


SettingsModel paletteType = SettingsModel(
  name: 'paletteType',
  settingType: SettingType.list,
  label: "Palette Type",
  tooltip: "The nature of the palette",
  defaultValue: "random",
  icon: Icon(Icons.colorize),
  options: [
    'random',
    'blended random',
    'linear random',
    'linear complementary'
  ],
  settingCategory: SettingCategory.palette,
  onChange: (){generatePalette();},
  proFeature: false,
);



SettingsModel resetDefaults = SettingsModel(
  name: 'resetDefaults',
  settingType: SettingType.button,
  label: 'Reset Defaults',
  tooltip: 'Reset all settings to defaults',
  defaultValue: false,
  icon: Icon(Icons.low_priority),
  settingCategory: SettingCategory.tool,
  onChange: (){},
  silent: true,
  proFeature: false,
);

List<SettingsModel> initializeNeighbourAttributes() {

  return [
    reDraw,
    numberOfPoints,
    numberToLink,
    skipPoints,
    lines,

    backgroundColor,
    lineColor,
    lineWidth,
    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}


void paintNeighbour(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;


  // draw the square
  canvas.drawRect(
      Offset(0, 0) & Size(canvasWidth, canvasHeight),
      Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.fill);



  // Now make some art
 drawNeighbours(canvas, opArt.palette.colorList,
    canvasWidth, canvasHeight,
    lineWidth.value,
    numberOfPoints.value.toInt(),
    numberToLink.value.toInt(),
    skipPoints.value.toInt(),
  );


}

Future<void> drawNeighbours(Canvas canvas, List colorList,
    double canvasWidth, double canvasHeight,
    double lineWidth, int numberOfPoints, int numberToLink, int skipPoints

) async {

  int colourOrder = 0;

  List points = [];
  for (int i = 0; i<numberOfPoints; i++){
    points.add([canvasWidth * rnd.nextDouble(),canvasHeight * rnd.nextDouble()]);
  }

  // process each point
  points.forEach((point) {

    List sortedPoints = points;
    sortedPoints.sort(
            (point1, point2) =>
            (
                (pow(point1[0]-point[0],2) + pow(point1[1]-point[1],2))-
                  (pow(point2[0]-point[0],2) + pow(point2[1]-point[1],2))
            ).toInt()
    );

    for (int j = 1+skipPoints; j < numberToLink+skipPoints; j++){

      // print('$countPoints - $j');

      // Choose the next colour
      colourOrder++;
      Color nextColor = colorList[colourOrder % numberOfColors.value];
      if (randomColors.value) {
        nextColor = colorList[rnd.nextInt(numberOfColors.value)];
      }
      nextColor = nextColor.withOpacity(opacity.value);

      canvas.drawLine(Offset(point[0], point[1]), Offset(sortedPoints[j][0], sortedPoints[j][1]), Paint()
        ..color = nextColor
        // ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth
        // ..strokeWidth = 1
        ..strokeCap = StrokeCap.round
      );

    }
  });




}
