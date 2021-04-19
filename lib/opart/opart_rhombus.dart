import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:opart_v2/opart_icons.dart';

import '../main.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';

List<String> list = [];

SettingsModel reDraw = SettingsModel(
  name: 'reDraw',
  settingType: SettingType.button,
  label: 'Redraw',
  tooltip: 'Re-draw the picture with a different random seed',
  defaultValue: false,
  icon: const Icon(Icons.refresh),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  onChange: () {
    seed = DateTime.now().millisecond;
  },
  silent: true,
);

SettingsModel columns = SettingsModel(
  name: 'columns',
  settingType: SettingType.int,
  label: 'Columns',
  tooltip: 'The number of columns',
  min: 1,
  max: 30,
  randomMin: 2,
  randomMax: 15,
  defaultValue: 10,
  icon: const Icon(OpArtLab.recursion_depth),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel ratio = SettingsModel(
  name: 'ratio',
  settingType: SettingType.double,
  label: 'Ratio',
  tooltip: 'The aspect ratio of each cell',
  min: 0.01,
  max: 5.0,
  randomMin: 0.3,
  randomMax: 2.5,
  zoom: 100,
  defaultValue: 1.5,
  icon: const Icon(Icons.remove_red_eye),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel offsetY = SettingsModel(
  name: 'offsetY',
  settingType: SettingType.double,
  label: 'Vertical Offset',
  tooltip: 'The offset in the vertical axis',
  min: -50.0,
  max: 50.0,
  zoom: 100,
  defaultValue: 10.0,
  icon: const Icon(OpArtLab.vertical_offset),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel lineWidth = SettingsModel(
  settingType: SettingType.double,
  name: 'lineWidth',
  label: 'Outline Width',
  tooltip: 'The width of the petal outline',
  min: 0.0,
  max: 3.0,
  zoom: 100,
  defaultValue: 0.0,
  icon: const Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel paletteType = SettingsModel(
  name: 'paletteType',
  settingType: SettingType.list,
  label: 'Palette Type',
  tooltip: 'The nature of the palette',
  defaultValue: 'random',
  icon: const Icon(Icons.colorize),
  options: [
    'random',
    'blended random',
    'linear random',
    'linear complementary'
  ],
  settingCategory: SettingCategory.palette,
  onChange: () {
    generatePalette();
  },
  proFeature: false,
);

SettingsModel paletteList = SettingsModel(
  name: 'paletteList',
  settingType: SettingType.list,
  label: 'Palette',
  tooltip: 'Choose from a list of palettes',
  defaultValue: 'Default',
  icon: const Icon(Icons.palette),
  options: defaultPalleteNames(),
  settingCategory: SettingCategory.other,
  proFeature: false,
);

SettingsModel resetDefaults = SettingsModel(
  name: 'resetDefaults',
  settingType: SettingType.button,
  label: 'Reset Defaults',
  tooltip: 'Reset all settings to defaults',
  defaultValue: false,
  icon: const Icon(Icons.low_priority),
  settingCategory: SettingCategory.tool,
  onChange: () {
    resetAllDefaults();
  },
  proFeature: false,
  silent: true,
);

List<SettingsModel> initializeRhombusAttributes() {
  return [
    reDraw,
    columns,
    ratio,
    offsetY,
    lineWidth,
    backgroundColor,
    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];
}

void paintRhombus(
    Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {
  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName) {
    opArt.selectPalette(paletteList.value);
  }

  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;
  double borderX = 0;
  double borderY = 0;

  // Work out the X and Y
  double cellWidth = canvasWidth / columns.value;
  double cellHeight = cellWidth / ratio.value;
  int cellsX = columns.value.toInt();
  int cellsY = (canvasHeight / cellHeight).ceil();
  int extraY = (offsetY.value / cellHeight).ceil();

  int colourOrder = 0;
  Color nextColor;

  // Now make some art

  for (int i = 0; i < cellsX; ++i) {
    for (int j = -extraY; j < cellsY + extraY; ++j) {
      // Choose the next colour
      colourOrder++;
      nextColor = (randomColors.value == false)
          ? opArt.palette.colorList[colourOrder % numberOfColors.value]
              .withOpacity(opacity.value)
          : opArt.palette.colorList[rnd.nextInt(numberOfColors.value)]
              .withOpacity(opacity.value);

      var x = borderX + i * cellWidth;
      var y = borderY + j * cellHeight;

      // var p1 = [x, y];
      var p2 = [x + cellWidth, y - offsetY.value];
      var p3 = [x + cellWidth, y + cellHeight - offsetY.value];
      var p4 = [x, y + cellHeight];

      // draw the rhombus
      Path rhombus = Path();
      rhombus.moveTo(x, y);
      rhombus.lineTo(p2[0], p2[1]);
      rhombus.lineTo(p3[0], p3[1]);
      rhombus.lineTo(p4[0], p4[1]);
      rhombus.close();

      canvas.drawPath(
          rhombus,
          Paint()
            ..strokeWidth = 0.0
            ..color = nextColor
            ..isAntiAlias = false
            ..style = PaintingStyle.fill);

      if (lineWidth.value > 0) {
        canvas.drawPath(
            rhombus,
            Paint()
              ..color = backgroundColor.value.withOpacity(opacity.value)
              ..style = PaintingStyle.stroke
              ..strokeWidth = lineWidth.value);
      }
    }
  }
}
