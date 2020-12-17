import 'package:flutter/material.dart';
import 'package:opart_v2/opart_icons.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';
import '../main.dart';

List<String> list = List();


SettingsModel zoomOpArt = SettingsModel(
  name: 'zoomOpArt',
  settingType: SettingType.double,
  label: 'Radius',
  tooltip: 'The radius of the shapes',
  min: 20.0,
  max: 500.0,
  zoom: 100,
  defaultValue: 100.0,
  icon: Icon(Icons.zoom_in),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel shape = SettingsModel(
  name: 'shape',
  settingType: SettingType.list,
  label: "Shape",
  tooltip: "The shape in the cell",
  defaultValue: "squaricle",
  icon: Icon(Icons.settings),
  options: ['circle', 'square', 'squaricle', 'polygon'],
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel step = SettingsModel(
  name: 'step',
  settingType: SettingType.double,
  label: 'Step',
  tooltip: 'The decrease ratio of concentric shapes',
  min: 0.05,
  max: 1.0,
  zoom: 100,
  defaultValue: 0.3,
  icon: Icon(Icons.control_point),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel ratio = SettingsModel(
  name: 'ratio',
  settingType: SettingType.double,
  label: 'Ratio',
  tooltip: 'The ratio of the shape to the box',
  min: 0.75,
  max: 1.75,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(OpArtLab.wallpaper_ratio),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel driftX = SettingsModel( 
  name: 'driftX',
  settingType: SettingType.double,
  label: 'Horizontal Drift',
  tooltip: 'The drift in the horizontal axis',
  min: -5.0,
  max: 5.0,
  randomMin: -2.0,
  randomMax: 2.0,
  zoom: 100,
  defaultValue: 0.0,
  icon: Icon(OpArtLab.horizontal_drift),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel driftY = SettingsModel(
  name: 'driftY',
  settingType: SettingType.double,
  label: 'Vertical Drift',
  tooltip: 'The drift in the vertical axis',
  min: -5.0,
  max: 5.0,
  randomMin: -2.0,
  randomMax: 2.0,
  zoom: 100,
  defaultValue: 0.0,
  icon: Icon(OpArtLab.vertical_drift),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel alternateDrift = SettingsModel(
  name: 'alternateDrift',
  settingType: SettingType.bool,
  label: 'Alternate Drift',
  tooltip: 'Alternate the drift',
  defaultValue: true,
  icon: Icon(Icons.gamepad),
  proFeature: false,
  silent: true,
);

SettingsModel box = SettingsModel(
  name: 'box',
  settingType: SettingType.bool,
  label: 'Box',
  tooltip: 'Fill in the box',
  defaultValue: true,
  icon: Icon(Icons.check_box_outline_blank),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
);

SettingsModel offsetX = SettingsModel(
  name: 'offsetX',
  settingType: SettingType.double,
  label: 'Horizontal Offset',
  tooltip: 'The offset in the horizontal axis',
  min: -2.0,
  max: 2.0,
  zoom: 100,
  defaultValue: 0.0,
  icon: Icon(OpArtLab.horizontal_offset),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel offsetY = SettingsModel(
  name: 'offsetY',
  settingType: SettingType.double,
  label: 'Vertical Offset',
  tooltip: 'The offset in the vertical axis',
  min: -2.0,
  max: 2.0,
  zoom: 100,
  defaultValue: 0.0,
  icon: Icon(OpArtLab.vertical_offset),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel rotate = SettingsModel(
  name: 'rotate',
  settingType: SettingType.double,
  label: 'Rotate',
  tooltip: 'The shape rotation',
  min: 0.0,
  max: pi,
  zoom: 200,
  defaultValue: 0.0,
  icon: Icon(Icons.rotate_right),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel rotateStep = SettingsModel(
  name: 'rotateStep',
  settingType: SettingType.double,
  label: 'Rotate Step',
  tooltip: 'The rate of increase of the rotation',
  min: 0.0,
  max: 2.0,
  zoom: 100,
  defaultValue: 0.0,
  icon: Icon(Icons.screen_rotation),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel randomRotation = SettingsModel(
  name: 'randomRotation',
  settingType: SettingType.bool,
  label: 'Random Rotate',
  tooltip: 'The random shape rotation',
  defaultValue: false,
  icon: Icon(Icons.crop_rotate),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
);

SettingsModel squareness = SettingsModel(
  name: 'squareness',
  settingType: SettingType.double,
  label: 'Squareness',
  tooltip: 'The squareness of the shape',
  min: -3.0,
  max: 1.0,
  randomMin: -1.5,
  randomMax: 1.0,
  zoom: 100,
  defaultValue: 0.5,
  icon: Icon(Icons.center_focus_weak),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel squeezeX = SettingsModel(
  name: 'squeezeX',
  settingType: SettingType.double,
  label: 'Horizontal Squeeze',
  tooltip: 'The squeeze in the horizontal axis',
  min: 0.5,
  max: 1.5,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.more_horiz),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel squeezeY = SettingsModel(
  name: 'squeezeY',
  settingType: SettingType.double,
  label: 'Vertical Squeeze',
  tooltip: 'The squeeze in the vertical axis',
  min: 0.5,
  max: 1.5,
  zoom: 100,
  defaultValue: 1.0,
  icon: Icon(Icons.more_vert),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel numberOfSides = SettingsModel(
  name: 'numberOfSides',
  settingType: SettingType.int,
  label: 'Number Of Sides',
  tooltip: 'The number of sides of the polygon',
  min: 1,
  max: 15,
  defaultValue: 6,
  icon: Icon(Icons.star),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel randomPetals = SettingsModel(
  name: 'randomPetals',
  settingType: SettingType.bool,
  label: 'Random Petals',
  tooltip: 'Random Petals',
  defaultValue: true,
  icon: Icon(Icons.stars),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
);

SettingsModel lineWidth = SettingsModel(
  name: 'lineWidth',
  settingType: SettingType.double,
  label: 'Outline Width',
  tooltip: 'The width of the outline',
  min: 0.0,
  max: 10.0,
  zoom: 100,
  defaultValue: 0.1,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

// SettingsModel randomColors = SettingsModel(
//   name: 'randomColors',
//   settingType: SettingType.bool,
//   label: 'Random Colors',
//   tooltip: 'randomize the colours',
//   defaultValue: true,
//   icon: Icon(Icons.gamepad),
//   settingCategory: SettingCategory.tool,
//   proFeature: false,
//   silent: true,
// );

SettingsModel resetColors = SettingsModel(
  name: 'resetColors',
  settingType: SettingType.bool,
  label: 'Reset Colors',
  tooltip: 'Reset the colours for each cell',
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

List<SettingsModel> initializeWallpaperAttributes() {

  return [
    zoomOpArt,
    shape,

    step,
    ratio,

    offsetX,
    offsetY,

    driftX,
    driftY,
    alternateDrift,
    box,
    rotate,
    rotateStep,
    randomRotation,
    squareness,
    squeezeX,
    squeezeY,
    numberOfSides,
    randomPetals,

    backgroundColor,
    lineColor,
    lineWidth,
    randomColors,
    numberOfColors,
    resetColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}


void paintWallpaper(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;
  double borderX = 0;
  double borderY = 0;

  // colour in the canvas
  canvas.drawRect(
      Offset(borderX, borderY) & Size(canvasWidth, canvasHeight),
      Paint()
        ..color = backgroundColor.value
        ..style = PaintingStyle.fill);

  // Work out the X and Y
  int cellsX = (canvasWidth / (zoomOpArt.value * squeezeX.value)+1.9999999).toInt();
  borderX = (canvasWidth - zoomOpArt.value * squeezeX.value * cellsX) / 2;

  int cellsY = (canvasHeight / (zoomOpArt.value * squeezeY.value)+1.9999999).toInt();
  borderY = (canvasHeight - zoomOpArt.value * squeezeY.value * cellsY) / 2;

  int colourOrder = 0;

  // Now make some art

  // fill
  bool fill = true;

  int extraCellsX = 0;
  int extraCellsY = 0;
  if (fill) {
    extraCellsX = (cellsX * 2 ~/ squeezeX.value);
    extraCellsY = (cellsY * 2 ~/ squeezeY.value);
  }

  // work out the radius from the width and the cells
  double radius = zoomOpArt.value / 2;

  // double localSquareness = sin(2500 * animationVariable);
  double localSquareness = squareness.value;

  for (int j = 0 - extraCellsY;
  j < cellsY + extraCellsY;
  j++) {
    for (int i = 0 - extraCellsX;
    i < cellsX + extraCellsX;
    i++) {
      int k = 0; // count the steps

      double dX = 0;
      double dY = 0;

      double stepRadius = (radius - lineWidth.value/2) * ratio.value;
      double localStep = step.value * radius;

      double localRotate = rotate.value;
      if (randomRotation.value) {
        localRotate = rnd.nextDouble() * rotate.value;
      }
      if (alternateDrift.value && (i + j) % 2 == 0) {
        localRotate = 0 - localRotate;
      }

      // Number of petals
      var localNumberOfPetals = numberOfSides.value;
      if (randomPetals.value) {
        localNumberOfPetals =
            rnd.nextInt(numberOfSides.value) + 3;
      }

      // Centre of the square
      List pO = [
        borderX +
            radius * (1 - squeezeX.value) +
            dX +
            (radius * offsetX.value * j) +
            (i * 2 + 1) * radius * squeezeX.value,
        borderY +
            radius * (1 - squeezeY.value) +
            dY +
            (radius * offsetY.value * i) +
            (j * 2 + 1) * radius * squeezeY.value
      ];

      // reset the colours
      Color nextColor;
      if (resetColors.value) {
        colourOrder = 0;
      }

      if (box.value) {

        List pA = [
          pO[0] + radius * sqrt(2) * cos(pi * (5 / 4 + localRotate)),
          pO[1] + radius * sqrt(2) * sin(pi * (5 / 4 + localRotate))
        ];
        List pB = [
          pO[0] + radius * sqrt(2) * cos(pi * (7 / 4 + localRotate)),
          pO[1] + radius * sqrt(2) * sin(pi * (7 / 4 + localRotate))
        ];
        List pC = [
          pO[0] + radius * sqrt(2) * cos(pi * (1 / 4 + localRotate)),
          pO[1] + radius * sqrt(2) * sin(pi * (1 / 4 + localRotate))
        ];
        List pD = [
          pO[0] + radius * sqrt(2) * cos(pi * (3 / 4 + localRotate)),
          pO[1] + radius * sqrt(2) * sin(pi * (3 / 4 + localRotate))
        ];

        // Choose the next colour
        colourOrder++;
        nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
        if (randomColors.value) {
          nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
        }

        // fill the square
        Path path = Path();
        path.moveTo(pA[0], pA[1]);
        path.lineTo(pB[0], pB[1]);
        path.lineTo(pC[0], pC[1]);
        path.lineTo(pD[0], pD[1]);
        path.close();

        canvas.drawPath(
            path,
            Paint()
              ..style = PaintingStyle.fill
              ..color =
              nextColor.withOpacity(opacity.value));

        // if (lineWidth > 0) {
        //   canvas.drawPath(path, Paint() ..style = PaintingStyle.stroke ..strokeWidth = lineWidth ..color = lineColor);
        // }

      }

      do {
        // drift...
        pO = [pO[0] + dX, pO[1] + dY];

        switch (shape.value) {

          case 'circle':

          // Choose the next colour
            colourOrder++;
            nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
            if (randomColors.value) {
              nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
            }

            canvas.drawCircle(
                Offset(pO[0], pO[1]),
                stepRadius,
                Paint()
                  ..style = PaintingStyle.fill
                  ..color =
                  nextColor.withOpacity(opacity.value));
            canvas.drawCircle(
                Offset(pO[0], pO[1]),
                stepRadius,
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = lineWidth.value
                  ..color = lineColor.value
                      .withOpacity(opacity.value));

            break;

          case 'square':

            Path square = Path();

            square.moveTo(
                pO[0] + stepRadius * sqrt(2) * cos(pi * (1 / 4 + localRotate)),
                pO[1] + stepRadius * sqrt(2) * sin(pi * (1 / 4 + localRotate))
            );

            square.lineTo(
                pO[0] + stepRadius * sqrt(2) * cos(pi * (3 / 4 + localRotate)),
                pO[1] + stepRadius * sqrt(2) * sin(pi * (3 / 4 + localRotate))
            );

            square.lineTo(
                pO[0] + stepRadius * sqrt(2) * cos(pi * (5 / 4 + localRotate)),
                pO[1] + stepRadius * sqrt(2) * sin(pi * (5 / 4 + localRotate))
            );

            square.lineTo(
                pO[0] + stepRadius * sqrt(2) * cos(pi * (7 / 4 + localRotate)),
                pO[1] + stepRadius * sqrt(2) * sin(pi * (7 / 4 + localRotate))
            );

            square.close();

            // Choose the next colour
            colourOrder++;
            nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
            if (randomColors.value) {
              nextColor = opArt.palette.colorList[
              rnd.nextInt(numberOfColors.value)];
            }

            canvas.drawPath(
                square,
                Paint()
                  ..style = PaintingStyle.fill
                  ..color =
                  nextColor.withOpacity(opacity.value));
            canvas.drawPath(
                square,
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = lineWidth.value
                  ..color = lineColor.value
                      .withOpacity(opacity.value));

            square.reset();

            break;

          case 'squaricle':

            double curveCentreRadius = stepRadius * sqrt(2) * squareness.value;
            double curveRadius = stepRadius * sqrt(2) * (1 - squareness.value);

            Path squaricle = Path();

            squaricle.arcTo(Rect.fromCenter(
                center: Offset(
                    pO[0] + curveCentreRadius * cos(pi * (1 / 4 + localRotate)),
                    pO[1] + curveCentreRadius * sin(pi * (1 / 4 + localRotate))
                ),
                height: curveRadius,
                width: curveRadius),
                pi * (0 / 2 + localRotate),
                pi/2,
                false
            );

            squaricle.arcTo(Rect.fromCenter(
                center: Offset(
                    pO[0] + curveCentreRadius * cos(pi * (3 / 4 + localRotate)),
                    pO[1] + curveCentreRadius * sin(pi * (3 / 4 + localRotate))
                ),
                height: curveRadius,
                width: curveRadius),
                pi * (1 / 2 + localRotate),
                pi/2,
                false
            );

            squaricle.arcTo(Rect.fromCenter(
                center: Offset(
                    pO[0] + curveCentreRadius * cos(pi * (5 / 4 + localRotate)),
                    pO[1] + curveCentreRadius * sin(pi * (5 / 4 + localRotate))
                ),
                height: curveRadius,
                width: curveRadius),
                pi * (2 / 2 + localRotate),
                pi/2,
                false
            );

            squaricle.arcTo(Rect.fromCenter(
                center: Offset(
                    pO[0] + curveCentreRadius * cos(pi * (7 / 4 + localRotate)),
                    pO[1] + curveCentreRadius * sin(pi * (7 / 4 + localRotate))
                ),
                height: curveRadius,
                width: curveRadius),
                pi * (3 / 2 + localRotate),
                pi/2,
                false
            );

            squaricle.close();

            // Choose the next colour
            colourOrder++;
            nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
            if (randomColors.value) {
              nextColor = opArt.palette.colorList[
              rnd.nextInt(numberOfColors.value)];
            }

            canvas.drawPath(
                squaricle,
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = lineWidth.value
                  ..color = lineColor.value
                      .withOpacity(opacity.value));
            canvas.drawPath(
                squaricle,
                Paint()
                  ..style = PaintingStyle.fill
                  ..color =
                  nextColor.withOpacity(opacity.value));

            squaricle.reset();

            break;

          case 'star':
            for (var p = 0; p < localNumberOfPetals; p++) {
              List petalPoint = [
                pO[0] +
                    stepRadius *
                        cos(localRotate * pi +
                            p * pi * 2 / localNumberOfPetals),
                pO[1] +
                    stepRadius *
                        sin(localRotate * pi +
                            p * pi * 2 / localNumberOfPetals)
              ];

              List petalMidPointA = [
                pO[0] +
                    (localSquareness) *
                        stepRadius *
                        cos(localRotate * pi +
                            (p - 1) * pi * 2 / localNumberOfPetals),
                pO[1] +
                    (localSquareness) *
                        stepRadius *
                        sin(localRotate * pi +
                            (p - 1) * pi * 2 / localNumberOfPetals)
              ];

              List petalMidPointP = [
                pO[0] +
                    (localSquareness) *
                        stepRadius *
                        cos(localRotate * pi +
                            (p + 1) * pi * 2 / localNumberOfPetals),
                pO[1] +
                    (localSquareness) *
                        stepRadius *
                        sin(localRotate * pi +
                            (p + 1) * pi * 2 / localNumberOfPetals)
              ];

              Path star = Path();

              star.moveTo(pO[0], pO[1]);
              star.quadraticBezierTo(petalMidPointA[0], petalMidPointA[1],
                  petalPoint[0], petalPoint[1]);
              star.quadraticBezierTo(
                  petalMidPointP[0], petalMidPointP[1], pO[0], pO[1]);
              star.close();

              // Choose the next colour
              colourOrder++;
              nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
              if (randomColors.value) {
                nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
              }

              canvas.drawPath(
                  star,
                  Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = lineWidth.value
                    ..color = lineColor.value
                        .withOpacity(opacity.value));
              canvas.drawPath(
                  star,
                  Paint()
                    ..style = PaintingStyle.fill
                    ..color = nextColor
                        .withOpacity(opacity.value));
            }

            break;

          case 'polygon':

            Path polygon = Path();

            polygon.moveTo(
                pO[0]+ stepRadius * cos(localRotate),
                pO[1]+ stepRadius * sin(localRotate));

            for (int s = 1; s<numberOfSides.value;s++){
              polygon.lineTo(
                  pO[0]+ stepRadius * cos(pi*2*s/numberOfSides.value + localRotate),
                  pO[1]+ stepRadius * sin(pi*2*s/numberOfSides.value + localRotate));
            }

            polygon.close();

            // Choose the next colour
            colourOrder++;
            nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
            if (randomColors.value) {
              nextColor = opArt.palette.colorList[
              rnd.nextInt(numberOfColors.value)];
            }

            canvas.drawPath(
                polygon,
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = lineWidth.value
                  ..color = lineColor.value
                      .withOpacity(opacity.value));
            canvas.drawPath(
                polygon,
                Paint()
                  ..style = PaintingStyle.fill
                  ..color =
                  nextColor.withOpacity(opacity.value));


            polygon.reset();


            break;

          case 'star':
            for (var p = 0; p < localNumberOfPetals; p++) {
              List petalPoint = [
                pO[0] +
                    stepRadius *
                        cos(localRotate * pi +
                            p * pi * 2 / localNumberOfPetals),
                pO[1] +
                    stepRadius *
                        sin(localRotate * pi +
                            p * pi * 2 / localNumberOfPetals)
              ];

              List petalMidPointA = [
                pO[0] +
                    (localSquareness) *
                        stepRadius *
                        cos(localRotate * pi +
                            (p - 1) * pi * 2 / localNumberOfPetals),
                pO[1] +
                    (localSquareness) *
                        stepRadius *
                        sin(localRotate * pi +
                            (p - 1) * pi * 2 / localNumberOfPetals)
              ];

              List petalMidPointP = [
                pO[0] +
                    (localSquareness) *
                        stepRadius *
                        cos(localRotate * pi +
                            (p + 1) * pi * 2 / localNumberOfPetals),
                pO[1] +
                    (localSquareness) *
                        stepRadius *
                        sin(localRotate * pi +
                            (p + 1) * pi * 2 / localNumberOfPetals)
              ];

              Path star = Path();

              star.moveTo(pO[0], pO[1]);
              star.quadraticBezierTo(petalMidPointA[0], petalMidPointA[1],
                  petalPoint[0], petalPoint[1]);
              star.quadraticBezierTo(
                  petalMidPointP[0], petalMidPointP[1], pO[0], pO[1]);
              star.close();

              // Choose the next colour
              colourOrder++;
              nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
              if (randomColors.value) {
                nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
              }

              canvas.drawPath(
                  star,
                  Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = lineWidth.value
                    ..color = lineColor.value
                        .withOpacity(opacity.value));
              canvas.drawPath(
                  star,
                  Paint()
                    ..style = PaintingStyle.fill
                    ..color = nextColor
                        .withOpacity(opacity.value));
            }

            break;

          case 'daisy': // daisy
            double centreRatio = 0.3;
            double centreRadius = stepRadius * centreRatio;

            // Choose the next colour
            colourOrder++;
            nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
            if (randomColors.value) {
              nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
            }

            canvas.drawCircle(
                Offset(pO[0], pO[1]),
                centreRadius,
                Paint()
                  ..style = PaintingStyle.fill
                  ..color =
                  nextColor.withOpacity(opacity.value));
            canvas.drawCircle(
                Offset(pO[0], pO[1]),
                centreRadius,
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = lineWidth.value
                  ..color = lineColor.value
                      .withOpacity(opacity.value));

            for (var petal = 0; petal < localNumberOfPetals; petal++) {
              // Choose the next colour
              colourOrder++;
              nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
              if (randomColors.value) {
                nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
              }

              var petalAngle =
                  localRotate + petal * 2 * pi / localNumberOfPetals;

              var petalCentreRadius =
                  stepRadius * (centreRatio + (1 - centreRatio) / 2);
              var petalRadius = stepRadius * ((1 - centreRatio) / 2);

              // pC = Petal centre
              List pC = [
                pO[0] + petalCentreRadius * cos(petalAngle),
                pO[1] + petalCentreRadius * sin(petalAngle),
              ];

              List pN = [
                pC[0] - petalRadius * cos(petalAngle),
                pC[1] - petalRadius * sin(petalAngle)
              ];

              List pS = [
                pC[0] - petalRadius * cos(petalAngle + pi),
                pC[1] - petalRadius * sin(petalAngle + pi)
              ];

              List pE = [
                pC[0] -
                    localSquareness *
                        petalRadius *
                        cos(petalAngle + pi * 0.5),
                pC[1] -
                    localSquareness *
                        petalRadius *
                        sin(petalAngle + pi * 0.5)
              ];

              List pW = [
                pC[0] -
                    localSquareness *
                        petalRadius *
                        cos(petalAngle + pi * 1.5),
                pC[1] -
                    localSquareness *
                        petalRadius *
                        sin(petalAngle + pi * 1.5)
              ];

              Path path = Path();
              path.moveTo(pN[0], pN[1]);
              path.quadraticBezierTo(pE[0], pE[1], pS[0], pS[1]);
              path.quadraticBezierTo(pW[0], pW[1], pN[0], pN[1]);
              path.close();

              canvas.drawPath(
                  path,
                  Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = lineWidth.value
                    ..color = lineColor.value
                        .withOpacity(opacity.value));
              canvas.drawPath(
                  path,
                  Paint()
                    ..style = PaintingStyle.fill
                    ..color = nextColor
                        .withOpacity(opacity.value));
            }

            break;
        }

        // Drift & Rotate

        if (alternateDrift.value && (i + j) % 2 == 0) {
          localRotate = localRotate - rotateStep.value;
        } else {
          localRotate = localRotate + rotateStep.value;
        }

        if (alternateDrift.value && (i) % 2 == 0) {
          dX = dX - driftX.value;
        } else {
          dX = dX + driftX.value;
        }
        if (alternateDrift.value && (j) % 2 == 0) {
          dY = dY -
              driftY.value;
        } else {
          dY = dY + driftY.value;
        }

        stepRadius = stepRadius - localStep;
        k++;
      } while (k < 40 && stepRadius > 0 && step.value > 0);
    }
  }

}


