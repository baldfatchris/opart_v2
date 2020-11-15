import 'package:flutter/material.dart';
import 'package:opart_v2/opart_icons.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';

List<String> list = List();


SettingsModel zoomWallpaper = SettingsModel(
  name: 'zoomWallpaper',
  settingType: SettingType.double,
  label: 'Zoom',
  tooltip: 'Zoom in and out',
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
SettingsModel stepStep = SettingsModel(
  name: 'stepStep',
  settingType: SettingType.double,
  label: 'Step Ratio',
  tooltip: 'The ratio of change of the ratio',
  min: 0.5,
  max: 1.0,
  zoom: 100,
  defaultValue: 0.9,
  icon: Icon(Icons.control_point_duplicate),
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
SettingsModel driftXStep = SettingsModel(
  name: 'driftXStep',
  settingType: SettingType.double,
  label: 'Horizontal Step',
  tooltip: 'The acceleration of the drift in the horizontal axis',
  min: -2.0,
  max: 2.0,
  randomMin: -0.5,
  randomMax: -0.5,
  zoom: 100,
  defaultValue: 0.0,
  icon: Icon(Icons.screen_lock_landscape),
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
SettingsModel driftYStep = SettingsModel(
  name: 'driftYStep',
  settingType: SettingType.double,
  label: 'Vertical Step',
  tooltip: 'The acceleration of the drift in the vertical axis',
  min: -2.0,
  max: 2.0,
  randomMin: -0.5,
  randomMax: 0.5,
  zoom: 100,
  defaultValue: 0.0,
  icon: Icon(Icons.screen_lock_portrait),
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
SettingsModel lineColor = SettingsModel(
  settingType: SettingType.color,
  name: 'lineColor',
  label: "Outline Color",
  tooltip: "The outline colour",
  defaultValue: Colors.black,
  icon: Icon(Icons.settings_overscan),
  settingCategory: SettingCategory.palette,
  proFeature: false,
);
SettingsModel lineWidth = SettingsModel(
  name: 'lineWidth',
  settingType: SettingType.double,
  label: 'Outline Width',
  tooltip: 'The width of the outline',
  min: 0.0,
  max: 1.0,
  zoom: 100,
  defaultValue: 0.1,
  icon: Icon(Icons.line_weight),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);
SettingsModel randomColors = SettingsModel(
  name: 'randomColors',
  settingType: SettingType.bool,
  label: 'Random Colors',
  tooltip: 'randomize the colours',
  defaultValue: true,
  icon: Icon(Icons.gamepad),
  settingCategory: SettingCategory.palette,
  proFeature: false,
  silent: true,
);
SettingsModel resetColors = SettingsModel(
  name: 'resetColors',
  settingType: SettingType.bool,
  label: 'Reset Colors',
  tooltip: 'Reset the colours for each cell',
  defaultValue: false,
  icon: Icon(Icons.gamepad),
  settingCategory: SettingCategory.palette,
  proFeature: false,
  silent: true,
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
  settingCategory: SettingCategory.other,
  onChange: (){checkNumberOfColors();},
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
SettingsModel opacity = SettingsModel(
  name: 'opacity',
  settingType: SettingType.double,
  label: 'Opactity',
  tooltip: 'The opacity of the shape',
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
  onChange: (){resetAllDefaults();},
  proFeature: false,
  silent: true,
);

double aspectRatio = pi/2;

List<SettingsModel> initializeWallpaperAttributes() {

  return [
    zoomWallpaper,
    shape,

    step,
    stepStep,
    ratio,

    offsetX,
    offsetY,

    driftX,
    driftXStep,
    driftY,
    driftYStep,
    alternateDrift,
    box,
    rotate,
    randomRotation,
    rotateStep,
    squareness,
    squeezeX,
    squeezeY,
    numberOfSides,
    randomPetals,

    backgroundColor,
    lineColor,
    lineWidth,
    randomColors,
    resetColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}


void paintWallpaper(Canvas canvas, Size size, Random rnd, double animationVariable, OpArt opArt) {

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
  int cellsX = (canvasWidth / (zoomWallpaper.value * squeezeX.value)+1.9999999).toInt();
  borderX = (canvasWidth - zoomWallpaper.value * squeezeX.value * cellsX) / 2;

  int cellsY = (canvasHeight / (zoomWallpaper.value * squeezeY.value)+1.9999999).toInt();
  borderY = (canvasHeight - zoomWallpaper.value * squeezeY.value * cellsY) / 2;

  int colourOrder = 0;

  // Now make some art

  // fill
  bool fill = true;

  int extraCellsX = 0;
  int extraCellsY = 0;
  if (fill) {
    extraCellsX = (cellsX * 2 / squeezeX.value).toInt();
    extraCellsY = (cellsY * 2 / squeezeY.value).toInt();
  }

  // work out the radius from the width and the cells
  double radius = zoomWallpaper.value / 2;

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

      double stepRadius = radius * ratio.value;
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
      List PO = [
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

      List PA = [
        PO[0] + stepRadius * sqrt(2) * cos(pi * (5 / 4 + localRotate)),
        PO[1] + stepRadius * sqrt(2) * sin(pi * (5 / 4 + localRotate))
      ];
      List PB = [
        PO[0] + stepRadius * sqrt(2) * cos(pi * (7 / 4 + localRotate)),
        PO[1] + stepRadius * sqrt(2) * sin(pi * (7 / 4 + localRotate))
      ];
      List PC = [
        PO[0] + stepRadius * sqrt(2) * cos(pi * (1 / 4 + localRotate)),
        PO[1] + stepRadius * sqrt(2) * sin(pi * (1 / 4 + localRotate))
      ];
      List PD = [
        PO[0] + stepRadius * sqrt(2) * cos(pi * (3 / 4 + localRotate)),
        PO[1] + stepRadius * sqrt(2) * sin(pi * (3 / 4 + localRotate))
      ];

      // reset the colours
      Color nextColor;
      if (resetColors.value) {
        colourOrder = 0;
      }

      if (box.value) {
        // Choose the next colour
        colourOrder++;
        nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
        if (randomColors.value) {
          nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
        }

        // fill the square
        Path path = Path();
        path.moveTo(PA[0], PA[1]);
        path.lineTo(PB[0], PB[1]);
        path.lineTo(PC[0], PC[1]);
        path.lineTo(PD[0], PD[1]);
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
        PO = [PO[0] + dX, PO[1] + dY];

        switch (shape.value) {

          case 'circle':

          // Choose the next colour
            colourOrder++;
            nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
            if (randomColors.value) {
              nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
            }

            canvas.drawCircle(
                Offset(PO[0], PO[1]),
                stepRadius,
                Paint()
                  ..style = PaintingStyle.fill
                  ..color =
                  nextColor.withOpacity(opacity.value));
            canvas.drawCircle(
                Offset(PO[0], PO[1]),
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
                PO[0] + stepRadius * sqrt(2) * cos(pi * (1 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (1 / 4 + localRotate))
            );

            square.lineTo(
                PO[0] + stepRadius * sqrt(2) * cos(pi * (3 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (3 / 4 + localRotate))
            );

            square.lineTo(
                PO[0] + stepRadius * sqrt(2) * cos(pi * (5 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (5 / 4 + localRotate))
            );

            square.lineTo(
                PO[0] + stepRadius * sqrt(2) * cos(pi * (7 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (7 / 4 + localRotate))
            );

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
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = lineWidth.value
                  ..color = lineColor.value
                      .withOpacity(opacity.value));
            canvas.drawPath(
                square,
                Paint()
                  ..style = PaintingStyle.fill
                  ..color =
                  nextColor.withOpacity(opacity.value));

            square.reset();

            break;

          case 'squaricle':

            double curveCentreRadius = stepRadius * sqrt(2) * squareness.value;
            double curveRadius = stepRadius * sqrt(2) * (1 - squareness.value);

            Path squaricle = Path();

            squaricle.arcTo(Rect.fromCenter(
                center: Offset(
                    PO[0] + curveCentreRadius * cos(pi * (1 / 4 + localRotate)),
                    PO[1] + curveCentreRadius * sin(pi * (1 / 4 + localRotate))
                ),
                height: curveRadius,
                width: curveRadius),
                pi * (0 / 2 + localRotate),
                pi/2,
                false
            );

            squaricle.arcTo(Rect.fromCenter(
                center: Offset(
                    PO[0] + curveCentreRadius * cos(pi * (3 / 4 + localRotate)),
                    PO[1] + curveCentreRadius * sin(pi * (3 / 4 + localRotate))
                ),
                height: curveRadius,
                width: curveRadius),
                pi * (1 / 2 + localRotate),
                pi/2,
                false
            );

            squaricle.arcTo(Rect.fromCenter(
                center: Offset(
                    PO[0] + curveCentreRadius * cos(pi * (5 / 4 + localRotate)),
                    PO[1] + curveCentreRadius * sin(pi * (5 / 4 + localRotate))
                ),
                height: curveRadius,
                width: curveRadius),
                pi * (2 / 2 + localRotate),
                pi/2,
                false
            );

            squaricle.arcTo(Rect.fromCenter(
                center: Offset(
                    PO[0] + curveCentreRadius * cos(pi * (7 / 4 + localRotate)),
                    PO[1] + curveCentreRadius * sin(pi * (7 / 4 + localRotate))
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
                PO[0] +
                    stepRadius *
                        cos(localRotate * pi +
                            p * pi * 2 / localNumberOfPetals),
                PO[1] +
                    stepRadius *
                        sin(localRotate * pi +
                            p * pi * 2 / localNumberOfPetals)
              ];

              List petalMidPointA = [
                PO[0] +
                    (localSquareness) *
                        stepRadius *
                        cos(localRotate * pi +
                            (p - 1) * pi * 2 / localNumberOfPetals),
                PO[1] +
                    (localSquareness) *
                        stepRadius *
                        sin(localRotate * pi +
                            (p - 1) * pi * 2 / localNumberOfPetals)
              ];

              List petalMidPointP = [
                PO[0] +
                    (localSquareness) *
                        stepRadius *
                        cos(localRotate * pi +
                            (p + 1) * pi * 2 / localNumberOfPetals),
                PO[1] +
                    (localSquareness) *
                        stepRadius *
                        sin(localRotate * pi +
                            (p + 1) * pi * 2 / localNumberOfPetals)
              ];

              Path star = Path();

              star.moveTo(PO[0], PO[1]);
              star.quadraticBezierTo(petalMidPointA[0], petalMidPointA[1],
                  petalPoint[0], petalPoint[1]);
              star.quadraticBezierTo(
                  petalMidPointP[0], petalMidPointP[1], PO[0], PO[1]);
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
                PO[0]+ stepRadius * cos(localRotate),
                PO[1]+ stepRadius * sin(localRotate));

            for (int s = 1; s<numberOfSides.value;s++){
              polygon.lineTo(
                  PO[0]+ stepRadius * cos(pi*2*s/numberOfSides.value + localRotate),
                  PO[1]+ stepRadius * sin(pi*2*s/numberOfSides.value + localRotate));
            }

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
                PO[0] +
                    stepRadius *
                        cos(localRotate * pi +
                            p * pi * 2 / localNumberOfPetals),
                PO[1] +
                    stepRadius *
                        sin(localRotate * pi +
                            p * pi * 2 / localNumberOfPetals)
              ];

              List petalMidPointA = [
                PO[0] +
                    (localSquareness) *
                        stepRadius *
                        cos(localRotate * pi +
                            (p - 1) * pi * 2 / localNumberOfPetals),
                PO[1] +
                    (localSquareness) *
                        stepRadius *
                        sin(localRotate * pi +
                            (p - 1) * pi * 2 / localNumberOfPetals)
              ];

              List petalMidPointP = [
                PO[0] +
                    (localSquareness) *
                        stepRadius *
                        cos(localRotate * pi +
                            (p + 1) * pi * 2 / localNumberOfPetals),
                PO[1] +
                    (localSquareness) *
                        stepRadius *
                        sin(localRotate * pi +
                            (p + 1) * pi * 2 / localNumberOfPetals)
              ];

              Path star = Path();

              star.moveTo(PO[0], PO[1]);
              star.quadraticBezierTo(petalMidPointA[0], petalMidPointA[1],
                  petalPoint[0], petalPoint[1]);
              star.quadraticBezierTo(
                  petalMidPointP[0], petalMidPointP[1], PO[0], PO[1]);
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
                Offset(PO[0], PO[1]),
                centreRadius,
                Paint()
                  ..style = PaintingStyle.fill
                  ..color =
                  nextColor.withOpacity(opacity.value));
            canvas.drawCircle(
                Offset(PO[0], PO[1]),
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

              // PC = Petal centre
              List PC = [
                PO[0] + petalCentreRadius * cos(petalAngle),
                PO[1] + petalCentreRadius * sin(petalAngle),
              ];

              List PN = [
                PC[0] - petalRadius * cos(petalAngle),
                PC[1] - petalRadius * sin(petalAngle)
              ];

              List PS = [
                PC[0] - petalRadius * cos(petalAngle + pi),
                PC[1] - petalRadius * sin(petalAngle + pi)
              ];

              List PE = [
                PC[0] -
                    localSquareness *
                        petalRadius *
                        cos(petalAngle + pi * 0.5),
                PC[1] -
                    localSquareness *
                        petalRadius *
                        sin(petalAngle + pi * 0.5)
              ];

              List PW = [
                PC[0] -
                    localSquareness *
                        petalRadius *
                        cos(petalAngle + pi * 1.5),
                PC[1] -
                    localSquareness *
                        petalRadius *
                        sin(petalAngle + pi * 1.5)
              ];

              Path path = Path();
              path.moveTo(PN[0], PN[1]);
              path.quadraticBezierTo(PE[0], PE[1], PS[0], PS[1]);
              path.quadraticBezierTo(PW[0], PW[1], PN[0], PN[1]);
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
          dX = dX -
              driftX.value -
              k * driftXStep.value;
        } else {
          dX = dX +
              driftX.value +
              k * driftXStep.value;
        }
        if (alternateDrift.value && (j) % 2 == 0) {
          dY = dY -
              driftY.value -
              k * driftYStep.value;
        } else {
          dY = dY +
              driftY.value +
              k * driftYStep.value;
        }

        localStep = localStep * stepStep.value;
        stepRadius = stepRadius - localStep;
        k++;
      } while (k < 40 && stepRadius > 0 && step.value > 0);
    }
  }

}


List edgePoint(List Point1, List Point2, double ratio) {
  return [
    Point1[0] * (ratio) + Point2[0] * (1 - ratio),
    Point1[1] * (ratio) + Point2[1] * (1 - ratio)
  ];
}




