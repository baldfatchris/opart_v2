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
  min: 0.2,
  max: 4.0,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.zoom_in),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel numberOfDivisions = SettingsModel(
  name: 'numberOfDivisions',
  settingType: SettingType.int,
  label: 'Number of divisions',
  tooltip: 'The number of divisions in the perimiter',
  min: 5,
  max: 100,
  randomMin: 5,
  randomMax: 50,
  defaultValue: 40,
  icon: Icon(Icons.filter_tilt_shift),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel numberOfChords = SettingsModel(
  name: 'numberOfChords',
  settingType: SettingType.int,
  label: 'Number of chords',
  tooltip: 'The number of chords in the design',
  min: 1,
  max: 100,
  randomMin: 1,
  randomMax: 50,
  defaultValue: 20,
  icon: Icon(Icons.filter_tilt_shift),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel skip = SettingsModel(
  name: 'skip',
  settingType: SettingType.int,
  label: 'Skip',
  tooltip: 'The number of points to skip',
  min: 0,
  max: 100,
  defaultValue: 10,
  icon: Icon(Icons.filter_tilt_shift),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel step = SettingsModel(
  name: 'step',
  settingType: SettingType.int,
  label: 'Step',
  tooltip: 'The number of points to step',
  min: 1,
  max: 100,
  defaultValue: 1,
  icon: Icon(Icons.filter_tilt_shift),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel spiralRatio = SettingsModel(
  settingType: SettingType.double,
  name: 'spiralRatio',
  label: 'Spiral Ratio',
  tooltip: 'The ratio of the spiral',
  min: 0.9,
  max: 1.0,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.arrow_circle_down),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel lineWidth = SettingsModel(
  settingType: SettingType.double,
  name: 'lineWidth',
  label: 'Line Width',
  tooltip: 'The width of the lines',
  min: 0.1,
  max: 10.0,
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
  options: <String>['random', 'blended random', 'linear random', 'linear complementary'],
  settingCategory: SettingCategory.palette,
  onChange: () {
    generatePalette();
  },
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
  settingCategory: SettingCategory.palette,
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
  proFeature: false,
  onChange: () {
    resetAllDefaults();
  },
  silent: true,
);

List<SettingsModel> initializeStringAttributes() {
  return [
    reDraw,
    zoomOpArt,
    numberOfDivisions,
    numberOfChords,
    skip,
    step,
    spiralRatio,
    lineWidth,

    backgroundColor,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    randomColors,
    resetDefaults,
  ];
}

void paintString(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {
  rnd = Random(seed);

  // colour in the canvas
  canvas.drawRect(
      Offset(0, 0) & Size(size.width, size.height),
      Paint()
        ..color = backgroundColor.value
        ..style = PaintingStyle.fill);

  double borderX = (size.width < size.height) ? 0 : (size.height - size.width)/2;
  double borderY = (size.width > size.height) ? 0 : (size.width - size.height)/2;
  double radius = (size.width < size.height) ? size.width/2 * zoomOpArt.value : size.height/2 * zoomOpArt.value;
  int chords = (numberOfChords.value<numberOfDivisions.value) ? numberOfChords.value : numberOfDivisions.value;
  int colourOrder = 0;
  Color nextColor;
  List colorList = opArt.palette.colorList;
  double spiral = 1.0;

  for (int j = 0; j < chords; j++) {
    for (int i = 0; i < numberOfDivisions.value; i++) {



      List p0 = [
        size.width / 2 + spiral * radius * cos(i * 2 * pi / numberOfDivisions.value),
        size.height / 2 - spiral * radius * sin(i * 2 * pi / numberOfDivisions.value)
      ];

      List p1 = [
        size.width / 2 + spiral * radius * cos((i + 1 + j*step.value + skip.value) * 2 * pi / numberOfDivisions.value),
        size.height / 2 - spiral * radius * sin((i + 1 + j*step.value + skip.value) * 2 * pi / numberOfDivisions.value)
      ];

      colourOrder++;
      spiral = spiral * spiralRatio.value;

          nextColor = (randomColors.value == true)
          ? colorList[rnd.nextInt(numberOfColors.value)].withOpacity(opacity.value)
          : colorList[colourOrder % numberOfColors.value].withOpacity(opacity.value);

      canvas.drawLine(Offset(p0[0], p0[1]), Offset(p1[0], p1[1]), Paint()
        ..color = nextColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth.value
        ..strokeCap = StrokeCap.round);
    }
  }

}

