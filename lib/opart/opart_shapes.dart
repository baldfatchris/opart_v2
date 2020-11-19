import 'package:flutter/material.dart';
import 'package:opart_v2/opart_icons.dart';
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

SettingsModel zoomShapes = SettingsModel(
  name: 'zoomShapes',
  settingType: SettingType.double,
  label: 'Zoom',
  tooltip: 'Zoom in and out',
  min: 20.0,
  max: 500.0,
  randomMin: 20.0,
  randomMax: 200.0,
  zoom: 100,
  defaultValue: 120.0,
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
  icon: Icon(OpArtLab.half_triangle),
  settingCategory: SettingCategory.tool,
  silent: true,
  proFeature: false,
);

SettingsModel shapeCircle = SettingsModel(
  name: 'shapeCircle',
  settingType: SettingType.bool,
  label: 'Circles',
  tooltip: 'Add circles to the shapes',
  defaultValue: true,
  icon: Icon(OpArtLab.circle),
  settingCategory: SettingCategory.tool,
  silent: true,
  proFeature: false,
);

SettingsModel shapeQuarterCircle = SettingsModel(
  name: 'shapeQuarterCircle',
  settingType: SettingType.bool,
  label: 'Quarter Circles',
  tooltip: 'Add quarter circles to the shapes',
  defaultValue: true,
  icon: Icon(OpArtLab.quarter_circle),
  settingCategory: SettingCategory.tool,
  silent: true,
  proFeature: false,
);

SettingsModel shapeHalfCircle = SettingsModel(
  name: 'shapeHalfCircle',
  settingType: SettingType.bool,
  label: 'Half Circles',
  tooltip: 'Add half circles to the shapes',
  defaultValue: true,
  icon: Icon(OpArtLab.half_circle),
  settingCategory: SettingCategory.tool,
  silent: true,
  proFeature: false,
);

SettingsModel shapeQuarterTriangle = SettingsModel(
  name: 'shapeQuarterTriangle',
  settingType: SettingType.bool,
  label: 'Quarter Triangles',
  tooltip: 'Add quarter triangles to the shapes',
  defaultValue: true,
  icon: Icon(OpArtLab.quarter_triangle),
  settingCategory: SettingCategory.tool,
  silent: true,
  proFeature: false,
);

SettingsModel shapeQuarterSquare = SettingsModel(
  name: 'shapeQuarterSquare',
  settingType: SettingType.bool,
  label: 'Quarter Squares',
  tooltip: 'Add quarter squares to the shapes',
  defaultValue: true,
  icon: Icon(OpArtLab.quarter_square),
  settingCategory: SettingCategory.tool,
  silent: true,
  proFeature: false,
);


SettingsModel shapeMiniCircle = SettingsModel(
  name: 'shapeMiniCircle',
  settingType: SettingType.bool,
  label: 'Mini Circles',
  tooltip: 'Add mini circles to the shapes',
  defaultValue: true,
  icon: Icon(OpArtLab.mini_circle),
  settingCategory: SettingCategory.tool,
  silent: true,
  proFeature: false,
);

SettingsModel shapeS = SettingsModel(
  name: 'shapeS',
  settingType: SettingType.bool,
  label: 'S Shapes',
  tooltip: 'Add s shapes to the shapes',
  defaultValue: true,
  icon: Icon(OpArtLab.s_shape),
  settingCategory: SettingCategory.tool,
  silent: true,
  proFeature: false,
);

SettingsModel shapeSquaredCircle = SettingsModel(
  name: 'shapeSquaredCircle',
  settingType: SettingType.bool,
  label: 'Squared Circle',
  tooltip: 'Add squared circle shapes to the shapes',
  defaultValue: true,
  icon: Icon(OpArtLab.squared_circle),
  settingCategory: SettingCategory.tool,
  silent: true,
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
  silent: true,
  proFeature: true,
);

SettingsModel recursionDepth = SettingsModel(
  name: 'recursionDepth',
  settingType: SettingType.int,
  label: 'Recursion Depth',
  tooltip: 'The number of recursion steps',
  min: 0,
  max: 5,
  randomMin: 0,
  randomMax: 1,
  defaultValue: 1,
  icon: Icon(OpArtLab.recursion_depth),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel recursionRatio = SettingsModel(
  name: 'recursionRatio',
  settingType: SettingType.double,
  label: 'Recursion Ratio',
  tooltip: 'The ratio of recursion - 0=never 1=always',
  min: 0.0,
  max: 1.0,
  randomMin: 0.0,
  randomMax: 0.8,
  zoom: 100,
  defaultValue: 0.9,
  icon: Icon(OpArtLab.recursion_ratio),
  settingCategory: SettingCategory.tool,
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
  proFeature: false,
  onChange: (){resetAllDefaults();},
  silent: true,
);

double aspectRatio = pi/2;

List<SettingsModel> initializeShapesAttributes() {

  return [
    reDraw,
    zoomShapes,
    shapeHalfDiagonalTriangle,
    shapeCircle,
    shapeQuarterCircle,
    shapeHalfCircle,
    shapeQuarterTriangle,
    shapeQuarterSquare,
    shapeMiniCircle,
    shapeS,
    shapeSquaredCircle,

    box,
    recursionDepth,
    recursionRatio,

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

  // colour in the canvas
  //a rectangle
  canvas.drawRect(
      Offset(borderX, borderY) & Size(imageWidth, imageHeight * 2),
      Paint()
        ..color = backgroundColor.value
        ..style = PaintingStyle.fill);

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
  if (shapeS.value == true) { shapesArray.add('shapeS'); }
  if (shapeSquaredCircle.value == true) { shapesArray.add('shapeSquaredCircle'); }

  double side = zoomShapes.value;
  
  // reset the colours
  Color nextColor;
  colourOrder = 0;

  for (int j = 0; j < cellsY; j++) {
    for (int i = 0;  i < cellsX; i++) {
  
      colourOrder = drawSquare(canvas, rnd, opArt.palette.colorList, colourOrder, shapesArray, [borderX + i * side, borderY + j * side], side, 0);

    }
  }

}



int drawSquare(
    Canvas canvas,
    Random rnd,
    List palette,
    int colourOrder,
    List shapesArray,
    List<double> PA,
    double side,
    int recursion,
  ) {
  
  Color nextColor;

  if (recursion < recursionDepth.value && rnd.nextDouble()<recursionRatio.value) {
    colourOrder = drawSquare(canvas, rnd, palette, colourOrder, shapesArray, PA, side/2, recursion+1);
    colourOrder = drawSquare(canvas, rnd, palette, colourOrder, shapesArray, [PA[0]+side/2,PA[1]], side/2, recursion+1);
    colourOrder = drawSquare(canvas, rnd, palette, colourOrder, shapesArray, [PA[0]+side/2,PA[1]+side/2], side/2, recursion+1);
    colourOrder = drawSquare(canvas, rnd, palette, colourOrder, shapesArray, [PA[0],PA[1]+side/2], side/2, recursion+1);
  }

  else {
    // Centre of the square
    List<double> PO = [PA[0] + side / 2, PA[1] + side / 2];

    // corners of the square
    List<double> PB = [PA[0] + side, PA[1]];
    List<double> PC = [PA[0] + side, PA[1] + side];
    List<double> PD = [PA[0], PA[1] + side];


    if (box.value == true) {
      // Choose the next colour
      colourOrder++;
      nextColor = (randomColors.value)
          ? palette[colourOrder % numberOfColors.value]
          : palette[rnd.nextInt(numberOfColors.value)];

      // fill the square
      canvas.drawRect(Offset(PA[0], PA[1]) & Size(side, side),
          Paint()
            ..style = PaintingStyle.fill
            ..color = nextColor.withOpacity(opacity.value));
    }



    // now  draw the shape
    if (shapesArray.length>0){

      // Choose the next colour
      colourOrder++;
      nextColor = (randomColors.value)
          ? palette[colourOrder % numberOfColors.value]
          : palette[rnd.nextInt(numberOfColors.value)];
      Paint paint = Paint()
        ..style = PaintingStyle.fill
        ..color = nextColor.withOpacity(opacity.value);

      Path shape = Path();

      // pick a random shape
      switch (shapesArray[rnd.nextInt(shapesArray.length)]) {

        case 'shapeHalfDiagonalTriangle': // half diagonal triangle

          var shapeOrientation = rnd.nextInt(4);
          switch (shapeOrientation) {
            case 0:
              shape.moveTo(PA[0], PA[1]);
              shape.lineTo(PA[0] + 2 * side / 2, PA[1]);
              shape.lineTo(PA[0], PA[1] + 2 * side / 2);
              break;

            case 1:
              shape.moveTo(PB[0] - 2 * side / 2, PB[1]);
              shape.lineTo(PB[0], PB[1]);
              shape.lineTo(PB[0], PB[1] + 2 * side / 2);
              break;

            case 2:
              shape.moveTo(PC[0], PC[1] - 2 * side / 2);
              shape.lineTo(PC[0], PC[1]);
              shape.lineTo(PC[0] - 2 * side / 2, PC[1]);
              break;

            case 3:
              shape.moveTo(PD[0], PD[1] - 2 * side / 2);
              shape.lineTo(PD[0] + 2 * side / 2, PD[1]);
              shape.lineTo(PD[0], PD[1]);
              break;
          }

          canvas.drawPath(shape, paint);

          break;

        case 'shapeCircle': // circle

          canvas.drawCircle(Offset(PO[0], PO[1]), side / 2, paint);

          break;

        case 'shapeQuarterCircle': // quarter circle

          switch (rnd.nextInt(4)) {
            case 0: // centre top left
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0] - side / 2, PO[1] - side / 2),
                  height: side / 2 * 4,
                  width: side / 2 * 4),
                  pi * (0.0), pi * 0.5, true, paint);
              break;
            case 1: // centre top right
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0] + side / 2, PO[1] - side / 2),
                  height: side / 2 * 4,
                  width: side / 2 * 4),
                  pi * (0.5), pi * 0.5, true, paint);
              break;
            case 2: // centre bottom right
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0] + side / 2, PO[1] + side / 2),
                  height: side / 2 * 4,
                  width: side / 2 * 4),
                  pi * (1.0), pi * 0.5, true, paint);
              break;
            case 3: // centre bottom left
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0] - side / 2, PO[1] + side / 2),
                  height: side / 2 * 4,
                  width: side / 2 * 4),
                  pi * (1.5), pi * 0.5, true, paint);
              break;
          }
          break;

        case 'shapeHalfCircle': // half circle

          switch (rnd.nextInt(4)) {
            case 0: // centre top
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0], PO[1] - side / 2),
                  height: side / 2 * 2,
                  width: side / 2 * 2),
                  pi * (0.0), pi * 1.0, true, paint);
              break;

            case 1: // centre right
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0] + side / 2, PO[1]),
                  height: side / 2 * 2,
                  width: side / 2 * 2),
                  pi * (0.5), pi * 1.0, true, paint);
              break;

            case 2: // centre bottom
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0], PO[1] + side / 2),
                  height: side / 2 * 2,
                  width: side / 2 * 2),
                  pi * (1.0), pi * 1.0, true, paint);
              break;

            case 3: // centre left
              canvas.drawArc(Rect.fromCenter(
                  center: Offset(PO[0] - side / 2, PO[1]),
                  height: side / 2 * 2,
                  width: side / 2 * 2),
                  pi * (1.5), pi * 1.0, true, paint);
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
              canvas.drawCircle(
                  Offset(PO[0] - side / 4, PO[1] - side / 4), side / 4,
                  paint);
              break;
            case 1:
              canvas.drawCircle(
                  Offset(PO[0] - side / 4, PO[1] + side / 4), side / 4,
                  paint);
              break;
            case 2:
              canvas.drawCircle(
                  Offset(PO[0] + side / 4, PO[1] - side / 4), side / 4,
                  paint);
              break;
            case 3:
              canvas.drawCircle(
                  Offset(PO[0] + side / 4, PO[1] + side / 4), side / 4,
                  paint);
              break;
          }
          break;
          
        case 'shapeS':

          switch (rnd.nextInt(4)) {
            case 0:
              shape.moveTo(PA[0], PA[1]);
              shape.lineTo((PA[0]+PB[0])/2, (PA[1]+PB[1])/2);
              shape.quadraticBezierTo((PB[0]*3+PC[0])/4, (PB[1]*3+PC[1])/4, PO[0], PO[1]);
              shape.quadraticBezierTo((PD[0]*3+PA[0])/4, (PD[1]*3+PA[1])/4, (PC[0]+PD[0])/2, (PC[1]+PD[1])/2);
              shape.lineTo(PD[0], PD[1]);

              break;

            case 1:
              shape.moveTo(PB[0], PB[1]);
              shape.lineTo((PB[0]+PC[0])/2, (PB[1]+PC[1])/2);
              shape.quadraticBezierTo((PC[0]*3+PD[0])/4, (PC[1]*3+PD[1])/4, PO[0], PO[1]);
              shape.quadraticBezierTo((PA[0]*3+PB[0])/4, (PA[1]*3+PB[1])/4, (PD[0]+PA[0])/2, (PD[1]+PA[1])/2);
              shape.lineTo(PA[0], PA[1]);

              break;

            case 2:
              shape.moveTo(PC[0], PC[1]);
              shape.lineTo((PC[0]+PD[0])/2, (PC[1]+PD[1])/2);
              shape.quadraticBezierTo((PD[0]*3+PA[0])/4, (PD[1]*3+PA[1])/4, PO[0], PO[1]);
              shape.quadraticBezierTo((PB[0]*3+PC[0])/4, (PB[1]*3+PC[1])/4, (PA[0]+PB[0])/2, (PA[1]+PB[1])/2);
              shape.lineTo(PB[0], PB[1]);

              break;

            case 3:
              shape.moveTo(PD[0], PD[1]);
              shape.lineTo((PD[0]+PA[0])/2, (PD[1]+PA[1])/2);
              shape.quadraticBezierTo((PA[0]*3+PB[0])/4, (PA[1]*3+PB[1])/4, PO[0], PO[1]);
              shape.quadraticBezierTo((PC[0]*3+PD[0])/4, (PC[1]*3+PD[1])/4, (PB[0]+PC[0])/2, (PB[1]+PC[1])/2);
              shape.lineTo(PC[0], PC[1]);

              break;
          }

          canvas.drawPath(shape, paint);         

          break;

        case 'shapeSquaredCircle':

          switch (rnd.nextInt(4)) {
            case 0:
              shape.moveTo(PA[0], PA[1]);
              shape.lineTo((PA[0]+PB[0])/2, (PA[1]+PB[1])/2);
              shape.quadraticBezierTo((PB[0]*3+PC[0])/4, (PB[1]*3+PC[1])/4, PO[0], PO[1]);
              shape.quadraticBezierTo((PD[0]*3+PA[0])/4, (PD[1]*3+PA[1])/4, (PC[0]+PD[0])/2, (PC[1]+PD[1])/2);
              shape.lineTo(PD[0], PD[1]);

              break;

            case 1:
              shape.moveTo(PB[0], PB[1]);
              shape.lineTo((PB[0]+PC[0])/2, (PB[1]+PC[1])/2);
              shape.quadraticBezierTo((PC[0]*3+PD[0])/4, (PC[1]*3+PD[1])/4, PO[0], PO[1]);
              shape.quadraticBezierTo((PA[0]*3+PB[0])/4, (PA[1]*3+PB[1])/4, (PD[0]+PA[0])/2, (PD[1]+PA[1])/2);
              shape.lineTo(PA[0], PA[1]);

              break;

            case 2:
              shape.moveTo(PC[0], PC[1]);
              shape.lineTo((PC[0]+PD[0])/2, (PC[1]+PD[1])/2);
              shape.quadraticBezierTo((PD[0]*3+PA[0])/4, (PD[1]*3+PA[1])/4, PO[0], PO[1]);
              shape.quadraticBezierTo((PB[0]*3+PC[0])/4, (PB[1]*3+PC[1])/4, (PA[0]+PB[0])/2, (PA[1]+PB[1])/2);
              shape.lineTo(PB[0], PB[1]);

              break;

            case 3:
              shape.moveTo(PD[0], PD[1]);
              shape.lineTo((PD[0]+PA[0])/2, (PD[1]+PA[1])/2);
              shape.quadraticBezierTo((PA[0]*3+PB[0])/4, (PA[1]*3+PB[1])/4, PO[0], PO[1]);
              shape.quadraticBezierTo((PC[0]*3+PD[0])/4, (PC[1]*3+PD[1])/4, (PB[0]+PC[0])/2, (PB[1]+PC[1])/2);
              shape.lineTo(PC[0], PC[1]);

              break;
          }

          canvas.drawPath(shape, paint);

          break;
      }
    }
  }

  return colourOrder;

}

