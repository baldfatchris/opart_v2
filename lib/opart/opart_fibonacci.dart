import 'package:flutter/material.dart';
import 'package:opart_v2/opart_icons.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';
import '../main.dart';

List<String> list = [];

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
  
SettingsModel zoomOpArt = SettingsModel(
    name: 'zoomOpArt',
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
    label: 'Random Angle',
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
    icon: Icon(OpArtLab.pointiness),
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
    label: 'Petal Type',
    tooltip: 'The shape of the petal',
    defaultValue: 'square',
    icon: Icon(OpArtLab.shapes),
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
//
// SettingsModel randomColors = SettingsModel(
//     name: 'randomColors',
//     settingType: SettingType.bool ,
//     label: 'Random Colors',
//     tooltip: 'randomize the colours!',
//     defaultValue: false,
//     icon: Icon(Icons.gamepad),
//     settingCategory: SettingCategory.tool,
//     silent: true,
//     proFeature: false,
//   );
//


// SettingsModel paletteType = SettingsModel(
//     settingType: SettingType.list,
//     name: 'paletteType',
//     label: 'Palette Type',
//     tooltip: 'The nature of the palette',
//     defaultValue: 'random',
//     icon: Icon(Icons.colorize),
//   options: <String>[
//     'random',
//     'blended random',
//     'linear random',
//     'linear complementary'
//   ],
//     settingCategory: SettingCategory.palette,
//     onChange: (){generatePalette();},
//     proFeature: false,
//   );

SettingsModel paletteList = SettingsModel(
    settingType: SettingType.list,
    name: 'paletteList',
    label: 'Palette',
    tooltip: 'Choose from a list of palettes',
    defaultValue: 'Default',
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
  proFeature: false,
  onChange: (){resetAllDefaults();},
  silent: true,
);


List<SettingsModel> initializeFibonacciAttributes() {
  
  return [
    reDraw,
    angleIncrement,
    zoomOpArt,
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

void paintFibonacci(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  generateFlower(canvas, rnd, size.width, size.height, size.width, size.height, 0,0,size.width/2, size.height/2,

      animationVariable * 2 * pi + angleIncrement.value,
      zoomOpArt.value,
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
void generateFlower(
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


  List p0 = [flowerCentreX + borderX, flowerCentreY + borderY];

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
      p0,
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

void drawPetal(
    Canvas canvas,
    Random rnd,
    List p0,
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
    case 'circle': //'circle': not quite a circle

      List p1 = [p0[0] + radius * cos(angle), p0[1] + radius * sin(angle)];
      var petalRadius = radius * currentPetalToRadius;

      canvas.drawCircle(
          Offset(p1[0], p1[1]),
          petalRadius,
          Paint()
            ..style = PaintingStyle.fill
            ..color = colour);
      if (currentLineWidth > 0) {
        canvas.drawCircle(
            Offset(p1[0], p1[1]),
            petalRadius,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColor);
      }
      break;

    case 'triangle': //'triangle':

      List p1 = [p0[0] + radius * cos(angle), p0[1] + radius * sin(angle)];
      double petalRadius = radius * currentPetalToRadius;

      List pA = [
        p1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio),
        p1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio)
      ];
      List pB = [
        p1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * currentPetalPointiness),
        p1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * currentPetalPointiness)
      ];
      List pC = [
        p1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio -
                    pi * currentPetalPointiness),
        p1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio -
                    pi * currentPetalPointiness)
      ];

      Path triangle = Path();
      triangle.moveTo(pA[0], pA[1]);
      triangle.lineTo(pB[0], pB[1]);
      triangle.lineTo(pC[0], pC[1]);
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

    case 'square': // 'square':

      List p1 = [p0[0] + radius * cos(angle), p0[1] + radius * sin(angle)];
      double petalRadius = radius * currentPetalToRadius;

      List pA = [
        p1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 0.0 +
                    currentPetalPointiness +
                    pi / 4),
        p1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 0.0 +
                    currentPetalPointiness +
                    pi / 4)
      ];

      List pB = [
        p1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 0.5 -
                    currentPetalPointiness -
                    pi / 4),
        p1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 0.5 -
                    currentPetalPointiness -
                    pi / 4)
      ];

      List pC = [
        p1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 1.0 +
                    currentPetalPointiness +
                    pi / 4),
        p1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 1.0 +
                    currentPetalPointiness +
                    pi / 4)
      ];

      List pD = [
        p1[0] +
            petalRadius *
                cos(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 1.5 -
                    currentPetalPointiness -
                    pi / 4),
        p1[1] +
            petalRadius *
                sin(angle +
                    currentPetalRotation +
                    angle * currentPetalRotationRatio +
                    pi * 1.5 -
                    currentPetalPointiness -
                    pi / 4)
      ];

      Path square = Path();
      square.moveTo(pA[0], pA[1]);
      square.lineTo(pB[0], pB[1]);
      square.lineTo(pC[0], pC[1]);
      square.lineTo(pD[0], pD[1]);
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

    // case 'petal': //'petal':
    //
    //   List p1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
    //   var petalRadius = radius * currentPetalToRadius;
    //
    //   List pA = [
    //     p1[0] +
    //         petalRadius *
    //             cos(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 0.0),
    //     p1[1] +
    //         petalRadius *
    //             sin(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 0.0)
    //   ];
    //
    //   List pB = [
    //     p1[0] +
    //         petalRadius *
    //             currentPetalPointiness *
    //             cos(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 0.5),
    //     p1[1] +
    //         petalRadius *
    //             currentPetalPointiness *
    //             sin(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 0.5)
    //   ];
    //
    //   List pC = [
    //     p1[0] +
    //         petalRadius *
    //             cos(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 1.0),
    //     p1[1] +
    //         petalRadius *
    //             sin(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 1.0)
    //   ];
    //
    //   List pD = [
    //     p1[0] +
    //         petalRadius *
    //             currentPetalPointiness *
    //             cos(angle +
    //                 currentPetalRotation +
    //                 angle * currentPetalRotationRatio +
    //                 pi * 1.5),
    //     p1[1] +
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
    //   petal.moveTo(pA[0], pA[1]);
    //   petal.quadraticBezierTo(pB[0], pB[1], pC[0], pC[1]);
    //   petal.quadraticBezierTo(pD[0], pD[1], pA[0], pA[1]);
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


