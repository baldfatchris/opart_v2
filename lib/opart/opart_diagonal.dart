import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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

SettingsModel zoomOpArt = SettingsModel(
  name: 'zoomOpArt',
  settingType: SettingType.double,
  label: 'Zoom',
  tooltip: 'Zoom in or out',
  min: 10.0,
  max: 250.0,
  randomMin: 50.0,
  randomMax: 250.0,
  zoom: 100,
  defaultValue: 150.0,
  icon: const Icon(Icons.zoom_in),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel numberOfPipes = SettingsModel(
  name: 'numberOfPipes',
  settingType: SettingType.int,
  label: 'Number Of Pipes',
  tooltip: 'The number of pipes',
  min: 1,
  max: 50,
  randomMin: 1,
  randomMax: 15,
  defaultValue: 32,
  icon: const Icon(Icons.clear_all),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel ratio = SettingsModel(
  name: 'ratio',
  settingType: SettingType.double,
  label: 'Ratio',
  tooltip: 'The ratio of left and right',
  min: 0.0,
  max: 1.0,
  randomMin: 0.1,
  randomMax: 1.0,
  zoom: 100,
  defaultValue: 1.0,
  icon: const Icon(Icons.pie_chart),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel oneDirection = SettingsModel(
  name: 'oneDirection',
  settingType: SettingType.bool,
  label: 'One Direction',
  tooltip: 'Only bulge in one direction',
  defaultValue: true,
  icon: const Icon(Icons.arrow_upward),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
);

SettingsModel resetColors = SettingsModel(
  name: 'resetColors',
  settingType: SettingType.bool,
  label: 'Reset Colors',
  tooltip: 'Reset the colours for each cell',
  defaultValue: true,
  randomTrue: 0.9,
  icon: const Icon(Icons.gamepad),
  settingCategory: SettingCategory.tool,
  proFeature: true,
  silent: true,
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

List<SettingsModel> initializeDiagonalAttributes() {
  return [
    reDraw,
    zoomOpArt,
    numberOfPipes,
    ratio,
    oneDirection,
    resetColors,
    backgroundColor,
    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];
}

void paintDiagonal(
    Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {
  rnd = Random(seed);
  // print('seed: $seed');

  if (paletteList.value != opArt.palette.paletteName) {
    opArt.selectPalette(paletteList.value as String);
  }

  // Initialise the canvas
  final double canvasWidth = size.width;
  final double canvasHeight = size.height;
  final double sideLength = zoomOpArt.value as double;

  // Work out the X and Y
  final int cellsX = (canvasWidth / sideLength + 2).toInt();
  final int cellsY = (canvasHeight / sideLength + 2).toInt();

  final double borderX = (canvasWidth - sideLength * cellsX) / 2;
  final double borderY = (canvasHeight - sideLength * cellsY) / 2;

  // Now make some art
  drawDiagonal(
    canvas,
    canvasWidth,
    canvasHeight,
    cellsX,
    cellsY,
    borderX,
    borderY,
    sideLength,
    opArt.palette.colorList,
    backgroundColor.value as Color,
    oneDirection.value == true,
    numberOfPipes.value as int,
  );
}

void drawDiagonal(
  Canvas canvas,
  double canvasWidth,
  double canvasHeight,
  int cellsX,
  int cellsY,
  double borderX,
  double borderY,
  double sideLength,
  List colorList,
  Color backgroundColor,
  bool oneDirection,
  int pipes,
) {
  bool parity;
  List centre1;
  List centre2;
  double startAngle;
  int colourOrder = 0;
  int nextColorOrder;
  Color nextColor;
  double radius;
  double offset = 0.0;

  // draw the background
  canvas.drawRect(
      const Offset(0, 0) & Size(canvasWidth, canvasHeight),
      Paint()
        ..color = backgroundColor.withOpacity(1.0)
        ..style = PaintingStyle.fill);

  for (int i = 0; i < cellsX; ++i) {
    for (int j = 0; j < cellsY; ++j) {
      parity = (i + j) % 2 == 0;

      var p0 = [borderX + i * sideLength, borderY + j * sideLength];
      var p1 = [borderX + (i + 1) * sideLength, borderY + j * sideLength];
      var p2 = [borderX + (i + 1) * sideLength, borderY + (j + 1) * sideLength];
      var p3 = [borderX + i * sideLength, borderY + (j + 1) * sideLength];

      // Quarter Circles
      int orientation = oneDirection ? 0 : rnd.nextInt(4);
      switch (orientation) {
        case 0:
          centre1 = p0;
          centre2 = p2;
          startAngle = pi * 0;
          break;

        case 1:
          centre1 = p1;
          centre2 = p3;
          startAngle = pi * 0.5;
          parity = !parity;
          break;

        case 2:
          centre1 = p2;
          centre2 = p0;
          startAngle = pi * 1.0;
          break;

        case 3:
          centre1 = p3;
          centre2 = p1;
          startAngle = pi * 1.5;
          parity = !parity;
          break;
      }

      if (resetColors.value == true) {
        colourOrder = 0;
      }

      for (int i = pipes.toInt(); i > 0; i--) {
        // Choose the next colour
        nextColorOrder = parity ? pipes - colourOrder - 1 : colourOrder;
        colourOrder++;

        if (randomColors.value as bool) {
          nextColor = colorList[rnd.nextInt(numberOfColors.value as int)]
              .withOpacity(opacity.value) as Color;
        } else {
          nextColor = colorList[nextColorOrder % (numberOfColors.value as int)]
              .withOpacity(opacity.value) as Color;
        }

        radius = sideLength / pipes * (i - 0.5 + (ratio.value as double) / 2) -
            offset;
        drawQuarterArc(canvas, centre1, radius, startAngle, nextColor);

        radius = sideLength / pipes * (i - 0.5 - (ratio.value as double) / 2) -
            offset;
        drawQuarterArc(canvas, centre1, radius, startAngle,
            backgroundColor.withOpacity(1.0));
      }

      if (resetColors.value == true) {
        colourOrder = 0;
      }

      for (int i = pipes; i > 0; i--) {
        // Choose the next colour
        nextColorOrder = parity ? pipes - colourOrder - 1 : colourOrder;
        colourOrder++;

        if (randomColors.value as bool) {
          nextColor = colorList[rnd.nextInt(numberOfColors.value as int)]
              .withOpacity(opacity.value) as Color;
        } else {
          nextColor = colorList[nextColorOrder % (numberOfColors.value as int)]
              .withOpacity(opacity.value) as Color;
        }

        radius = sideLength / pipes * (i - 0.5 + (ratio.value as double) / 2) +
            offset;
        drawQuarterArc(canvas, centre2, radius, startAngle + pi, nextColor);

        radius = sideLength / pipes * (i - 0.5 - (ratio.value as double) / 2) +
            offset;
        drawQuarterArc(canvas, centre2, radius, startAngle + pi,
            backgroundColor.withOpacity(1.0));
      }
    }
  }
}

void drawQuarterArc(
    Canvas canvas, List centre, double radius, double startAngle, Color color) {
  canvas.drawArc(
      Rect.fromCenter(
          center: Offset(centre[0] as double, centre[1] as double),
          height: 2 * radius,
          width: 2 * radius),
      startAngle,
      pi / 2,
      true,
      Paint()
        ..isAntiAlias = false
        ..strokeWidth = 0.0
        ..color = color
        ..style = PaintingStyle.fill);
}
