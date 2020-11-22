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
  min: 5,
  max: 12,
  zoom: 100,
  defaultValue: 8,
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
  defaultValue: 0.5,
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

// palette settings
SettingsModel backgroundColor = SettingsModel(
  settingType: SettingType.color,
  name: 'backgroundColor',
  label: "Background Color",
  tooltip: "The background colour for the canvas",
  defaultValue: Colors.white,
  icon: Icon(Icons.settings_overscan),
  settingCategory: SettingCategory.palette,
  proFeature: false,
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

double aspectRatio = pi/2;

List<SettingsModel> initializeQuadsAttributes() {

  return [
    reDraw,
    minimumDepth,
    maximumDepth,
    density,
    ratio,
    randomiseRatio,

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

  var P1 = [0.0, 0.0];
  var P2 = [imageSize, 0.0];
  var P3 = [imageSize, imageSize];
  var P4 = [0.0, imageSize];

  drawQuadrilateral(canvas, opArt.palette.colorList,
      P1, P2, P3, P4,
      recursionDepth, minimumDepth.value.toInt(), maximumDepth.value.toInt(),
      ratio.value, density.value, randomiseRatio.value,
      colourOrder, 0, lineColor.value, lineWidth.value);




}



void drawQuadrilateral(Canvas canvas, List colorList,
    List P0, List P1, List P2, List P3,
    int recursionDepth, int minimumDepth, int maximumDepth,
    double ratio, double density, bool randomiseRatio,
    int colourOrder, direction, Color lineColor, double lineWidth) {

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


  Path quad = Path();
  quad.moveTo(P0[0], P0[1]);
  quad.lineTo(P1[0], P1[1]);
  quad.lineTo(P2[0], P2[1]);
  quad.lineTo(P3[0], P3[1]);
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
      List PA = [P0[0] * localRatio + P1[0] * (1 - localRatio), P0[1] * localRatio + P1[1] * (1 - localRatio)];
      List PB = [P2[0] * localRatio + P3[0] * (1 - localRatio), P2[1] * localRatio + P3[1] * (1 - localRatio)];

      drawQuadrilateral(canvas, colorList,
          P0, PA, PB, P3,
          recursionDepth + 1, minimumDepth, maximumDepth,
          ratio, density, randomiseRatio,
          colourOrder + 1, 1, lineColor, lineWidth);
      drawQuadrilateral(canvas, colorList,
          P1, PA, PB, P2,
          recursionDepth + 1, minimumDepth, maximumDepth,
          ratio, density, randomiseRatio,
          colourOrder + 1, 1, lineColor, lineWidth);
    }
    else {
      List PA = [P1[0] * localRatio + P2[0] * (1 - localRatio), P1[1] * localRatio + P2[1] * (1 - localRatio)];
      List PB = [P3[0] * localRatio + P0[0] * (1 - localRatio), P3[1] * localRatio + P0[1] * (1 - localRatio)];

      drawQuadrilateral(canvas, colorList,
          P0, P1, PA, PB,
          recursionDepth + 1, minimumDepth, maximumDepth,
          ratio, density, randomiseRatio,
          colourOrder + 1, 0, lineColor, lineWidth);
      drawQuadrilateral(canvas, colorList,
          P2, P3, PB, PA,
          recursionDepth + 1, minimumDepth, maximumDepth,
          ratio, density, randomiseRatio,
          colourOrder + 1, 0, lineColor, lineWidth);
    }


  }
  else {

  }

}
