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
  icon: Icon(OpArtLab.recursion_depth),
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
  icon: Icon(Icons.remove_red_eye),
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
  defaultValue: 0.0,
  icon: Icon(OpArtLab.vertical_offset),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel borderWidth = SettingsModel(
  name: 'borderWidth',
  settingType: SettingType.double,
  label: 'Border Width',
  tooltip: 'The width of the border',
  min: 0.0,
  max: 20.0,
  zoom: 100,
  defaultValue: 20.0,
  icon: Icon(Icons.check_box_outline_blank),
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
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel lineColor = SettingsModel(
  name: 'lineColor',
  settingType: SettingType.color,
  label: "Outline Color",
  tooltip: "The outline colour for the shape",
  defaultValue: Colors.white,
  icon: Icon(Icons.zoom_out_map),
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

List<SettingsModel> initializeRhombusAttributes() {

  return [
    reDraw,
    columns,
    ratio,
    offsetY,
    borderWidth,
    lineWidth,
    lineColor,
    backgroundColor,
    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}


void paintRhombus(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;
  double borderX = borderWidth.value;
  double borderY = borderWidth.value;

  // Work out the X and Y
  double cellWidth = (canvasWidth - 2 * borderWidth.value) / columns.value;
  double cellHeight = cellWidth / ratio.value;
  int cellsX = columns.value.toInt();
  int cellsY = ((canvasHeight - 2 * borderWidth.value) / cellHeight).ceil();
  int extraY = (offsetY.value / cellHeight).ceil();

  int colourOrder = 0;
  Color nextColor;


  // Now make some art

  for (int i = 0; i < cellsX; ++i) {
    for (int j = -extraY; j < cellsY+extraY; ++j) {

      // Choose the next colour
      colourOrder++;
      nextColor = (randomColors.value == false)
          ? opArt.palette.colorList[colourOrder % numberOfColors.value].withOpacity(opacity.value)
          : opArt.palette.colorList[rnd.nextInt(numberOfColors.value)].withOpacity(opacity.value);

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
              ..color = lineColor.value.withOpacity(opacity.value)
              ..style = PaintingStyle.stroke
              ..strokeWidth = lineWidth.value
        );
      }
    }
  }

  //draw the border
  canvas.drawRect(
      Offset(0, 0) & Size(canvasWidth, canvasHeight),
      Paint()
        ..style = PaintingStyle.stroke
        ..color = backgroundColor.value.withOpacity(1.0)
        ..strokeWidth = borderWidth.value*2
  );
}




