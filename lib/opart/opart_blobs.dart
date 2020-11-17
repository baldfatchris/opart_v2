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

SettingsModel ratio = SettingsModel(
  name: 'ratio',
  settingType: SettingType.double,
  label: 'Pipe Width',
  tooltip: 'The width of the pipe as a proportion of the square side',
  min: 0.0,
  max: 1.0,
  zoom: 100,
  defaultValue: 0.3,
  icon: Icon(Icons.format_color_fill),
  settingCategory: SettingCategory.tool,
  proFeature: false,
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
    ratio,

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


  // Now make some art

  // draw the square
  canvas.drawRect(
      Offset(0, 0) & Size(canvasWidth, canvasHeight),
      Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.fill);


  // work out the radius from the width and the cells
  double radius = zoomBlobs.value / 2;
  double sideLength = zoomBlobs.value;


  // Now make some art
  for (int i = 0; i < cellsX; ++i) {
    for (int j = 0; j < cellsY; ++j) {


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

if (rnd.nextBool()) {
//  top left
  canvas.drawArc(Rect.fromCenter(
      center: Offset(p1[0], p1[1]),
      height: sideLength * (1 + ratio.value),
      width: sideLength * (1 + ratio.value)),
      pi * 0, pi / 2, true, Paint()
        ..color = nextColor
        ..style = PaintingStyle.fill);

  canvas.drawArc(Rect.fromCenter(
      center: Offset(p1[0], p1[1]),
      height: sideLength * (1 - ratio.value),
      width: sideLength * (1 - ratio.value)),
      pi * 0, pi / 2, true, Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.fill);

  canvas.drawArc(Rect.fromCenter(
      center: Offset(p1[0], p1[1]),
      height: sideLength * (1 - ratio.value),
      width: sideLength * (1 - ratio.value)),
      pi * 0, pi / 2, true, Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5);

//  bottom right
  canvas.drawArc(Rect.fromCenter(
      center: Offset(p3[0], p3[1]),
      height: sideLength * (1 + ratio.value),
      width: sideLength * (1 + ratio.value)),
      pi * 1, pi / 2, true, Paint()
        ..color = nextColor
        ..style = PaintingStyle.fill);

  canvas.drawArc(Rect.fromCenter(
      center: Offset(p3[0], p3[1]),
      height: sideLength * (1 - ratio.value),
      width: sideLength * (1 - ratio.value)),
      pi * 1, pi / 2, true, Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.fill);

  canvas.drawArc(Rect.fromCenter(
      center: Offset(p3[0], p3[1]),
      height: sideLength * (1 - ratio.value),
      width: sideLength * (1 - ratio.value)),
      pi * 1, pi / 2, true, Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5);
}
else
{
//  top right
  canvas.drawArc(Rect.fromCenter(
      center: Offset(p2[0], p2[1]),
      height: sideLength * (1 + ratio.value),
      width: sideLength * (1 + ratio.value)),
      pi * 0.5, pi / 2, true, Paint()
        ..color = nextColor
        ..style = PaintingStyle.fill);

  canvas.drawArc(Rect.fromCenter(
      center: Offset(p2[0], p2[1]),
      height: sideLength * (1 - ratio.value),
      width: sideLength * (1 - ratio.value)),
      pi * 0.5, pi / 2, true, Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.fill);

  canvas.drawArc(Rect.fromCenter(
      center: Offset(p2[0], p2[1]),
      height: sideLength * (1 - ratio.value),
      width: sideLength * (1 - ratio.value)),
      pi * 0.5, pi / 2, true, Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5);

//  bottom left
  canvas.drawArc(Rect.fromCenter(
      center: Offset(p4[0], p4[1]),
      height: sideLength * (1 + ratio.value),
      width: sideLength * (1 + ratio.value)),
      pi * 1.5, pi / 2, true, Paint()
        ..color = nextColor
        ..style = PaintingStyle.fill);

  canvas.drawArc(Rect.fromCenter(
      center: Offset(p4[0], p4[1]),
      height: sideLength * (1 - ratio.value),
      width: sideLength * (1 - ratio.value)),
      pi * 1.5, pi / 2, true, Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.fill);

  canvas.drawArc(Rect.fromCenter(
      center: Offset(p4[0], p4[1]),
      height: sideLength * (1 - ratio.value),
      width: sideLength * (1 - ratio.value)),
      pi * 1.5, pi / 2, true, Paint()
        ..color = backgroundColor.value.withOpacity(1.0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5);
}

    }

  }


}





