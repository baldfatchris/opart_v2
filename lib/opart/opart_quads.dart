import 'package:flutter/material.dart';
import '../main.dart';

import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';

List<String> list = [];

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


SettingsModel paletteType = SettingsModel(
  name: 'paletteType',
  settingType: SettingType.list,
  label: 'Palette Type',
  tooltip: 'The nature of the palette',
  defaultValue: 'random',
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

List<SettingsModel> initializeQuadsAttributes() {

  return [
    reDraw,
    minimumDepth,
    maximumDepth,
    density,
    ratio,
    randomiseRatio,

    lineColor,
    lineWidth,

    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}


void paintQuads(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;

  double imageSize = (canvasHeight>canvasWidth) ? canvasHeight : canvasWidth;

  // Now make some art
  int recursionDepth = 0;
  var colourOrder = 0;

  var p1 = [0.0, 0.0];
  var p2 = [imageSize, 0.0];
  var p3 = [imageSize, imageSize];
  var p4 = [0.0, imageSize];

  drawQuadrilateral(canvas, opArt.palette.colorList,
      p1, p2, p3, p4,
      recursionDepth, minimumDepth.value.toInt(), maximumDepth.value.toInt(),
      ratio.value, density.value, randomiseRatio.value,
      colourOrder, 0, lineColor.value, lineWidth.value);




}



void drawQuadrilateral(Canvas canvas, List colorList,
    List p0, List p1, List p2, List p3,
    int recursionDepth, int minimumDepth, int maximumDepth,
    double ratio, double density, bool randomiseRatio,
    int colourOrder, direction, Color lineColor, double lineWidth) {

  Color nextColor;

  // Choose the next colour
  colourOrder++;
  nextColor = colorList[colourOrder % numberOfColors.value].withOpacity(opacity.value);
  Color localLineColor = lineColor;
  if (lineWidth == 0){
    localLineColor = nextColor;
  }


  Path quad = Path();
  quad.moveTo(p0[0], p0[1]);
  quad.lineTo(p1[0], p1[1]);
  quad.lineTo(p2[0], p2[1]);
  quad.lineTo(p3[0], p3[1]);
  quad.close();
  canvas.drawPath(quad, Paint()
    ..color = nextColor
    ..style = PaintingStyle.fill);
  canvas.drawPath(quad, Paint()
    ..color = localLineColor
    ..style = PaintingStyle.stroke
    ..strokeWidth=lineWidth);



  if (recursionDepth < minimumDepth || (recursionDepth < maximumDepth && rnd.nextDouble() < density)) {
    // split

    var localRatio = ratio;
    if (randomiseRatio) {
      localRatio = ratio * (rnd.nextDouble() / 10 + 0.95);
    }

    if (direction == 0) {
      List pA = [p0[0] * localRatio + p1[0] * (1 - localRatio), p0[1] * localRatio + p1[1] * (1 - localRatio)];
      List pB = [p2[0] * localRatio + p3[0] * (1 - localRatio), p2[1] * localRatio + p3[1] * (1 - localRatio)];

      drawQuadrilateral(canvas, colorList,
          p0, pA, pB, p3,
          recursionDepth + 1, minimumDepth, maximumDepth,
          ratio, density, randomiseRatio,
          colourOrder + 1, 1, lineColor, lineWidth);
      drawQuadrilateral(canvas, colorList,
          p1, pA, pB, p2,
          recursionDepth + 1, minimumDepth, maximumDepth,
          ratio, density, randomiseRatio,
          colourOrder + 1, 1, lineColor, lineWidth);
    }
    else {
      List pA = [p1[0] * localRatio + p2[0] * (1 - localRatio), p1[1] * localRatio + p2[1] * (1 - localRatio)];
      List pB = [p3[0] * localRatio + p0[0] * (1 - localRatio), p3[1] * localRatio + p0[1] * (1 - localRatio)];

      drawQuadrilateral(canvas, colorList,
          p0, p1, pA, pB,
          recursionDepth + 1, minimumDepth, maximumDepth,
          ratio, density, randomiseRatio,
          colourOrder + 1, 0, lineColor, lineWidth);
      drawQuadrilateral(canvas, colorList,
          p2, p3, pB, pA,
          recursionDepth + 1, minimumDepth, maximumDepth,
          ratio, density, randomiseRatio,
          colourOrder + 1, 0, lineColor, lineWidth);
    }


  }
  else {

  }

}
