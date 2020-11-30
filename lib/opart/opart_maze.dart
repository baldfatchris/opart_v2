import 'package:flutter/material.dart';
import 'package:opart_v2/opart_icons.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';
import '../main.dart';

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
  label: 'Zoom',
  tooltip: 'Zoom in and out',
  min: 10.0,
  max: 50.0,
  zoom: 100,
  defaultValue: 20.0,
  icon: Icon(Icons.zoom_in),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel lineHorizontal = SettingsModel(
  name: 'lineHorizontal',
  settingType: SettingType.bool,
  label: 'Horizontal',
  tooltip: 'Horizontal line',
  defaultValue: true,
  icon: Icon(OpArtLab.line_horizontal),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
);
SettingsModel lineVertical = SettingsModel(
  name: 'lineVertical',
  settingType: SettingType.bool,
  label: 'Vertical',
  tooltip: 'Vertical line',
  defaultValue: true,
  icon: Icon(OpArtLab.line_vertical),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
);
SettingsModel lineDiagonalRight = SettingsModel(
  name: 'lineDiagonalRight',
  settingType: SettingType.bool,
  label: 'Diagonal Right',
  tooltip: 'Diagonal right line',
  defaultValue: true,
  icon: Icon(OpArtLab.line_diagonal_right),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
);
SettingsModel lineDiagonalLeft = SettingsModel(
  name: 'lineDiagonalLeft',
  settingType: SettingType.bool,
  label: 'Diagonal Left',
  tooltip: 'Diagonal left line',
  defaultValue: true,
  icon: Icon(OpArtLab.line_diagonal_left),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
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

SettingsModel lineWidth = SettingsModel(
  name: 'lineWidth',
  settingType: SettingType.double,
  label: 'Line Width',
  tooltip: 'The width of the line',
  min: 0.0,
  max: 5.0,
  zoom: 100,
  defaultValue: 3.0,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
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
SettingsModel paletteList = SettingsModel(
  name: 'paletteList',
  settingType: SettingType.list,
  label: "Palette",
  tooltip: "Choose from a list of palettes",
  defaultValue: "Default",
  icon: Icon(Icons.palette),
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
  icon: Icon(Icons.low_priority),
  settingCategory: SettingCategory.tool,
  onChange: (){resetAllDefaults();},
  proFeature: false,
  silent: true,
);

List<SettingsModel> initializeMazeAttributes() {

  return [
    reDraw,
    zoomOpArt,

    lineHorizontal,
    lineVertical,
    lineDiagonalLeft,
    lineDiagonalRight,

    backgroundColor,
    randomColors,
    numberOfColors,
    lineWidth,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}


void paintMaze(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;
  double borderX = 0;
  double borderY = 0;
  double imageWidth = canvasWidth;
  double imageHeight = canvasHeight;

  // Work out the X and Y
  int cellsX = (canvasWidth / (zoomOpArt.value)+1.9999999).toInt();
  borderX = (canvasWidth - zoomOpArt.value * cellsX) / 2;

  int cellsY = (canvasHeight / (zoomOpArt.value)+1.9999999).toInt();
  borderY = (canvasHeight - zoomOpArt.value * cellsY) / 2;
  borderY = (canvasHeight - zoomOpArt.value * cellsY) / 2;

  int colourOrder = 0;
  Color nextColor;


  // Now make some art

  // draw the square
  canvas.drawRect(
      Offset(0, 0) & Size(canvasWidth, canvasHeight),
      Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.fill);


  // work out the radius from the width and the cells
  double radius = zoomOpArt.value / 2;
  double sideLength = zoomOpArt.value;

  List shapesArray = [];
  if (lineHorizontal.value == true) { shapesArray.add('lineHorizontal'); }
  if (lineVertical.value == true) { shapesArray.add('lineVertical'); }
  if (lineDiagonalRight.value == true) { shapesArray.add('lineDiagonalRight'); }
  if (lineDiagonalLeft.value == true) { shapesArray.add('lineDiagonalLeft'); }


  // Now make some art
  for (int i = 0; i < cellsX; ++i) {
    for (int j = 0; j < cellsY; ++j) {

      if (shapesArray.length>0) {

        var x = borderX + i * sideLength;
        var y = borderY + j * sideLength;

        var p1 = [x, y];
        var p2 = [x + sideLength, y];
        var p3 = [x + sideLength, y + sideLength];
        var p4 = [x, y + sideLength];

        // Choose the next colour
        colourOrder++;
        nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
        if (randomColors.value) {
          nextColor =
          opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
        }
        nextColor = nextColor.withOpacity(opacity.value);

        List PA = [];
        List PB = [];

        switch (shapesArray[rnd.nextInt(shapesArray.length)]) {
          case 'lineDiagonalRight':
            PA = p1;
            PB = p3;
            break;
          case 'lineDiagonalLeft':
            PA = p2;
            PB = p4;
            break;
          case 'lineHorizontal':
            PA = p1;
            PB = p2;
            break;
          case 'lineVertical':
            PA = p2;
            PB = p3;
            break;
        }

        // draw the line
        canvas.drawLine(Offset(PA[0], PA[1]), Offset(PB[0], PB[1]), Paint()
          ..color = nextColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = lineWidth.value * zoomOpArt.value / 10
          ..strokeCap = StrokeCap.round
        );



      }
    }

  }


}





