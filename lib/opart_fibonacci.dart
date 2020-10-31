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

SettingsModel angleIncrement = SettingsModel(
    name: 'angleIncrement',
    settingType: SettingType.double,
    label: 'Angle Increment',
    tooltip: 'The angle in radians between successive petals of the flower',
    min: 0.0,
    max: 2.0 * pi,
    zoom: 2000,
    defaultValue: (sqrt(5) + 1) / 2,
    icon: Icon(Icons.track_changes),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
  
SettingsModel flowerFill = SettingsModel(
    name: 'flowerFill',
    settingType: SettingType.double,
    label: 'Zoom',
    tooltip: 'Zoom in and out',
    min: 0.3,
    max: 2.0,
    randomMin: 0.5,
    randomMax: 1.5,
    zoom: 100,
    defaultValue: 1.8,
    icon: Icon(Icons.zoom_in),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel petalSize = SettingsModel(
    name: 'petalSize',
    settingType: SettingType.double,
    label: 'Petal Size',
    tooltip: 'The size of the petal as a multiple of its distance from the centre',
    min: 0.01,
    max: 0.5,
    zoom: 100,
    defaultValue: 0.3,
    icon: Icon(Icons.swap_horizontal_circle),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel ratio = SettingsModel(
    name: 'ratio',
    settingType: SettingType.double,
    label: 'Fill Ratio',
    tooltip: 'The fill ratio of the flower',
    min: 0.995,
    max: 0.9999,
    zoom: 100,
    defaultValue: 0.999,
    icon: Icon(Icons.format_color_fill),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel randomizeAngle = SettingsModel(
    name: 'randomizeAngle',
    settingType: SettingType.double,
    label: 'Randomize Angle',
    tooltip: 'randomize the petal position by moving it around the centre by a random angle up to this maximum',
    min: 0.0,
    max: 0.2,
    zoom: 100.0,
    defaultValue: 0.0,
    icon: Icon(Icons.ac_unit),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel petalPointiness = SettingsModel(
    name: 'petalPointiness',
    settingType: SettingType.double,
    label: 'Petal Pointiness',
    tooltip: 'the pointiness of the petal',
    min: 0.0,
    max: pi / 2,
    zoom: 200,
    defaultValue: 0.8,
    icon: Icon(Icons.change_history),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel petalRotation = SettingsModel(
    name: 'petalRotation',
    settingType: SettingType.double,
    label: 'Petal Rotation',
    tooltip: 'the rotation of the petal',
    min: 0.0,
    max: pi,
    zoom: 200,
    defaultValue: 0.0,
    icon: Icon(Icons.rotate_right),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel petalRotationRatio = SettingsModel(
    name: 'petalRotationRatio',
    settingType: SettingType.double,
    label: 'Rotation Ratio',
    tooltip: 'the rotation of the petal as multiple of the petal angle',
    min: 0.0,
    max: 4.0,
    zoom: 100,
    defaultValue: 0.0,
    icon: Icon(Icons.autorenew),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel petalType = SettingsModel(
    name: 'petalType',
    settingType: SettingType.list,
    label: "Petal Type",
    tooltip: "The shape of the petal",
    defaultValue: "square",
    icon: Icon(Icons.local_florist),
    options: <String>['circle', 'triangle', 'square'],
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel maxPetals = SettingsModel(
    name: 'maxPetals',
    settingType: SettingType.int,
    label: 'Max Petals',
    tooltip: 'The maximum number of petals to draw',
    min: 0,
    max: 20000,
    defaultValue: 15000,
    icon: Icon(Icons.fiber_smart_record),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel radialOscAmplitude = SettingsModel(
    name: 'radialOscAmplitude',
    settingType: SettingType.double,
    label: 'Radial Oscillation',
    tooltip: 'The amplitude of the radial oscillation',
    min: 0.0,
    max: 5.0,
    randomMin: 0.0,
    randomMax: 0.0,
    zoom: 100,
    defaultValue: 0.0,
    icon: Icon(Icons.all_inclusive),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel radialOscPeriod = SettingsModel(
    name: 'label',
    settingType: SettingType.double,
    label: 'Oscillation Period',
    tooltip: 'The period of the radial oscillation',
    min: 0.0,
    max: 2.0,
    randomMin: 0.0,
    randomMax: 0.0,
    zoom: 100,
    defaultValue: 0.0,
    icon: Icon(Icons.bubble_chart),
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

SettingsModel lineColor = SettingsModel(
    name: 'lineColor',
    settingType: SettingType.color,
    label: "Outline Color",
    tooltip: "The outline colour for the petals",
    defaultValue: Colors.white,
    icon: Icon(Icons.zoom_out_map),
    settingCategory: SettingCategory.palette,
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
    settingType: SettingType.list,
    name: 'paletteList',
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


List<SettingsModel> initializeFibonacciAttributes() {
  
  return [
    reDraw,
    angleIncrement,
    flowerFill,
    petalSize,
    ratio,
    randomizeAngle,
    petalPointiness,
    petalRotation,
    petalRotationRatio,
    petalType,
    maxPetals,
    radialOscAmplitude,
    radialOscPeriod,
    backgroundColor,
    lineColor,
    lineWidth,
    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}

void paintFibonacci(Canvas canvas, Size size, Random rnd, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  // sort out the palette
  if (numberOfColors.value > opArt.palette.colorList.length){
    opArt.palette.randomize(paletteType.value, numberOfColors.value);
  }
  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  generateFlower(canvas, rnd, size.width, size.height, size.width, size.height, 0,0,size.width/2, size.height/2,

      animationVariable * 2 * pi + angleIncrement.value,
      flowerFill.value,
      petalSize.value,
      ratio.value,
      randomizeAngle.value,
      petalPointiness.value,
      petalRotation.value,
      petalRotationRatio.value,
      petalType.value,
      maxPetals.value.toInt(),
      radialOscAmplitude.value,
      radialOscPeriod.value,
      backgroundColor.value,
      lineColor.value,
      lineWidth.value,
      (randomColors.value == true),
      numberOfColors.value.toInt(),
      paletteType.value,
      opacity.value,
      opArt.palette.colorList,
  );


}
generateFlower(
    Canvas canvas,
    Random rnd,
    double canvasWidth,
    double canvasHeight,
    double imageWidth,
    double imageHeight,
    double borderX,
    double borderY,
    double flowerCentreX,
    double flowerCentreY,
    double currentAngleIncrement,
    double currentFlowerFill,
    double currentPetalToRadius,
    double currentRatio,
    double currentRandomizeAngle,
    double currentPetalPointiness,
    double currentPetalRotation,
    double currentPetalRotationRatio,
    String currentPetalType,
    int currentMaxPetals,
    double currentRadialOscAmplitude,
    double currentRadialOscPeriod,
    Color currentBackgroundColor,
    Color currentLineColor,
    double currentLineWidth,
    bool currentRandomColors,
    int currentNumberOfColors,
    String currentPaletteType,
    double currentOpacity,
    List currentPalette,
    ) {

  // colour in the canvas
  //a rectangle
  canvas.drawRect(
      Offset(borderX, borderY) & Size(imageWidth, imageHeight * 2),
      Paint()
        ..color = currentBackgroundColor
        ..style = PaintingStyle.fill);

  int maxPetalCount = currentMaxPetals;

  // start the colour order
  int colourOrder = 0;
  Color nextColor;


  List P0 = [flowerCentreX + borderX, flowerCentreY + borderY];

  double maxRadius = (imageWidth < imageHeight)
      ? currentFlowerFill * imageWidth / 2
      : currentFlowerFill * imageWidth / 2;
  double minRadius = 2;
  double angle = 0;

  double radius = maxRadius;
  do {
    // Choose the next colour
    colourOrder++;
    nextColor = currentPalette[colourOrder % currentNumberOfColors];
    if (currentRandomColors) {
      nextColor = currentPalette[rnd.nextInt(currentNumberOfColors)];
    }
    Color petalColor = nextColor.withOpacity(currentOpacity);

    drawPetal(
      canvas,
      rnd,
      P0,
      angle,
      radius,
      petalColor,
      currentAngleIncrement,
      currentFlowerFill,
      currentPetalToRadius,
      currentRatio,
      currentRandomizeAngle,
      currentPetalPointiness,
      currentPetalRotation,
      currentPetalRotationRatio,
      currentPetalType,
      currentMaxPetals,
      currentRadialOscAmplitude,
      currentRadialOscPeriod,
      currentBackgroundColor,
      currentLineColor,
      currentLineWidth,
      currentRandomColors,
      currentNumberOfColors,
      currentPaletteType,
      currentOpacity,
      currentPalette,
    );

    angle = angle + currentAngleIncrement;
    if (angle > 2 * pi) {
      angle = angle - 2 * pi;
    }

    radius = radius * currentRatio;

    maxPetalCount = maxPetalCount - 1;
  } while (radius > minRadius && radius < maxRadius && maxPetalCount > 0);

}

drawPetal(
    Canvas canvas,
    Random rnd,
    List P0,
    double angle,
    double radius,
    Color colour,
    double currentAngleIncrement,
    double currentFlowerFill,
    double currentPetalToRadius,
    double currentRatio,
    double currentRandomizeAngle,
    double currentPetalPointiness,
    double currentPetalRotation,
    double currentPetalRotationRatio,
    String currentPetalType,
    int currentMaxPetals,
    double currentRadialOscAmplitude,
    double currentRadialOscPeriod,
    Color currentBackgroundColor,
    Color currentLineColor,
    double currentLineWidth,
    bool currentRandomColors,
    int currentNumberOfColors,
    String currentPaletteType,
    double currentOpacity,
    List currentPalette,
    ) {
  angle = angle + (rnd.nextDouble() - 0.5) * currentRandomizeAngle;

  radius = radius +
      radius *
          (sin(currentRadialOscPeriod * angle) + 1) *
          currentRadialOscAmplitude;

  switch (currentPetalType) {
    case 'circle': //"circle": not quite a circle

      List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
      var petalRadius = radius * currentPetalToRadius;

      canvas.drawCircle(
          Offset(P1[0], P1[1]),
          petalRadius,
          Paint()
            ..style = PaintingStyle.fill
            ..color = colour);
      if (currentLineWidth > 0) {
        canvas.drawCircle(
            Offset(P1[0], P1[1]),
            petalRadius,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColor);
      }
      break;

    case 'triangle': //"triangle":

      List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
      double petalRadius = radius * currentPetalToRadius;

      List PA = [
        P1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio),
        P1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio)
      ];
      List PB = [
        P1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * currentPetalPointiness),
        P1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * currentPetalPointiness)
      ];
      List PC = [
        P1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio -
                    pi * currentPetalPointiness),
        P1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio -
                    pi * currentPetalPointiness)
      ];

      Path triangle = Path();
      triangle.moveTo(PA[0], PA[1]);
      triangle.lineTo(PB[0], PB[1]);
      triangle.lineTo(PC[0], PC[1]);
      triangle.close();

      canvas.drawPath(
          triangle,
          Paint()
            ..style = PaintingStyle.fill
            ..color = colour);
      if (currentLineWidth > 0) {
        canvas.drawPath(
            triangle,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColor);
      }
      break;

    case 'square': // "square":

      List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
      double petalRadius = radius * currentPetalToRadius;

      List PA = [
        P1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 0.0 +
                    currentPetalPointiness +
                    pi / 4),
        P1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 0.0 +
                    currentPetalPointiness +
                    pi / 4)
      ];

      List PB = [
        P1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 0.5 -
                    currentPetalPointiness -
                    pi / 4),
        P1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 0.5 -
                    currentPetalPointiness -
                    pi / 4)
      ];

      List PC = [
        P1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 1.0 +
                    currentPetalPointiness +
                    pi / 4),
        P1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 1.0 +
                    currentPetalPointiness +
                    pi / 4)
      ];

      List PD = [
        P1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 1.5 -
                    currentPetalPointiness -
                    pi / 4),
        P1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 1.5 -
                    currentPetalPointiness -
                    pi / 4)
      ];

      Path square = Path();
      square.moveTo(PA[0], PA[1]);
      square.lineTo(PB[0], PB[1]);
      square.lineTo(PC[0], PC[1]);
      square.lineTo(PD[0], PD[1]);
      square.close();

      canvas.drawPath(
          square,
          Paint()
            ..style = PaintingStyle.fill
            ..color = colour);
      if (currentLineWidth > 0) {
        canvas.drawPath(
            square,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColor);
      }
      break;

    // case 'petal': //"petal":
    //
    //   List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
    //   var petalRadius = radius * currentPetalToRadius;
    //
    //   List PA = [
    //     P1[0] +
    //         petalRadius *
    //             cos(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 0.0),
    //     P1[1] +
    //         petalRadius *
    //             sin(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 0.0)
    //   ];
    //
    //   List PB = [
    //     P1[0] +
    //         petalRadius *
    //             currentPetalPointiness *
    //             cos(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 0.5),
    //     P1[1] +
    //         petalRadius *
    //             currentPetalPointiness *
    //             sin(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 0.5)
    //   ];
    //
    //   List PC = [
    //     P1[0] +
    //         petalRadius *
    //             cos(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 1.0),
    //     P1[1] +
    //         petalRadius *
    //             sin(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 1.0)
    //   ];
    //
    //   List PD = [
    //     P1[0] +
    //         petalRadius *
    //             currentPetalPointiness *
    //             cos(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 1.5),
    //     P1[1] +
    //         petalRadius *
    //             currentPetalPointiness *
    //             sin(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 1.5)
    //   ];
    //
    //   Path petal = Path();
    //
    //   petal.moveTo(PA[0], PA[1]);
    //   petal.quadraticBezierTo(PB[0], PB[1], PC[0], PC[1]);
    //   petal.quadraticBezierTo(PD[0], PD[1], PA[0], PA[1]);
    //   petal.close();
    //
    //   canvas.drawPath(
    //       petal,
    //       Paint()
    //         ..style = PaintingStyle.stroke
    //         ..strokeWidth = currentLineWidth
    //         ..color = currentLineColor);
    //   canvas.drawPath(
    //       petal,
    //       Paint()
    //         ..style = PaintingStyle.fill
    //         ..color = colour);
    //
    //   break;
  }
}


