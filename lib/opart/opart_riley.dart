import 'package:flutter/material.dart';

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

SettingsModel zoomRiley = SettingsModel(
  name: 'zoomRiley',
  settingType: SettingType.double,
  label: 'Zoom',
  tooltip: 'Zoom in and out',
  min: 10.0,
  max: 100.0,
  zoom: 100,
  defaultValue: 40.0,
  icon: Icon(Icons.zoom_in),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel gradientTypeX0 = SettingsModel(
  name: 'gradientTypeX0',
  settingType: SettingType.list,
  label: "gradientTypeX0",
  tooltip: "gradientTypeX0",
  defaultValue: "linear",
  icon: Icon(Icons.settings),
  options: ['linear', 'cycle:0-1', 'cycle:0.5-0.5', "fixed"],
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel gradientTypeX1 = SettingsModel(
  name: 'gradientTypeX1',
  settingType: SettingType.list,
  label: "gradientTypeX1",
  tooltip: "gradientTypeX1",
  defaultValue: "linear",
  icon: Icon(Icons.settings),
  options: ['linear', 'cycle:0-1', 'cycle:0.5-0.5', "fixed"],
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel gradientTypeY0 = SettingsModel(
  name: 'gradientTypeY0',
  settingType: SettingType.list,
  label: "gradientTypeY0",
  tooltip: "gradientTypeY0",
  defaultValue: "linear",
  icon: Icon(Icons.settings),
  options: ['linear', 'cycle:0-1', 'cycle:0.5-0.5', "fixed"],
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel gradientTypeY1 = SettingsModel(
  name: 'gradientTypeY1',
  settingType: SettingType.list,
  label: "gradientTypeY1",
  tooltip: "gradientTypeY1",
  defaultValue: "linear",
  icon: Icon(Icons.settings),
  options: ['linear', 'cycle:0-1', 'cycle:0.5-0.5', "fixed"],
  settingCategory: SettingCategory.tool,
  proFeature: false,
);





SettingsModel randomColors = SettingsModel(
  name: 'randomColors',
  settingType: SettingType.bool,
  label: 'Random Colors',
  tooltip: 'randomize the colours',
  defaultValue: false,
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
SettingsModel paletteList = SettingsModel(
  name: 'paletteList',
  settingType: SettingType.list,
  label: "Palette",
  tooltip: "Choose from a list of palettes",
  defaultValue: "Black and White",
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

double aspectRatio = pi/2;

List<SettingsModel> initializeRileyAttributes() {

  return [
    reDraw,
    zoomRiley,
    gradientTypeX0,
    gradientTypeX1,
    gradientTypeY0,
    gradientTypeY1,

    backgroundColor,
    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}


void paintRiley(Canvas canvas, Size size, Random rnd, double animationVariable, OpArt opArt) {
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
  double sideLength = zoomRiley.value;

  int cellsX = (canvasWidth / (zoomRiley.value)+1.9999999).toInt();
  borderX = (canvasWidth - zoomRiley.value * cellsX) / 2;

  int cellsY = (canvasHeight / (zoomRiley.value)+1.9999999).toInt();
  borderY = (canvasHeight - zoomRiley.value * cellsY) / 2;
  borderY = (canvasHeight - zoomRiley.value * cellsY) / 2;

  int colourOrder = 0;
  Color nextColor;


  // Now make some art
  double cellSizeX = sideLength;
  double cellSizeY = sideLength;

  double gradientH;
  double gradientV;


  for (int i = 0; i < cellsX; ++i) {
    for (int j = 0; j < cellsY; ++j) {

      var x = borderX + i * sideLength;
      var y = borderY + j * sideLength;


      List p1 = [x, y];
      List p2 = [x + sideLength, y];
      List p3 = [x + sideLength, y + sideLength];
      List p4 = [x, y + sideLength];


      double h0 = 0;
      double hN = 0;
      double v0 = 0;
      double vN = 0;



      switch (gradientTypeX0.value) {
        case "linear":
        // Linear progression
          h0 = i / (cellsX - 1);
          break;

        case "cycle:0-1":
        // Sin progression
          h0 = sin(pi * i / (cellsX - 1));
          break;

        case "cycle:0.5-0.5":
        // cos progression
          h0 = 0.5 + 0.5 * cos(pi * 2 * i / (cellsX - 1));
          break;

        case "fixed":
          h0 = 0.5;
          break;
      }

      switch (gradientTypeX1.value) {
        case "linear":
        // Linear progression
          hN = i / (cellsX - 1);
          break;

        case "cycle:0-1":
        // Sin progression
          hN = sin(pi * i / (cellsX - 1));
          break;

        case "cycle:0.5-0.5":
        // cos progression
          hN = 0.5 + 0.5 * cos(pi * 2 * i / (cellsX - 1));
          break;

        case "fixed":
          hN = 0.5;
          break;
      }

      switch (gradientTypeY0.value) {
        case "linear":
        // Linear progression
          v0 = j / (cellsY - 1);
          break;

        case "cycle:0-1":
        // Sin progression
          v0 = sin(pi * j / (cellsY - 1));
          break;

        case "cycle:0.5-0.5":
        // Cos progression
          v0 = 0.5 + 0.5 * cos(pi * 2 * j / (cellsY - 1));
          break;


        case "fixed":
          v0 = 0.5;
          break;
      }



      switch (gradientTypeY1.value) {
        case "linear":
        // Linear progression
          vN = j / (cellsY - 1);
          break;

        case "cycle:0-1":
        // Sin progression
          vN = sin(pi * j / (cellsY - 1));
          break;

        case "cycle:0.5-0.5":
        // Cos progression
          vN = 0.5 + 0.5 * cos(pi * 2 * j / (cellsY - 1));
          break;

        case "fixed":
          vN = 0.5;
          break;
      }

      // If the line is vertical then it is a special case...
      if (h0 == hN) {

        gradientH = (vN - v0) / cellsX;
        gradientV = 999999999;

      }
      else {
        gradientH = (vN - v0) / cellsX;
        gradientV = cellsY / (hN - h0);

      }

      //9 points
      List PA = [borderX + cellSizeX * i, borderY + cellSizeY * j];

      List PB = [borderX + cellSizeX * (i + h0 + (j / cellsY) * (hN - h0)), borderY + cellSizeY * j];

      List PC = [borderX + cellSizeX * (i + 1), borderY + cellSizeY * j];

      List PD = [borderX + cellSizeX * (i + 1), borderY + cellSizeY * (j + v0 + ((i + 1) / cellsX) * (vN - v0))];

      List PE = [borderX + cellSizeX * (i + 1), borderY + cellSizeY * (j + 1)];

      List PF = [borderX + cellSizeX * (i + h0 + ((j + 1) / cellsY) * (hN - h0)), borderY + cellSizeY * (j + 1)];

      List PG = [borderX + cellSizeX * i, borderY + cellSizeY * (j + 1)];

      List PH = [borderX + cellSizeX * i, borderY + cellSizeY * (j + v0 + (i / cellsX) * (vN - v0))];

      double X = (j + v0 + (i + h0) * gradientV) / (gradientV - gradientH);
      List PO = [borderX + cellSizeX * X, borderY + cellSizeY * (j + v0 + gradientH * X)];



      // four quads...

      colourOrder++;
      nextColor = (randomColors.value) ? opArt.palette.colorList[rnd.nextInt(numberOfColors.value)].withOpacity(opacity.value) : opArt.palette.colorList[colourOrder % numberOfColors.value].withOpacity(opacity.value);
      fillQuad(canvas, PA, PB, PO, PH, nextColor);

      colourOrder++;
      nextColor = (randomColors.value) ? opArt.palette.colorList[rnd.nextInt(numberOfColors.value)].withOpacity(opacity.value) : opArt.palette.colorList[colourOrder % numberOfColors.value].withOpacity(opacity.value);
      fillQuad(canvas, PB, PC, PD, PO, nextColor);

      colourOrder++;
      nextColor = (randomColors.value) ? opArt.palette.colorList[rnd.nextInt(numberOfColors.value)].withOpacity(opacity.value) : opArt.palette.colorList[colourOrder % numberOfColors.value].withOpacity(opacity.value);
      fillQuad(canvas, PO, PD, PE, PF, nextColor);

      colourOrder++;
      nextColor = (randomColors.value) ? opArt.palette.colorList[rnd.nextInt(numberOfColors.value)].withOpacity(opacity.value) : opArt.palette.colorList[colourOrder % numberOfColors.value].withOpacity(opacity.value);
      fillQuad(canvas, PH, PO, PF, PG, nextColor);


    }

  }



}

void fillQuad(Canvas canvas, List p1, List p2, List p3, List p4, Color nextColor) {

  Path quad = Path();
  quad.moveTo(p1[0], p1[1]);
  quad.lineTo(p2[0], p2[1]);
  quad.lineTo(p3[0], p3[1]);
  quad.lineTo(p4[0], p4[1]);
  quad.close();

  canvas.drawPath(
      quad,
      Paint()
        ..color = nextColor
        ..style = PaintingStyle.fill);

  canvas.drawPath(
      quad,
      Paint()
        ..color = nextColor
        ..style = PaintingStyle.stroke
        ..strokeWidth=0.01);


}
