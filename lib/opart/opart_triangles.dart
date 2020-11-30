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

SettingsModel zoomOpArt = SettingsModel(
  name: 'zoomOpArt',
  settingType: SettingType.double,
  label: 'zoomOpArt',
  tooltip: 'The horizontal width of each stripe',
  min: 0.1,
  max: 10.0,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.more_horiz),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel minimumDepth = SettingsModel(
  settingType: SettingType.int,
  name: 'minimumDepth',
  label: 'Minimum Depth',
  tooltip: 'The minimum recursion depth',
  min: 0,
  max: 10,
  zoom: 100,
  defaultValue: 6,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel maximumDepth = SettingsModel(
  settingType: SettingType.int,
  name: 'maximumDepth',
  label: 'Maximum Depth',
  tooltip: 'The maximum recursion depth',
  min: 0,
  max: 20,
  zoom: 100,
  defaultValue: 10,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel density = SettingsModel(
  name: 'density',
  settingType: SettingType.double,
  label: 'Density',
  tooltip: 'The recursion density',
  min: 0.0,
  max: 1.0,
  zoom: 100,
  defaultValue: 0.55,
  icon: Icon(Icons.remove_red_eye),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel ratio = SettingsModel(
  name: 'ratio',
  settingType: SettingType.double,
  label: 'Ratio',
  tooltip: 'The split ratio of each square',
  min: 0.0,
  max: 1.0,
  randomMin: 0.45,
  randomMax: 0.55,
  zoom: 100,
  defaultValue: 0.5,
  icon: Icon(Icons.remove_red_eye),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel randomiseRatio = SettingsModel(
  name: 'randomiseRatio',
  settingType: SettingType.bool,
  label: 'Randomise Ratio',
  tooltip: 'Randomise the split ratio',
  defaultValue: false,
  icon: Icon(Icons.track_changes),
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
  defaultValue: 3.0,
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
  settingCategory: SettingCategory.palette,
  onChange: (){},
  silent: true,
  proFeature: false,
);

List<SettingsModel> initializeTrianglesAttributes() {

  return [
    reDraw,
    zoomOpArt,
    minimumDepth,
    maximumDepth,
    density,
    ratio,
    randomiseRatio,

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


void paintTriangles(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;

  double imageSize = (canvasHeight>canvasWidth) ? canvasHeight : canvasWidth;


  // Now make some art
  List P1 = [0.0, 0.0];
  List P2 = [imageSize, 0.0];
  List P3 = [imageSize, imageSize];
  List P4 = [0.0, imageSize];

  drawTriangle(canvas, opArt.palette.colorList,
      P1, P2, P3,
      0, minimumDepth.value.toInt(), maximumDepth.value.toInt(),
      ratio.value, density.value, randomiseRatio.value,
      0, lineColor.value, lineWidth.value);

  drawTriangle(canvas, opArt.palette.colorList,
      P1, P4, P3,
      0, minimumDepth.value.toInt(), maximumDepth.value.toInt(),
      ratio.value, density.value, randomiseRatio.value,
      0, lineColor.value, lineWidth.value);

}



void drawTriangle(Canvas canvas, List colorList,
    List P0, List P1, List P2,
    int recursionDepth, int minimumDepth, int maximumDepth,
    double ratio, double density, bool randomiseRatio,
    int colourOrder, Color lineColor, double lineWidth) {

  Color nextColor;

  // Choose the next colour
  colourOrder++;
  nextColor = colorList[colourOrder % numberOfColors.value];
  if (randomColors.value) {
    nextColor = colorList[rnd.nextInt(numberOfColors.value)];
  }
  nextColor = nextColor.withOpacity(opacity.value);
  Color localLineColor = lineColor;
  if (lineWidth == 0){
    localLineColor = nextColor;
  }


  Path triangle = Path();
  triangle.moveTo(P0[0], P0[1]);
  triangle.lineTo(P1[0], P1[1]);
  triangle.lineTo(P2[0], P2[1]);
  triangle.close();
  canvas.drawPath(triangle, Paint()
    ..color = nextColor
    ..style = PaintingStyle.fill);
  canvas.drawPath(triangle, Paint()
    ..color = localLineColor
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke
    ..strokeWidth=lineWidth);



  if (recursionDepth < minimumDepth || (recursionDepth < maximumDepth && rnd.nextDouble() < density)) {
    // split


    // work out the longest length
    double L0 = (P2[0] - P1[0]) * (P2[0] - P1[0]) +
        (P2[1] - P1[1]) * (P2[1] - P1[1]);
    double L1 = (P2[0] - P0[0]) * (P2[0] - P0[0]) +
        (P2[1] - P0[1]) * (P2[1] - P0[1]);
    double L2 = (P0[0] - P1[0]) * (P0[0] - P1[0]) +
        (P0[1] - P1[1]) * (P0[1] - P1[1]);

    int splitDirection = (L2 > L0 && L2 > L1) ? 2 : (L1 > L0) ? 1 : 0;


    var localRatio = ratio;
    if (randomiseRatio) {
      localRatio = ratio * (rnd.nextDouble() / 10 + 0.95);
    }

    switch (splitDirection) {
      case 0:
        List PN = [
          P1[0] * localRatio + P2[0] * (1 - localRatio),
          P1[1] * localRatio + P2[1] * (1 - localRatio)
        ];

        drawTriangle(
            canvas,
            colorList,
            P0,
            P1,
            PN,
            recursionDepth + 1,
            minimumDepth,
            maximumDepth,
            ratio,
            density,
            randomiseRatio,
            colourOrder + 1,
            lineColor,
            lineWidth);

        drawTriangle(
            canvas,
            colorList,
            P0,
            P2,
            PN,
            recursionDepth + 1,
            minimumDepth,
            maximumDepth,
            ratio,
            density,
            randomiseRatio,
            colourOrder + 2,
            lineColor,
            lineWidth);

        break;

      case 1:
        List PN = [
          P0[0] * localRatio + P2[0] * (1 - localRatio),
          P0[1] * localRatio + P2[1] * (1 - localRatio)
        ];

        drawTriangle(
            canvas,
            colorList,
            P1,
            P0,
            PN,
            recursionDepth + 1,
            minimumDepth,
            maximumDepth,
            ratio,
            density,
            randomiseRatio,
            colourOrder + 1,
            lineColor,
            lineWidth);

        drawTriangle(
            canvas,
            colorList,
            P1,
            P2,
            PN,
            recursionDepth + 1,
            minimumDepth,
            maximumDepth,
            ratio,
            density,
            randomiseRatio,
            colourOrder + 2,
            lineColor,
            lineWidth);

        break;

      case 2:
        List PN = [
          P0[0] * localRatio + P1[0] * (1 - localRatio),
          P0[1] * localRatio + P1[1] * (1 - localRatio)
        ];

        drawTriangle(
            canvas,
            colorList,
            P2,
            P0,
            PN,
            recursionDepth + 1,
            minimumDepth,
            maximumDepth,
            ratio,
            density,
            randomiseRatio,
            colourOrder + 1,
            lineColor,
            lineWidth);

        drawTriangle(
            canvas,
            colorList,
            P2,
            P1,
            PN,
            recursionDepth + 1,
            minimumDepth,
            maximumDepth,
            ratio,
            density,
            randomiseRatio,
            colourOrder + 2,
            lineColor,
            lineWidth);


        break;
    }
  }



}
