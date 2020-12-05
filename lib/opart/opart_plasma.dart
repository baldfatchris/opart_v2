import 'package:flutter/material.dart';
import '../main.dart';

import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';

List cells;
List shades;
int shadeOffset;
int recursionDepthOld;
double randomizerOld;

SettingsModel reDraw = SettingsModel(
  name: 'reDraw',
  settingType: SettingType.button,
  label: 'Redraw',
  tooltip: 'Re-draw the picture with a different random seed',
  defaultValue: false,
  randomTrue: 1.0,
  icon: Icon(Icons.refresh),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  onChange: (){seed = DateTime.now().millisecond;},
  silent: true,
);

SettingsModel recursionDepth = SettingsModel(
  settingType: SettingType.int,
  name: 'recursionDepth',
  label: 'Recursion Depth',
  tooltip: 'The recursion depth',
  min: 2,
  max: 8,
  zoom: 100,
  defaultValue: 8,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel colorDepth = SettingsModel(
  settingType: SettingType.int,
  name: 'colorDepth',
  label: 'Color Depth',
  tooltip: 'Sets the colorDepth.valueness of the colors',
  min: 1,
  max: 100,
  zoom: 100,
  defaultValue: 32,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel randomizer = SettingsModel(
  name: 'randomizer',
  settingType: SettingType.double,
  label: 'Randomizer',
  tooltip: 'The amount of randomness in the plasma',
  min: 0.0,
  max: 0.5,
  randomMin: 0.05,
  randomMax: 0.35,
  zoom: 100,
  defaultValue: 0.1,
  icon: Icon(Icons.remove_red_eye),
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

List<SettingsModel> initializePlasmaAttributes() {

  return [
    reDraw,
    recursionDepth,
    colorDepth,
    randomizer,


    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}


void paintPlasma(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {
  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }

  if (reDraw.value == true || shades == null || shades.length != (opArt.palette.colorList.length-1)*colorDepth.value+1 ){

    // generate the palette
    shadeOffset = 0;
    shades = null;

    int numberOfColors = opArt.palette.colorList.length;
    int numberOfShades = (numberOfColors-1)*colorDepth.value+1;
    shades = List(numberOfShades);
    shades[0] = opArt.palette.colorList[0];
    for (int i=1; i<opArt.palette.colorList.length; i++) {
      for (int j = 1; j <= colorDepth.value; j++) {
        shades[(i-1)*colorDepth.value+j] = Color.fromRGBO(
            (opArt.palette.colorList[i-1].red * (colorDepth.value - j) + opArt.palette.colorList[i].red * j)~/colorDepth.value,
            (opArt.palette.colorList[i-1].blue * (colorDepth.value - j) + opArt.palette.colorList[i].blue * j)~/colorDepth.value,
            (opArt.palette.colorList[i-1].green * (colorDepth.value - j) + opArt.palette.colorList[i].green * j)~/colorDepth.value,
            1);
      }
    }

  }

  if (reDraw.value == true || recursionDepthOld != recursionDepth.value || randomizerOld != randomizer.value) {
    recursionDepthOld = recursionDepth.value;
    randomizerOld = randomizer.value;

  // reseed - otherwise it's boring
  rnd = Random(DateTime.now().millisecond);

  // generate the plasma
    cells = null;

    // create the grid
    int numberOfCells = pow(2, recursionDepth.value);
    // print('numberOfCells: $numberOfCells');

    cells = List(numberOfCells + 1);
    for (int i = 0; i <= numberOfCells; i++) {
      cells[i] = List(numberOfCells + 1);
    }

    // populate the corners
    cells[0][0] = rnd.nextDouble();
    cells[0][numberOfCells] = rnd.nextDouble();
    cells[numberOfCells][0] = rnd.nextDouble();
    cells[numberOfCells][numberOfCells] = rnd.nextDouble();

    for (int d = numberOfCells; d > 1; d = d ~/ 2) {
      for (int i = d ~/ 2; i <= numberOfCells; i = i + d) {
        for (int j = d ~/ 2; j <= numberOfCells; j = j + d) {
          square(i, j, d ~/ 2, randomizer.value, numberOfCells);
        }
      }
      for (int i = d ~/ 2; i <= numberOfCells; i = i + d) {
        for (int j = d ~/ 2; j <= numberOfCells; j = j + d) {
          diamond(i, j - d ~/ 2, d ~/ 2, randomizer.value, numberOfCells);
          diamond(i, j + d ~/ 2, d ~/ 2, randomizer.value, numberOfCells);
          diamond(i - d ~/ 2, j, d ~/ 2, randomizer.value, numberOfCells);
          diamond(i + d ~/ 2, j, d ~/ 2, randomizer.value, numberOfCells);
        }
      }
    }
  }







  // Initialise the canvas
  int numberOfCells = pow(2,recursionDepth.value);
  double cellWidth = size.width / (numberOfCells + 1);
  double cellHeight = size.height / (numberOfCells + 1);

  // Now make some art
  for (int i = 0; i <= numberOfCells; ++i) {
    for (int j = 0; j <= numberOfCells; ++j) {

      var p1 = [i*cellWidth, j*cellHeight];

// print('i: $i j: $j cells[i][j]: ${cells[i][j]} shades.length: ${shades.length} shades[ (shadeOffset + (cells[i][j]*shades.length).toInt()) % shades.length]: ${shades[ (shadeOffset + (cells[i][j]*shades.length).toInt()) % shades.length]}');

      Color nextColor = shades[ (shadeOffset + (cells[i][j]*shades.length).toInt()) % shades.length];
      nextColor = (nextColor == null) ? Colors.white : nextColor;

      // draw the square
      canvas.drawRect(
          Offset(p1[0], p1[1]) & Size(cellWidth, cellHeight),
          Paint()
            ..strokeWidth = 0.0
            ..color = nextColor
            ..isAntiAlias = false
            ..style = PaintingStyle.fill);

    }

  }

  // print('shadeOffset: $shadeOffset');
  shadeOffset++;

}


// fill the centre of the square
void square(int x, int y, int width, double randomizer, int numberOfCells){
  // print('square x: $x y: $y width: $width randomizer: $randomizer numberOfCells: $numberOfCells');

  double fill =
    (
        cells[x-width][y-width] +
        cells[x-width][y+width] +
        cells[x+width][y-width] +
        cells[x+width][y+width]
    )/4 +
    rnd.nextDouble()*randomizer - randomizer/2;

  cells[x][y] = (fill>1) ? 1 : (fill<0) ? 0 : fill;

}
// fill the centre of the diamond
void diamond(int x, int y, int width, double randomizer, int numberOfCells){

 double fill =
      (
          cells[(x+width <= numberOfCells) ? x+width : x+width-numberOfCells][y] +
          cells[(x-width >= 0) ? x-width : x - width + numberOfCells][y] +
          cells[x][(y+width <= numberOfCells) ? y+width : y+width-numberOfCells] +
          cells[x][(y-width >= 0) ? y-width : y-width+numberOfCells]
      )/4 +
      rnd.nextDouble()*randomizer - randomizer/2;

      cells[x][y] = (fill>1) ? 1 : (fill<0) ? 0 : fill;


}
