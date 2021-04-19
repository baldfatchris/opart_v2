import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

import '../main.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';

// List<String> list = [];

List squaresI;

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
  tooltip: 'Zoom in and out',
  min: 1.0,
  max: 50.0,
  zoom: 100,
  defaultValue: 5.0,
  icon: const Icon(Icons.zoom_in),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

//
//
// SettingsModel randomColors = SettingsModel(
//   name: 'randomColors',
//   settingType: SettingType.bool,
//   label: 'Random Colors',
//   tooltip: 'randomize the colours',
//   defaultValue: true,
//   icon: const Icon(Icons.gamepad),
//   settingCategory: SettingCategory.tool,
//   proFeature: false,
//   silent: true,
// );

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

List<SettingsModel> initializeLifeAttributes() {
  return [
    reDraw,
    zoomOpArt,
    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];
}

void paintLife(
    Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {
  rnd = Random(DateTime.now().millisecond);

  if (paletteList.value != opArt.palette.paletteName) {
    opArt.selectPalette(paletteList.value);
  }

  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;
  double borderX = 0;
  double borderY = 0;

  // Work out the X and Y
  int cellsX = (canvasWidth / (zoomOpArt.value) + 1.9999999).toInt();
  borderX = (canvasWidth - zoomOpArt.value * cellsX) / 2;

  int cellsY = (canvasHeight / (zoomOpArt.value) + 1.9999999).toInt();
  borderY = (canvasHeight - zoomOpArt.value * cellsY) / 2;
  borderY = (canvasHeight - zoomOpArt.value * cellsY) / 2;

  //int colourOrder = 0;
  Color nextColor;

  // Now make some art

  // if first time through, initialise the squares
  // print(squaresI.length);
  if (squaresI == null) {
    // initialise the game
    squaresI = [];

    // Now make some art
    for (int i = 0; i < cellsX; ++i) {
      List squaresJ = [];

      for (int j = 0; j < cellsY; ++j) {
        // Choose the next colour
        // colourOrder++;
        // nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
        // if (randomColors.value) {
        //   nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
        // }
        // nextColor = nextColor.withOpacity(opacity.value);

        // if (rnd.nextDouble()>0.5) nextColor = Colors.black;

        nextColor = Color.fromRGBO(
            (rnd.nextBool()) ? rnd.nextInt((256)) : 0,
            (rnd.nextBool()) ? rnd.nextInt((256)) : 0,
            (rnd.nextBool()) ? rnd.nextInt((256)) : 0,
            1);

        //save the colour
        squaresJ.add(nextColor);

        var x = borderX + i * zoomOpArt.value;
        var y = borderY + j * zoomOpArt.value;

        // draw the square
        canvas.drawRect(
            Offset(x, y) & Size(zoomOpArt.value, zoomOpArt.value),
            Paint()
              ..strokeWidth = 0.0
              ..color = nextColor
              ..isAntiAlias = false
              ..style = PaintingStyle.fill);
      }
      squaresI.add(squaresJ);
    }
  } else {
    List oldSquaresI = squaresI;
    squaresI = [];

    //play the game
    for (int i = 0; i < cellsX; ++i) {
      List squaresJ = [];

      for (int j = 0; j < cellsY; ++j) {
        List neighbours = [];

        // if (i>0 && j>0) neighbours.add(oldSquaresI[i-1][j-1]);
        // if (i>0 && j<cellsY-1) neighbours.add(oldSquaresI[i-1][j+1]);
        // if (i<cellsX-1 && j>0) neighbours.add(oldSquaresI[i+1][j-1]);
        // if (i<cellsX-1 && j<cellsY-1) neighbours.add(oldSquaresI[i+1][j+1]);

        if (i > 0) neighbours.add(oldSquaresI[i - 1][j]);
        if (j > 0) neighbours.add(oldSquaresI[i][j - 1]);
        if (i < cellsX - 1) neighbours.add(oldSquaresI[i + 1][j]);
        if (j < cellsY - 1) neighbours.add(oldSquaresI[i][j + 1]);

        int neighboursRed = 0;
        int neighboursGreen = 0;
        int neighboursBlue = 0;
        int neighboursAlive = 0;

        neighbours.forEach((element) {
          if (element.red > 0) neighboursRed++;
          if (element.green > 0) neighboursGreen++;
          if (element.blue > 0) neighboursBlue++;
          if (HSLColor.fromColor(element).lightness > 0) neighboursAlive++;
        });

        // Any live cell with fewer than two live neighbours dies, as if by underpopulation.
        // Any live cell with two or three live neighbours lives on to the next generation.
        // Any live cell with more than three live neighbours dies, as if by overpopulation.
        // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

        bool wasAliveRed = (oldSquaresI[i][j].red > 100);
        bool nowAliveRed =
            ((wasAliveRed && (neighboursRed == 2 || neighboursRed == 3)) ||
                (!wasAliveRed && neighboursRed == 3));
        bool wasAliveGreen = (oldSquaresI[i][j].green > 100);
        bool nowAliveGreen = ((wasAliveGreen &&
                (neighboursGreen == 2 || neighboursGreen == 3)) ||
            (!wasAliveGreen && neighboursGreen == 3));
        bool wasAliveBlue = (oldSquaresI[i][j].blue > 100);
        bool nowAliveBlue =
            ((wasAliveBlue && (neighboursBlue == 2 || neighboursBlue == 3)) ||
                (!wasAliveBlue && neighboursBlue == 3));

        Color nextColor = Color.fromRGBO(
            (nowAliveRed) ? rnd.nextInt(156) + 100 : 0,
            (nowAliveGreen) ? rnd.nextInt(156) + 100 : 0,
            (nowAliveBlue) ? rnd.nextInt(156) + 100 : 0,
            1);

        //save the colour
        squaresJ.add(nextColor);

        var x = borderX + i * zoomOpArt.value;
        var y = borderY + j * zoomOpArt.value;

        // draw the square
        canvas.drawRect(
            Offset(x, y) & Size(zoomOpArt.value, zoomOpArt.value),
            Paint()
              ..strokeWidth = 0.0
              ..color = nextColor
              ..isAntiAlias = false
              ..style = PaintingStyle.fill);
      }
      squaresI.add(squaresJ);
    }
  }
}
