import 'package:flutter/material.dart';
import 'model.dart';
import 'palette.dart';
import 'settings_model.dart';
import 'dart:math';
import 'dart:core';

List<String> list = List();

List<SettingsModel> initializeWaveAttributes() {

  return [

    SettingsModel(
      settingType: SettingType.double,
      label: 'stepX',
      name: 'stepX',
      tooltip: 'The horizontal width of each stripe',
      min: 1.0,
      max: 50.0,
      zoom: 100,
      defaultValue: 5.0,
      icon: Icon(Icons.more_horiz),
      settingCategory: SettingCategory.tool,
      proFeature: false,
    ),
    SettingsModel(
      settingType: SettingType.double,
      label: 'stepY',
      name: 'stepY',
      tooltip: 'The vertical distance between points on each stripe',
      min: 1.0,
      max: 500.0,
      zoom: 100,
      defaultValue: 1.0,
      icon: Icon(Icons.more_vert),
      settingCategory: SettingCategory.tool,
      proFeature: false,
    ),
    SettingsModel(
      settingType: SettingType.double,
      label: 'frequency',
      name: 'frequency',
      tooltip: 'The frequency of the wave',
      min: 0.0,
      max: 5.0,
      zoom: 100,
      defaultValue: 1.0,
      icon: Icon(Icons.adjust),
      settingCategory: SettingCategory.tool,
      proFeature: false,
    ),
    SettingsModel(
      settingType: SettingType.double,
      label: 'amplitude',
      name: 'amplitude',
      tooltip: 'The amplitude of the wave',
      min: 0.0,
      max: 500.0,
      randomMin: 0.0,
      randomMax: 200.0,
      zoom: 100,
      defaultValue: 15.0,
      icon: Icon(Icons.weekend),
      settingCategory: SettingCategory.tool,
      proFeature: false,
    ),
    SettingsModel(
      settingType: SettingType.double,
      label: 'Offset',
      name: 'offset',
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
    ),
    SettingsModel(
      settingType: SettingType.double,
      label: 'Fan Width',
      name: 'fanWidth',
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
    ),
    SettingsModel(
      settingType: SettingType.bool,
      label: 'ZigZag',
      name: 'zigZag',
      tooltip: 'Make the baby zig!',
      defaultValue: false,
      icon: Icon(Icons.show_chart),
      settingCategory: SettingCategory.tool,
      proFeature: false,
    ),



    SettingsModel(settingType: SettingType.color,
      name: 'backgroundColor',
      label: "Background Color",
      tooltip: "The background colour for the canvas",
      defaultValue: Colors.cyan,
      icon: Icon(Icons.settings_overscan),
      settingCategory: SettingCategory.palette,
      proFeature: false,
    ),
    SettingsModel(
      name: 'randomColors',
      settingType: SettingType.bool ,
      label: 'Random Colors',
      tooltip: 'randomize the colours!',
      defaultValue: false,
      icon: Icon(Icons.gamepad),
      settingCategory: SettingCategory.palette,
      proFeature: false,
    ),
    SettingsModel(settingType: SettingType.int,
      name: 'numberOfColors',
      label: 'Number of Colors',
      tooltip: 'The number of colours in the palette',
      min: 1,
      max: 36,
      defaultValue: 10,
      icon: Icon(Icons.palette),
      settingCategory: SettingCategory.palette,
      proFeature: false,
    ),
    SettingsModel(
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
      proFeature: false,
    ),
    SettingsModel(
      settingType: SettingType.list,
      name: 'paletteList',
      label: "Palette",
      tooltip: "Choose from a list of palettes",
      defaultValue: "Default",
      icon: Icon(Icons.palette),
      options: defaultPalleteNames(),
      settingCategory: SettingCategory.palette,
      proFeature: false,
    ),
    SettingsModel(
      settingType: SettingType.double,
      label: 'Opactity',
      name: 'opacity',
      tooltip: 'The opactity of the petal',
      min: 0.2,
      max: 1.0,
      zoom: 100,
      defaultValue: 1.0,
      icon: Icon(Icons.remove_red_eye),
      settingCategory: SettingCategory.palette,
      proFeature: false,
    ),

    SettingsModel(
      settingType: SettingType.button,
      name: 'resetDefaults',
      label: 'Reset Defaults',
      tooltip: 'Reset all settings to defaults',
      defaultValue: false,
      icon: Icon(Icons.low_priority),
      settingCategory: SettingCategory.other,
      proFeature: false,
    ),

  ];
}

void paintWave(Canvas canvas, Size size, Random rnd, double animationVariable, List<SettingsModel> attributes, OpArtPalette palette) {

  rnd = Random(seed);

  print('seed: $seed (${DateTime.now()})');
  print('numberOfColors: ${attributes.firstWhere((element) => element.name == 'numberOfColors').value}');
  print('colorCount: ${palette.colorList.length}');
  print('animationVariable: ${animationVariable}');

  // print(attributes.firstWhere((element) => element.name == 'backgroundColor').value);
  // print(attributes.firstWhere((element) => element.name == 'randomColors').value);
  // print('numberOfColors: ${attributes.firstWhere((element) => element.name == 'numberOfColors').value}');
  // print(attributes.firstWhere((element) => element.name == 'paletteType').value);
  // print(attributes.firstWhere((element) => element.name == 'opacity').value);

  generateWave(canvas, rnd, size.width, size.height, size.width, size.height, 0,0,

    attributes.firstWhere((element) => element.name == 'stepX').value,
    attributes.firstWhere((element) => element.name == 'stepY').value,
    attributes.firstWhere((element) => element.name == 'frequency').value,
    attributes.firstWhere((element) => element.name == 'amplitude').value,
    attributes.firstWhere((element) => element.name == 'offset').value,
    attributes.firstWhere((element) => element.name == 'fanWidth').value,
    attributes.firstWhere((element) => element.name == 'zigZag').value,
    attributes.firstWhere((element) => element.name == 'backgroundColor').value,
    (attributes.firstWhere((element) => element.name == 'randomColors').value == true),
    attributes.firstWhere((element) => element.name == 'numberOfColors').value.toInt(),
    attributes.firstWhere((element) => element.name == 'paletteType').value,
    attributes.firstWhere((element) => element.name == 'opacity').value,
    palette.colorList,
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

