import 'package:flutter/material.dart';
import 'model.dart';
import 'palette.dart';
import 'settings_model.dart';
import 'dart:math';
import 'dart:core';

List<String> list = List();


SettingsModel zoomShapes = SettingsModel(
  name: 'zoomTree',
  settingType: SettingType.double,
  label: 'Zoom',
  tooltip: 'Zoom in and out',
  min: 20.0,
  max: 500.0,
  zoom: 100,
  defaultValue: 60.0,
  icon: Icon(Icons.zoom_in),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel shapeHalfDiagonalTriangle = SettingsModel(
  name: 'shapeHalfDiagonalTriangle',
  settingType: SettingType.bool,
  label: 'Half Triangles',
  tooltip: 'Add half triangles to the shapes',
  defaultValue: true,
  icon: Icon(Icons.network_cell),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel shapeCircle = SettingsModel(
  name: 'shapeCircle',
  settingType: SettingType.bool,
  label: 'Circles',
  tooltip: 'Add circles to the shapes',
  defaultValue: true,
  icon: Icon(Icons.brightness_1),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel shapeQuarterCircle = SettingsModel(
  name: 'shapeQuarterCircle',
  settingType: SettingType.bool,
  label: 'Quarter Circles',
  tooltip: 'Add quarter circles to the shapes',
  defaultValue: true,
  icon: Icon(Icons.brightness_1),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel shapeHalfCircle = SettingsModel(
  name: 'shapeHalfCircle',
  settingType: SettingType.bool,
  label: 'Half Circles',
  tooltip: 'Add half circles to the shapes',
  defaultValue: true,
  icon: Icon(Icons.donut_large),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel shapeQuarterTriangle = SettingsModel(
  name: 'shapeQuarterTriangle',
  settingType: SettingType.bool,
  label: 'Quarter Triangles',
  tooltip: 'Add quarter triangles to the shapes',
  defaultValue: true,
  icon: Icon(Icons.network_cell),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel shapeQuarterSquare = SettingsModel(
  name: 'shapeQuarterSquare',
  settingType: SettingType.bool,
  label: 'Quarter Squares',
  tooltip: 'Add quarter squares to the shapes',
  defaultValue: true,
  icon: Icon(Icons.branding_watermark),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel shapeMiniCircle = SettingsModel(
  name: 'shapeMiniCircle',
  settingType: SettingType.bool,
  label: 'Mini Circles',
  tooltip: 'Add mini circles to the shapes',
  defaultValue: true,
  icon: Icon(Icons.filter_tilt_shift),
  settingCategory: SettingCategory.tool,
  proFeature: false,
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
);


// palette settings
SettingsModel backgroundColor = SettingsModel(
  name: 'backgroundColor',
  label: "Background Color",
  tooltip: "The background colour for the canvas",
  defaultValue: Colors.white,
  icon: Icon(Icons.settings_overscan),
  settingCategory: SettingCategory.palette,
  proFeature: false,
);
SettingsModel lineColor = SettingsModel(
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
  settingCategory: SettingCategory.palette,
  proFeature: false,
);
SettingsModel randomColors = SettingsModel(
  name: 'randomColors',
  settingType: SettingType.bool,
  label: 'Random Colors',
  tooltip: 'randomize the colours',
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
);

double aspectRatio = pi/2;

List<SettingsModel> initializeShapesAttributes() {

  return [
    zoomShapes,
    shapeHalfDiagonalTriangle,
    shapeCircle,
    shapeQuarterCircle,
    shapeHalfCircle,
    shapeQuarterTriangle,
    shapeQuarterSquare,
    shapeMiniCircle,

    box,

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


void paintShapes(Canvas canvas, Size size, Random rnd, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  // sort out the palette
  if (numberOfColors.value > opArt.palette.colorList.length){
    opArt.palette.randomize(paletteType.value, numberOfColors.value);
  }
  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }
  // reset the defaults
  if (resetDefaults.value == true) {
    opArt.setDefault();
  }

  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;
  double borderX = 0;
  double borderY = 0;
  double imageWidth = canvasWidth;
  double imageHeight = canvasHeight;

  // Work out the X and Y
  int cellsX = (canvasWidth / (zoomShapes.value)+0.9999999).toInt();
  borderX = (canvasWidth - zoomShapes.value * cellsX) / 2;

  int cellsY = (canvasHeight / (zoomShapes.value)+0.9999999).toInt();
  borderY = (canvasHeight - zoomShapes.value * cellsY) / 2;

  int colourOrder = 0;

  // Now make some art

  List shapesArray = [];
  if (shapeHalfDiagonalTriangle.value == true) { shapesArray.add('shapeHalfDiagonalTriangle'); }
  if (shapeCircle.value == true) { shapesArray.add('shapeCircle'); }
  if (shapeQuarterCircle.value == true) { shapesArray.add('shapeQuarterCircle'); }
  if (shapeHalfCircle.value == true) { shapesArray.add('shapeHalfCircle'); }
  if (shapeQuarterTriangle.value == true) { shapesArray.add('shapeQuarterTriangle'); }
  if (shapeQuarterSquare.value == true) { shapesArray.add('shapeQuarterSquare'); }
  if (shapeMiniCircle.value == true) { shapesArray.add('shapeMiniCircle'); }
  var numberOfShapes = shapesArray.length;


  // fill
  bool fill = true;

  int extraCellsX = 0;
  int extraCellsY = 0;
  if (fill) {
    extraCellsX = (cellsX * 2).toInt();
    extraCellsY = (cellsY * 2).toInt();
  }

  // work out the radius from the width and the cells
  double radius = zoomShapes.value / 2;

  print(opacity.value);

  // reset the colours
  Color nextColor;
  colourOrder = 0;


  for (int j = 0 - extraCellsY; j < cellsY + extraCellsY; j++) {
    for (int i = 0 - extraCellsX;  i < cellsX + extraCellsX; i++) {

      // Centre of the square
      List PO = [
        borderX + (i * 2 + 1) * radius,
        borderY + (j * 2 + 1) * radius
      ];

      // corners of the square
      var PA = [
        PO[0] - radius,
        PO[1] - radius
      ];
      var PB = [
        PO[0] + radius,
        PO[1] - radius
      ];
      var PC = [
        PO[0] + radius,
        PO[1] + radius
      ];
      var PD = [
        PO[0] - radius,
        PO[1] + radius
      ];


      if (box.value == true) {
        // fill the square
        Path path = Path();
        path.moveTo(PA[0], PA[1]);
        path.lineTo(PB[0], PB[1]);
        path.lineTo(PC[0], PC[1]);
        path.lineTo(PD[0], PD[1]);
        path.close();

        // Choose the next colour
        colourOrder++;
        nextColor = (randomColors.value)
            ? opArt.palette.colorList[colourOrder % numberOfColors.value]
            : opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];

        canvas.drawPath(
            path,
            Paint()
              ..style = PaintingStyle.fill
              ..color = nextColor.withOpacity(opacity.value));
      }

      // now  draw the shape
      // Choose the next colour
      colourOrder++;
      nextColor = (randomColors.value)
          ? opArt.palette.colorList[colourOrder % numberOfColors.value]
          : opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
      Paint paint = Paint()
        ..style = PaintingStyle.fill
        ..color = nextColor.withOpacity(opacity.value);

      Path shape = Path();

      // pick a random shape
      var randomShape = shapesArray[rnd.nextInt(numberOfShapes)];


      switch (randomShape) {

        case 'shapeHalfDiagonalTriangle': // half diagonal triangle

          var shapeOrientation = rnd.nextInt(4);
          switch (shapeOrientation) {
            case 0:
              shape.moveTo(PA[0], PA[1]);
              shape.lineTo(PA[0] + 2 * radius, PA[1]);
              shape.lineTo(PA[0], PA[1] + 2 * radius);
              break;

            case 1:
              shape.moveTo(PB[0] - 2 * radius, PB[1]);
              shape.lineTo(PB[0], PB[1]);
              shape.lineTo(PB[0], PB[1] + 2 * radius);
              break;

            case 2:
              shape.moveTo(PC[0], PC[1] - 2 * radius);
              shape.lineTo(PC[0], PC[1]);
              shape.lineTo(PC[0] - 2 * radius, PC[1]);
              break;

            case 3:
              shape.moveTo(PD[0], PD[1] - 2 * radius);
              shape.lineTo(PD[0] + 2 * radius, PD[1]);
              shape.lineTo(PD[0], PD[1]);
              break;

          }

          canvas.drawPath(shape, paint);

          break;

        case 'shapeCircle': // circle

          canvas.drawCircle(Offset(PO[0], PO[1]), radius, paint);

          break;

        case 'shapeQuarterCircle': // quarter circle

          switch (rnd.nextInt(4)) {
            case 0: // centre top left
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0]-radius,PO[1]-radius),
                  height: radius*4,
                  width: radius*4),
                  pi * (0.0 ), pi * 0.5, true, paint);
              break;
            case 1: // centre top right
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0]+radius,PO[1]-radius),
                  height: radius*4,
                  width: radius*4),
                  pi * (0.5 ), pi * 0.5, true, paint);
              break;
            case 2: // centre bottom right
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0]+radius,PO[1]+radius),
                  height: radius*4,
                  width: radius*4),
                  pi * (1.0 ), pi * 0.5, true, paint);
              break;
            case 3: // centre bottom left
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0]-radius,PO[1]+radius),
                  height: radius*4,
                  width: radius*4),
                  pi * (1.5 ), pi * 0.5, true, paint);
              break;
          }
          break;

        case 'shapeHalfCircle': // half circle

          switch (rnd.nextInt(4)) {
            case 0: // centre top
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0], PO[1] - radius),
                  height: radius,
                  width: radius),
                  pi * (0.0 ), pi * 1.0, true, paint);
              break;

            case 1: // centre right
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0] + radius, PO[1]),
                  height: radius,
                  width: radius),
                  pi * (0.5 ), pi * 1.0, true, paint);
              break;

            case 2: // centre bottom
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0], PO[1] + radius),
                  height: radius,
                  width: radius),
                  pi * (1.0 ), pi * 1.0, true, paint);
              break;

            case 3: // centre left
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0] - radius, PO[1]),
                  height: radius,
                  width: radius),
                  pi * (1.5 ), pi * 1.0, true, paint);
              break;
          }
          break;

        case 'shapeQuarterTriangle': // quarter triangle

          switch (rnd.nextInt(4)) {
            case 0:
              shape.moveTo(PO[0], PO[1]);
              shape.lineTo(PB[0], PB[1]);
              shape.lineTo(PC[0], PC[1]);
              break;

            case 1:
              shape.moveTo(PO[0], PO[1]);
              shape.lineTo(PC[0], PC[1]);
              shape.lineTo(PD[0], PD[1]);
              break;

            case 2:
              shape.moveTo(PO[0], PO[1]);
              shape.lineTo(PD[0], PD[1]);
              shape.lineTo(PA[0], PA[1]);
              break;

            case 3:
              shape.moveTo(PO[0], PO[1]);
              shape.lineTo(PA[0], PA[1]);
              shape.lineTo(PB[0], PB[1]);
              break;

          }

          canvas.drawPath(shape, paint);

          break;

        case 'shapeQuarterSquare': // quarter square

          switch (rnd.nextInt(4)) {
            case 0:
              shape.moveTo(PA[0], PA[1]);
              shape.lineTo((PA[0] + PB[0]) / 2, (PA[1] + PB[1]) / 2);
              shape.lineTo(PO[0], PO[1]);
              shape.lineTo((PA[0] + PD[0]) / 2, (PA[1] + PD[1]) / 2);
              break;

            case 1:
              shape.moveTo(PB[0], PB[1]);
              shape.lineTo((PB[0] + PC[0]) / 2, (PB[1] + PC[1]) / 2);
              shape.lineTo(PO[0], PO[1]);
              shape.lineTo((PA[0] + PB[0]) / 2, (PA[1] + PB[1]) / 2);
              break;

            case 2:
              shape.moveTo(PC[0], PC[1]);
              shape.lineTo((PC[0] + PD[0]) / 2, (PC[1] + PD[1]) / 2);
              shape.lineTo(PO[0], PO[1]);
              shape.lineTo((PB[0] + PC[0]) / 2, (PB[1] + PC[1]) / 2);
              break;

            case 3:
              shape.moveTo(PD[0], PD[1]);
              shape.lineTo((PD[0] + PA[0]) / 2, (PD[1] + PA[1]) / 2);
              shape.lineTo(PO[0], PO[1]);
              shape.lineTo((PC[0] + PD[0]) / 2, (PC[1] + PD[1]) / 2);
              break;
          }
          canvas.drawPath(shape, paint);

          break;

        case 'shapeMiniCircle': // mini circle
          switch (rnd.nextInt(4)) {
            case 0:
              canvas.drawCircle(Offset(PO[0]-radius/2, PO[1]-radius/2), radius/2, paint);
              break;
            case 1:
              canvas.drawCircle(Offset(PO[0]-radius/2, PO[1]+radius/2), radius/2, paint);
              break;
            case 2:
              canvas.drawCircle(Offset(PO[0]+radius/2, PO[1]-radius/2), radius/2, paint);
              break;
            case 3:
              canvas.drawCircle(Offset(PO[0]+radius/2, PO[1]+radius/2), radius/2, paint);
              break;
          }
          break;

      }


    }
  }

}


List edgePoint(List Point1, List Point2, double ratio) {
  return [
    Point1[0] * (ratio) + Point2[0] * (1 - ratio),
    Point1[1] * (ratio) + Point2[1] * (1 - ratio)
  ];
}




