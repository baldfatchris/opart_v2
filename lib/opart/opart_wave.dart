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

SettingsModel stepX = SettingsModel(
  name: 'stepX',
  settingType: SettingType.double,
  label: 'stepX',
  tooltip: 'The horizontal width of each stripe',
  min: 1.0,
  max: 50.0,
  zoom: 100,
  defaultValue: 5.0,
  icon: Icon(Icons.more_horiz),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel stepY = SettingsModel(
  name: 'stepY',
  settingType: SettingType.double,
  label: 'stepY',
  tooltip: 'The vertical distance between points on each stripe',
  min: 1.0,
  max: 500.0,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.more_vert),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel frequency = SettingsModel(
  name: 'frequency',
  settingType: SettingType.double,
  label: 'frequency',
  tooltip: 'The frequency of the wave',
  min: 0.0,
  max: 5.0,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.adjust),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel amplitude = SettingsModel(
  name: 'amplitude',
  settingType: SettingType.double,
  label: 'amplitude',
  tooltip: 'The amplitude of the wave',
  min: 0.0,
  max: 500.0,
  randomMin: 0.0,
  randomMax: 200.0,
  zoom: 100,
  defaultValue: 25.0,
  icon: Icon(Icons.graphic_eq),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel offset = SettingsModel(
  name: 'offset',
  settingType: SettingType.double,
  label: 'Offset',
  tooltip: 'The slope of the wave',
  min: -5.0,
  max: 5.0,
  randomMin: -2.0,
  randomMax: 2.0,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.call_made),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel fanWidth = SettingsModel(
  name: 'fanWidth',
  settingType: SettingType.double,
  label: 'Fan Width',
  tooltip: 'The amout the wave fans out',
  min: 0.0,
  max: 2000.0,
  randomMin: 0.0,
  randomMax: 200.0,
  zoom: 100,
  defaultValue: 15.0,
  icon: Icon(Icons.change_history),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel zigZag = SettingsModel(
  name: 'zigZag',
  settingType: SettingType.bool,
  label: 'ZigZag',
  tooltip: 'Make the baby zig!',
  defaultValue: false,
  icon: Icon(Icons.show_chart),
  settingCategory: SettingCategory.tool,
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

List<SettingsModel> initializeWaveAttributes() {

  return [
    reDraw,
    stepX,
    stepY,
    frequency,
    amplitude,
    offset,
    fanWidth,
    zigZag,

    backgroundColor,
    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
   
  ];
}

void paintWave(Canvas canvas, Size size, Random rnd, double animationVariable, OpArt opArt) {

  rnd = Random(seed);


  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  generateWave(canvas, rnd, size.width, size.height, size.width, size.height, 0,0,

    stepX.value,
    stepY.value,
    frequency.value,
    amplitude.value,
    offset.value,
    fanWidth.value,
    zigZag.value,
    backgroundColor.value,
    (randomColors.value == true),
    numberOfColors.value.toInt(),
    paletteType.value,
    opacity.value,
    opArt.palette.colorList,
    animationVariable * 1000,
  );


}

generateWave(
    Canvas canvas,
    Random rnd,
    double canvasWidth,
    double canvasHeight,
    double imageWidth,
    double imageHeight,
    double borderX,
    double borderY,

    double currentStepX,
    double currentStepY,
    double currentFrequency,
    double currentAmplitude,
    double currentOffset,
    double currentFanWidth,
    bool currentZigZag,
    Color currentBackgroundColor,
    bool currentRandomColors,
    int currentNumberOfColors,
    String currentPaletteType,
    double currentOpacity,
    List currentPalette,
    double animationVariable,
    ) {

  int colourOrder = 0;

  // colour in the canvas
  //a rectangle
  canvas.drawRect(
      Offset(borderX, borderY) & Size(imageWidth, imageHeight * 2),
      Paint()
        ..color = currentBackgroundColor
        ..style = PaintingStyle.fill);

  double start = 0 - currentAmplitude;
  double end = imageWidth + currentStepX + currentAmplitude;

  for (double i = start; i < end; i += currentStepX) {

    Color waveColor;
    if (currentRandomColors) {
      waveColor = currentPalette[rnd.nextInt(currentNumberOfColors)];
    } else {
      colourOrder++;
      waveColor = currentPalette[colourOrder % currentNumberOfColors];
    }

    Path wave = Path();

    double j;
    for (j = 0; j < imageHeight + currentStepY; j += currentStepY) {

      double delta = 0.0;

      if (currentZigZag == false){
        delta = currentAmplitude * sin(pi * 2 * (j / imageHeight * currentFrequency + currentOffset * (animationVariable / 0.5) * (2*i-imageWidth) / imageWidth)) + currentFanWidth * ((i -(imageWidth/2))/ imageWidth) * (j / imageHeight);
      }
      else {
        delta = currentAmplitude * asin(sin(pi * 2 * (j / imageHeight * currentFrequency + currentOffset * (animationVariable / 0.5) * (2*i-imageWidth) / imageWidth))) + currentFanWidth * ((i -(imageWidth/2))/ imageWidth) * (j / imageHeight);
      }

      if (j == 0) {
        wave.moveTo(borderX + i + delta, borderY + j);
      } else {
        wave.lineTo(borderX + i + delta, borderY + j);
      }
    }
    for (double k = j; k >= -currentStepY; k -= currentStepY) {

      double delta = 0.0;

      if (currentZigZag == false){
        delta = currentAmplitude * sin(pi * 2 * (k / imageHeight * currentFrequency + currentOffset * (animationVariable / 0.5) * (2*(i + currentStepX)-imageWidth) / imageWidth)) + currentFanWidth * (((i + currentStepX) -(imageWidth/2))/ imageWidth) * (k / imageHeight);
      }
      else
      {
        delta = currentAmplitude * asin(sin(pi * 2 * (k / imageHeight * currentFrequency + currentOffset * (animationVariable / 0.5) * (2*(i + currentStepX)-imageWidth) / imageWidth))) + currentFanWidth * (((i + currentStepX) -(imageWidth/2))/ imageWidth) * (k / imageHeight);
      }

      wave.lineTo(borderX + i + currentStepX + delta, borderY + k);
    }

//      wave.lineTo(borderX + imageWidth, borderY + imageHeight);
    wave.close();

    canvas.drawPath(
        wave,
        Paint()
          ..style = PaintingStyle.fill
          ..color = waveColor);
  }

  // colour in the outer canvas
  var paint1 = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  canvas.drawRect(
      Offset(-canvasWidth, 0) & Size(canvasWidth + borderX, canvasHeight),
      paint1);
  canvas.drawRect(
      Offset(canvasWidth - borderX, 0) &
      Size(borderX + canvasWidth, canvasHeight),
      paint1);

  canvas.drawRect(
      Offset(-canvasWidth, -canvasHeight) &
      Size(3 * canvasWidth, canvasHeight + borderY),
      paint1);
  canvas.drawRect(
      Offset(-canvasWidth, borderY + canvasHeight) &
      Size(3 * canvasWidth, borderY + canvasHeight * 2),
      paint1);
}

