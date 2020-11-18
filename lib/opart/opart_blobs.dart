import 'package:flutter/material.dart';
import 'package:opart_v2/opart_icons.dart';
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

SettingsModel zoomBlobs = SettingsModel(
  name: 'zoomBlobs',
  settingType: SettingType.double,
  label: 'Zoom',
  tooltip: 'Zoom in and out',
  min: 10.0,
  max: 100.0,
  zoom: 100,
  defaultValue: 50.0,
  icon: Icon(Icons.zoom_in),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel numberOfPipes = SettingsModel(
  name: 'numberOfPipes',
  settingType: SettingType.int,
  label: 'Number Of Pipes',
  tooltip: 'The number of pipes',
  min: 1,
  max: 10,
  defaultValue: 1,
  icon: Icon(Icons.clear_all),
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
  randomMax: 0.7,
  zoom: 100,
  defaultValue: 0.3,
  icon: Icon(Icons.pie_chart),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel resetColors = SettingsModel(
  name: 'resetColors',
  settingType: SettingType.bool,
  label: 'Reset Colors',
  tooltip: 'Reset the colours for each cell',
  defaultValue: true,
  icon: Icon(Icons.gamepad),
  settingCategory: SettingCategory.palette,
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

double aspectRatio = pi/2;

List<SettingsModel> initializeBlobsAttributes() {

  return [
    reDraw,
    zoomBlobs,
    numberOfPipes,
    ratio,
    resetColors,

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


void paintBlobs(Canvas canvas, Size size, Random rnd, double animationVariable, OpArt opArt) {

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
  int cellsX = (canvasWidth / (zoomBlobs.value)+1.9999999).toInt();
  borderX = (canvasWidth - zoomBlobs.value * cellsX) / 2;

  int cellsY = (canvasHeight / (zoomBlobs.value)+1.9999999).toInt();
  borderY = (canvasHeight - zoomBlobs.value * cellsY) / 2;
  borderY = (canvasHeight - zoomBlobs.value * cellsY) / 2;

  int colourOrder = 0;
  Color nextColor;
  List centre1;
  List centre2;
  double startAngle1;
  double startAngle2;

  // Now make some art

  // draw the square
  canvas.drawRect(
      Offset(0, 0) & Size(canvasWidth, canvasHeight),
      Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.fill);


  // work out the radius from the width and the cells
  double radius;
  double sideLength = zoomBlobs.value;


  // Now make some art
  for (int i = 0; i < cellsX; ++i) {
    for (int j = 0; j < cellsY; ++j) {


        var x = borderX + i * sideLength;
        var y = borderY + j * sideLength;

        var p0 = [x, y];
        var p1 = [x + sideLength, y];
        var p2 = [x + sideLength, y + sideLength];
        var p3 = [x, y + sideLength];

        int orientation = rnd.nextInt(4);
        switch (orientation) {

          case 0:
            centre1 = p0;
            centre2 = p2;
            startAngle1 = pi * 0;
            startAngle2 = pi * 1;
            break;

          case 1:
            centre1 = p1;
            centre2 = p3;
            startAngle1 = pi * 0.5;
            startAngle2 = pi * 1.5;
            break;

          case 2:
            centre1 = p2;
            centre2 = p0;
            startAngle1 = pi * 1.0;
            startAngle2 = pi * 0;
            break;

          case 3:
            centre1 = p3;
            centre2 = p1;
            startAngle1 = pi * 1.5;
            startAngle2 = pi * 0.5;
            break;
        }

        if (resetColors.value == true) {
          colourOrder = 0;
        }

        for (int i = numberOfPipes.value.toInt(); i > 0; i--){

          // Choose the next colour
          colourOrder++;
          nextColor = (randomColors.value == true)
              ? opArt.palette.colorList[rnd.nextInt(numberOfColors.value)].withOpacity(opacity.value)
              : opArt.palette.colorList[colourOrder % numberOfColors.value].withOpacity(opacity.value);

          radius = sideLength / numberOfPipes.value * (i-0.5 + ratio.value/2);
          drawQuarterArc(canvas, centre1, radius, startAngle1, nextColor);

          radius = sideLength / numberOfPipes.value * (i-0.5 - ratio.value/2);
          drawQuarterArc(canvas, centre1, radius, startAngle1, backgroundColor.value.withOpacity(1.0));

        }

        for (int i = numberOfPipes.value.toInt(); i > 0; i--){

          // Choose the next colour
          colourOrder++;
          nextColor = (randomColors.value == true)
              ? opArt.palette.colorList[rnd.nextInt(numberOfColors.value)].withOpacity(opacity.value)
              : opArt.palette.colorList[colourOrder % numberOfColors.value].withOpacity(opacity.value);

          radius = sideLength / numberOfPipes.value * (i-0.5 + ratio.value/2);
          drawQuarterArc(canvas, centre2, radius, startAngle2, nextColor);

          radius = sideLength / numberOfPipes.value * (i-0.5 - ratio.value/2);
          drawQuarterArc(canvas, centre2, radius, startAngle2, backgroundColor.value.withOpacity(1.0));

        }

//
// if (rnd.nextDouble()>ratio.value) {
// //  top left
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p1[0], p1[1]),
//       height: sideLength * (1 + pipeWidth.value),
//       width: sideLength * (1 + pipeWidth.value)),
//       pi * 0, pi / 2, true, Paint()
//         ..color = nextColor
//         ..style = PaintingStyle.fill);
//
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p1[0], p1[1]),
//       height: sideLength * (1 - pipeWidth.value),
//       width: sideLength * (1 - pipeWidth.value)),
//       pi * 0, pi / 2, true, Paint()
//         ..color = backgroundColor.value.withOpacity(1.0)
//         ..style = PaintingStyle.fill);
//
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p1[0], p1[1]),
//       height: sideLength * (1 - pipeWidth.value),
//       width: sideLength * (1 - pipeWidth.value)),
//       pi * 0, pi / 2, true, Paint()
//         ..color = backgroundColor.value.withOpacity(1.0)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 0.2);
//
// //  bottom right
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p3[0], p3[1]),
//       height: sideLength * (1 + pipeWidth.value),
//       width: sideLength * (1 + pipeWidth.value)),
//       pi * 1, pi / 2, true, Paint()
//         ..color = nextColor
//         ..style = PaintingStyle.fill);
//
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p3[0], p3[1]),
//       height: sideLength * (1 - pipeWidth.value),
//       width: sideLength * (1 - pipeWidth.value)),
//       pi * 1, pi / 2, true, Paint()
//         ..color = backgroundColor.value.withOpacity(1.0)
//         ..style = PaintingStyle.fill);
//
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p3[0], p3[1]),
//       height: sideLength * (1 - pipeWidth.value),
//       width: sideLength * (1 - pipeWidth.value)),
//       pi * 1, pi / 2, true, Paint()
//         ..color = backgroundColor.value.withOpacity(1.0)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 0.2);
// }
// else
// {
// //  top right
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p2[0], p2[1]),
//       height: sideLength * (1 + pipeWidth.value),
//       width: sideLength * (1 + pipeWidth.value)),
//       pi * 0.5, pi / 2, true, Paint()
//         ..color = nextColor
//         ..style = PaintingStyle.fill);
//
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p2[0], p2[1]),
//       height: sideLength * (1 - pipeWidth.value),
//       width: sideLength * (1 - pipeWidth.value)),
//       pi * 0.5, pi / 2, true, Paint()
//         ..color = backgroundColor.value.withOpacity(1.0)
//         ..style = PaintingStyle.fill);
//
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p2[0], p2[1]),
//       height: sideLength * (1 - pipeWidth.value),
//       width: sideLength * (1 - pipeWidth.value)),
//       pi * 0.5, pi / 2, true, Paint()
//         ..color = backgroundColor.value.withOpacity(1.0)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 0.2);
//
// //  bottom left
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p4[0], p4[1]),
//       height: sideLength * (1 + pipeWidth.value),
//       width: sideLength * (1 + pipeWidth.value)),
//       pi * 1.5, pi / 2, true, Paint()
//         ..color = nextColor
//         ..style = PaintingStyle.fill);
//
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p4[0], p4[1]),
//       height: sideLength * (1 - pipeWidth.value),
//       width: sideLength * (1 - pipeWidth.value)),
//       pi * 1.5, pi / 2, true, Paint()
//         ..color = backgroundColor.value.withOpacity(1.0)
//         ..style = PaintingStyle.fill);
//
//   canvas.drawArc(Rect.fromCenter(
//       center: Offset(p4[0], p4[1]),
//       height: sideLength * (1 - pipeWidth.value),
//       width: sideLength * (1 - pipeWidth.value)),
//       pi * 1.5, pi / 2, true, Paint()
//         ..color = backgroundColor.value.withOpacity(1.0)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 0.2);
// }

    }

  }


}

void drawQuarterArc(Canvas canvas, List centre, double radius, double startAngle, Color color)
{
  canvas.drawArc(Rect.fromCenter(
      center: Offset(centre[0], centre[1]),
      height: 2 * radius,
      width: 2 * radius),
      startAngle, pi / 2, true, Paint()
        ..color = color
        ..style = PaintingStyle.fill);

  canvas.drawArc(Rect.fromCenter(
      center: Offset(centre[0], centre[1]),
      height: 2 * radius,
      width: 2 * radius),
      startAngle, pi / 2, true, Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.2);
}



