import 'package:flutter/material.dart';
import 'model_opart.dart';
import 'model_palette.dart';
import 'model_settings.dart';
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

SettingsModel step = SettingsModel(
  name: 'step',
  settingType: SettingType.double,
  label: 'step',
  tooltip: 'The width of each stripe',
  min: 1.0,
  max: 50.0,
  zoom: 100,
  defaultValue: 5.0,
  icon: Icon(Icons.more_horiz),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel group = SettingsModel(
  name: 'group',
  settingType: SettingType.double,
  label: 'Groups',
  tooltip: 'The number of gropus',
  min: 20.0,
  max: 500.0,
  zoom: 100,
  defaultValue: 100.0,
  icon: Icon(Icons.autorenew),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel shape = SettingsModel(
  name: 'shape',
  settingType: SettingType.list,
  label: "Wave Shape",
  tooltip: "The shape of the wave",
  defaultValue: "circle",
  icon: Icon(Icons.local_florist),
  options: <String>['circle', 'triangle', 'square'],
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel pointiness = SettingsModel(
  name: 'pointiness',
  settingType: SettingType.double,
  label: 'Pointiness',
  tooltip: 'the pointiness of the wave',
  min: 0.0,
  max: pi / 2,
  zoom: 200,
  defaultValue: 1.0,
  icon: Icon(Icons.change_history),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel backgroundColor = SettingsModel(
  name: 'backgroundColor',
  settingType: SettingType.color,
  label: "Background Color",
  tooltip: "The background colour for the canvas",
  defaultValue: Colors.cyan,
  icon: Icon(Icons.settings_overscan),
  settingCategory: SettingCategory.palette,
  proFeature: false,
);
SettingsModel randomColors = SettingsModel(
  name: 'randomColors',
  settingType: SettingType.bool ,
  label: 'Random Colors',
  tooltip: 'randomize the colours!',
  defaultValue: false,
  icon: Icon(Icons.gamepad),
  settingCategory: SettingCategory.palette,
  proFeature: false,
);
SettingsModel numberOfColors = SettingsModel(
  name: 'numberOfColors',
  settingType: SettingType.int,
  label: 'Number of Colors',
  tooltip: 'The number of colours in the palette',
  min: 1,
  max: 36,
  defaultValue: 10,
  icon: Icon(Icons.palette),
  settingCategory: SettingCategory.palette,
  proFeature: false,
  onChange: (){checkNumberOfColors();},
);
SettingsModel paletteType = SettingsModel(
  settingType: SettingType.list,
  name: 'paletteType',
  label: "Palette Type",
  tooltip: "The nature of the palette",
  defaultValue: "random",
  icon: Icon(Icons.colorize),
  options: <String>[
  'random',
  'blended random ',
  'linear random',
  'linear complementary'
  ],
  settingCategory: SettingCategory.palette,
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
SettingsModel opacity = SettingsModel(
  name: 'opacity',
  settingType: SettingType.double,
  label: 'Opactity',
  tooltip: 'The opactity of the petal',
  min: 0.2,
  max: 1.0,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.remove_red_eye),
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
  onChange: (){resetAllDefaults();},
  silent: true,
);

List<SettingsModel> initializeDiagonalAttributes() {

  return [
    reDraw,
    step,
    group,
    shape,
    pointiness,

    backgroundColor,
    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
   
  ];
}

void paintDiagonal(Canvas canvas, Size size, Random rnd, double animationVariable, OpArt opArt) {
  rnd = Random(seed);

  // sort out the palette

  if (paletteList.value != opArt.palette.paletteName) {
    opArt.selectPalette(paletteList.value);
  }


  double imageWidth = (size.width > size.height) ? size.width : size.height;
  double borderX = (size.width - imageWidth) / 2;
  double borderY = (size.height - imageWidth) / 2;

  drawWaves(
      canvas,
      imageWidth,
      borderX,
      borderY,
      step.value,
      group.value,
      shape.value,
      pointiness.value,
      opArt.palette.colorList,
      numberOfColors.value.toInt(),
      (randomColors == true),
  );

}
  drawWaves(
      Canvas canvas,
      double imageWidth,
      double borderX,
      double borderY,
      double step,
      double group,
      String shape,
      double pointiness,
      List<Color> colorList,
      int numberOfColors,
      bool randomColors,
      ){

  // Now make some art
  var colourOrder = 0;

  // Start with the Horizontal
  for (double i = 0; i < 2 * imageWidth; i += step) {

    Color waveColor;
    if (randomColors == true) {
      waveColor = colorList[rnd.nextInt(numberOfColors)];
    } else {
      colourOrder++;
      waveColor = colorList[colourOrder % numberOfColors];
    }

    int numberOfArcs = (i / group).floor() * 2 + 3;
    var radiusA = i % group;
    var radiusB = group - radiusA;

    Path wave = Path();
  
    wave.moveTo(borderX + imageWidth, borderY + imageWidth);

    if (i < imageWidth) {
        wave.lineTo(borderX + imageWidth, borderY);
    }

    var jStart = 0;
    var jStop = numberOfArcs;
    if (i >= imageWidth) {
      jStart = ((i + 1 - imageWidth) / group).floor() * 2 + 1;
      jStop = numberOfArcs - jStart;
    }

    for (int j = jStart; j < jStop; j++) {


      if (j % 2 == 0) {

        List PCentre = [
          borderX + group * (numberOfArcs - j - 1) / 2,
          borderY + group * (j / 2)
        ];

        if (PCentre[0] < borderX + imageWidth + group && PCentre[1] < borderY + imageWidth + group)  {

          switch (shape) {
            case "circle":
              wave.arcTo(
                Rect.fromCenter(
                    center: Offset(PCentre[0], PCentre[1]),
                    height: radiusA * 2,
                    width: radiusA * 2
                ),
                0,
                pi / 2,
                false,
              );
              break;

            case "triangle":
              List P1 = [
                PCentre[0] + radiusA * cos(0),
                PCentre[1] + radiusA * sin(0)
              ];
              List P2 = [
                PCentre[0] + pointiness * radiusA * cos(pi / 4),
                PCentre[1] + pointiness * radiusA * sin(pi / 4)
              ];
              List P3 = [
                PCentre[0] + radiusA * cos(pi / 2),
                PCentre[1] + radiusA * sin(pi / 2)
              ];

              wave.lineTo(P1[0], P1[1]);
              wave.lineTo(P2[0], P2[1]);
              wave.lineTo(P3[0], P3[1]);

              break;

            case "square":
              List P1 = [
                PCentre[0] + radiusA * cos(0),
                PCentre[1] + radiusA * sin(0)
              ];
              List P2 = [
                PCentre[0] + radiusA * cos(pi * 1 / 6),
                PCentre[1] + radiusA * sin(pi * 1 / 6)
              ];
              List P3 = [
                PCentre[0] + radiusA * cos(pi * 2 / 6),
                PCentre[1] + radiusA * sin(pi * 2 / 6)
              ];
              List P4 = [
                PCentre[0] + radiusA * cos(pi * 3 / 6),
                PCentre[1] + radiusA * sin(pi * 3 / 6)
              ];

              wave.lineTo(P1[0], P1[1]);
              wave.lineTo(P2[0], P2[1]);
              wave.lineTo(P3[0], P3[1]);
              wave.lineTo(P4[0], P4[1]);

              break;
          }
        }
      }
      else {

        List PCentre = [
          borderX + group * ((numberOfArcs - j) / 2),
          borderY + group * (j + 1) / 2
        ];

        if (PCentre[0] < borderX + imageWidth + group && PCentre[1] < borderY + imageWidth + group)  {
          switch (shape) {
            case "circle":
              wave.arcTo(
                Rect.fromCenter(
                    center: Offset(PCentre[0], PCentre[1]),
                    height: radiusB * 2,
                    width: radiusB * 2
                ),
                pi * 3 / 2,
                -pi / 2,
                false,
              );

              break;

            case "triangle":
              List P3 = [
                PCentre[0] + radiusB * cos(pi),
                PCentre[1] + radiusB * sin(pi)
              ];
              List P2 = [
                PCentre[0] + pointiness * radiusB * cos(pi * 5 / 4),
                PCentre[1] + pointiness * radiusB * sin(pi * 5 / 4)
              ];
              List P1 = [
                PCentre[0] + radiusB * cos(pi * 6 / 4),
                PCentre[1] + radiusB * sin(pi * 6 / 4)
              ];

              wave.lineTo(P1[0], P1[1]);
              wave.lineTo(P2[0], P2[1]);
              wave.lineTo(P3[0], P3[1]);

              break;

            case "square":
              List P1 = [
                PCentre[0] + radiusB * cos(pi * 9 / 6),
                PCentre[1] + radiusB * sin(pi * 9 / 6)
              ];
              List P2 = [
                PCentre[0] + radiusB * cos(pi * 8 / 6),
                PCentre[1] + radiusB * sin(pi * 8 / 6)
              ];
              List P3 = [
                PCentre[0] + radiusB * cos(pi * 7 / 6),
                PCentre[1] + radiusB * sin(pi * 7 / 6)
              ];
              List P4 = [
                PCentre[0] + radiusB * cos(pi * 6 / 6),
                PCentre[1] + radiusB * sin(pi * 6 / 6)
              ];

              wave.lineTo(P1[0], P1[1]);
              wave.lineTo(P2[0], P2[1]);
              wave.lineTo(P3[0], P3[1]);
              wave.lineTo(P4[0], P4[1]);

              break;
          }
        }
      }
    }


    if (i < imageWidth) {
        wave.lineTo(borderX, borderY + imageWidth);
    }

    wave.close();

    canvas.drawPath(
        wave,
        Paint()
          ..style = PaintingStyle.fill
          ..color = waveColor);


    colourOrder++;
  }

}


