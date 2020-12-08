import 'package:flutter/material.dart';
import 'package:opart_v2/opart_icons.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';
import '../main.dart';

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

SettingsModel zoomOpArt = SettingsModel(
  name: 'zoomOpArt',
  settingType: SettingType.double,
  label: 'Zoom',
  tooltip: 'Zoom in and out',
  min: 20.0,
  max: 500.0,
  zoom: 100,
  defaultValue: 50.0,
  icon: Icon(Icons.zoom_in),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);

SettingsModel bulge = SettingsModel(
  name: 'bulge',
  settingType: SettingType.list,
  label: "Bulge",
  tooltip: "The shape of the bulge",
  defaultValue: "circle",
  icon: Icon(OpArtLab.bulge),
  options: ['none', 'circle', 'triangle'],
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel bulgeOneDirection = SettingsModel(
  name: 'bulgeOneDirection',
  settingType: SettingType.bool,
  label: "One Direction",
  tooltip: "Only bulge in one direction",
  defaultValue: false,
  icon: Icon(Icons.arrow_upward),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  silent: true,
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

List<SettingsModel> initializeSquaresAttributes() {

  return [
    reDraw,
    zoomOpArt,
    bulge,
    bulgeOneDirection,


    randomColors,
    numberOfColors,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];


}


void paintSquares(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }


  // Initialise the canvas
  double canvasWidth = size.width;
  double canvasHeight = size.height;
  double borderX = 0;
  double borderY = 0;

  // Work out the X and Y
  int cellsX = (canvasWidth / (zoomOpArt.value)+1.9999999).toInt();
  borderX = (canvasWidth - zoomOpArt.value * cellsX) / 2;

  int cellsY = (canvasHeight / (zoomOpArt.value)+1.9999999).toInt();
  borderY = (canvasHeight - zoomOpArt.value * cellsY) / 2;
  borderY = (canvasHeight - zoomOpArt.value * cellsY) / 2;

  int colourOrder = 0;
  Color nextColor;


  // Now make some art

  List squares = List();

  // Now make some art
  for (int i = 0; i < cellsX; ++i) {
    List squaresJ = List();

    for (int j = 0; j < cellsY; ++j) {


      var x = borderX + i * zoomOpArt.value;
      var y = borderY + j * zoomOpArt.value;
      var p1 = [x, y];


      // Choose the next colour
      colourOrder++;
      nextColor = opArt.palette.colorList[colourOrder % numberOfColors.value];
      if (randomColors.value) {
        nextColor = opArt.palette.colorList[rnd.nextInt(numberOfColors.value)];
      }
      nextColor = nextColor.withOpacity(opacity.value);
      //save the colour
      squaresJ.add(nextColor);

      // draw the square
      canvas.drawRect(
          Offset(p1[0], p1[1]) & Size(zoomOpArt.value, zoomOpArt.value),
          Paint()
            ..strokeWidth = 0.0
            ..color = nextColor
            ..isAntiAlias = false
            ..style = PaintingStyle.fill);
      canvas.drawRect(
          Offset(p1[0], p1[1]) & Size(zoomOpArt.value, zoomOpArt.value),
          Paint()
            ..color = nextColor
            ..style = PaintingStyle.stroke
            ..strokeWidth=0.1);

    }
    squares.add(squaresJ);

  }

  List bulgeDirectionArray = List();
  for (int q=0; q < squares.length; q++){
    List bulgeDirectionArrayQ = List();
    for (int r=0; r < squares[q].length; r++){
      bulgeDirectionArrayQ.add(0);
    }
    bulgeDirectionArray.add(bulgeDirectionArrayQ);
  }


  // if we are bulging, run through these again
  if (bulge.value != "none") {


    var bulgeDirection;

    bool bulgeRight;
    bool bulgeLeft;
    bool bulgeUp;
    bool bulgeDown;


    // bulgeDirection:  1 = right, 2 = down, 3 = left, 4 = Up
    for (int i = 0; i < cellsX; ++i) {
      for (int j = 0; j < cellsY; ++j) {

        var x = borderX + i * zoomOpArt.value;
        var y = borderY + j * zoomOpArt.value;

        var p1 = [x, y];
        var p2 = [x + zoomOpArt.value, y];
        var p3 = [x + zoomOpArt.value, y + zoomOpArt.value];
        var p4 = [x, y + zoomOpArt.value];

        // retrieve the colour
        Color colour = squares[i][j];

        bulgeRight = true;
        bulgeDown = true;
        bulgeLeft = true;
        bulgeUp = true;

        // if the square to the left bulged right Don't bulge left
        if (i > 0 && bulgeDirectionArray[i - 1][j] == 1) {
          bulgeLeft = false;
        }

        // if the square to the top bulged down  Don't bulge up
        if (j > 0 && bulgeDirectionArray[i][j - 1] == 2) {
          bulgeUp = false;
        }

        //if circle
        if (bulge.value == "circle") {

          // if the square to the top keft bulged right  Don't bulge top
          if (i > 0 && j > 0 && bulgeDirectionArray[i - 1][j - 1] == 1) {
            bulgeUp = false;
          }

          // if the square to the top-left bulged dowmn Don't bulge left
          if (i > 0 && j > 0 && bulgeDirectionArray[i - 1][j - 1] == 2) {
            bulgeLeft = false;
          }

          // if the square to the bottom-left bulged up Don't bulge left
          if (i > 0 && j < cellsY - 1 && bulgeDirectionArray[i - 1][j + 1] == 4) {
            bulgeLeft = false;
          }

          // if the square to the bottom-left bulged right Don't bulge down
          if (i > 0 && j < cellsY - 1 && bulgeDirectionArray[i - 1][j + 1] == 1) {
            bulgeDown = false;
          }

        }


        // if it's the top row, don't bulge up
        if (j == 0) {
          bulgeUp = false;
        }

        // if it's the bottom row, don't bulge down
        if (j == cellsY - 1) {
          bulgeDown = false;
        }

        // if it's the left column, don't bulge left
        if (i == 0) {
          bulgeLeft = false;
        }

        // if it's the right column, don't bulge right
        if (i == cellsX - 1) {
          bulgeRight = false;
        }

        List<int> possibleBulgeDirections = List();
        if (bulgeRight) { possibleBulgeDirections.add(1); }
        if (bulgeDown) { possibleBulgeDirections.add(2); }
        if (bulgeLeft) { possibleBulgeDirections.add(3); }
        if (bulgeUp) { possibleBulgeDirections.add(4); }

        int countPossibleDirections = possibleBulgeDirections.length;

        bulgeDirection = 0;
        if (countPossibleDirections > 1) {
          bulgeDirection = possibleBulgeDirections[rnd.nextInt(countPossibleDirections)];
        }
        else if (countPossibleDirections == 1) {
          // if there's only one place to go, give a 50% chance of not bulging - i.e. =0
          if (rnd.nextBool()) {bulgeDirection = possibleBulgeDirections[0];}
        }

        if (bulgeOneDirection.value == true) {
          bulgeDirection = 0;
          if (j > 0) {
            bulgeDirection = 4;
          }
        }

        // save the bulge direction
        bulgeDirectionArray[i][j] = bulgeDirection;

        // Draw the bulge
        drawBulge(canvas, colour, p1, p2, p3, p4, bulgeDirection, zoomOpArt.value , bulge.value.toString());

      }
    }

  }






}

void drawBulge(Canvas canvas, Color colour, p1, p2, p3, p4, int direction, double radius, String bulge) {
  Paint paint = Paint()
    ..color = colour
    ..isAntiAlias = false
    ..style = PaintingStyle.fill;

  //          bulgeDirection:  1 = right, 2 = bottom, 3 = left, 4 = top

  switch (bulge) {

    case "circle":
    //radius = radius - 1;

      switch (direction) {
        case 1: // bulge right
          canvas.drawArc(Rect.fromCenter(
              center: Offset((p2[0] + p3[0]) / 2, (p2[1] + p3[1]) / 2),
              height: radius,
              width: radius),
              pi * 1.5, pi, true, paint);

          canvas.drawLine(Offset(p2[0],p2[1]), Offset(p3[0],p3[1]),paint);

          break;

        case 2: // bulge bottom
          canvas.drawArc(Rect.fromCenter(
              center: Offset((p3[0] + p4[0]) / 2, (p3[1] + p4[1]) / 2),
              height: radius,
              width: radius),
              pi * 0.0, pi, true, paint);

          canvas.drawLine(Offset(p3[0],p3[1]), Offset(p4[0],p4[1]),paint);

          break;

        case 3: // bulge left
          canvas.drawArc(Rect.fromCenter(
              center: Offset((p4[0] + p1[0]) / 2, (p4[1] + p1[1]) / 2),
              height: radius,
              width: radius),
              pi * 0.5, pi, true, paint);

          canvas.drawLine(Offset(p4[0],p4[1]), Offset(p1[0],p1[1]),paint);

          break;

        case 4: // top
          canvas.drawArc(Rect.fromCenter(
              center: Offset((p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2),
              height: radius,
              width: radius),
              pi * 1.0, pi, true, paint);

          canvas.drawLine(Offset(p1[0],p1[1]), Offset(p2[0],p2[1]),paint);

          break;

      }

      break;

  case "triangle":

    double pointiness = 0.3;

    Path triangle = Path();

    switch (direction) {

      case 1: // bulge right
        triangle.moveTo(p2[0], p2[1]);
        triangle.lineTo(p3[0], p3[1]);
        triangle.lineTo(p2[0] + radius * pointiness, (p2[1] + p3[1]) / 2);
        triangle.close();
        canvas.drawPath(triangle, paint);

        break;


      case 2: // bulge bottom

        triangle.moveTo(p4[0], p4[1]);
        triangle.lineTo(p3[0], p3[1]);
        triangle.lineTo((p3[0] + p4[0]) / 2, p3[1] + radius * pointiness);
        triangle.close();
        canvas.drawPath(triangle, paint);

        break;

      case 3: // bulge left

        triangle.moveTo(p1[0], p1[1]);
        triangle.lineTo(p4[0], p4[1]);
        triangle.lineTo(p1[0] - radius * pointiness, (p1[1] + p4[1]) / 2);
        triangle.close();
        canvas.drawPath(triangle, paint);

        break;

      case 4: // bulge top
        //canvas.stroke()
        triangle.moveTo(p1[0], p1[1]);
        triangle.lineTo(p2[0], p2[1]);
        triangle.lineTo((p1[0] + p2[0]) / 2, p1[1] - radius * pointiness);
        triangle.close();
        canvas.drawPath(triangle, paint);

        break;

    }

    break;

  // case "bezier1":
  //
  //   switch (direction) {
  //     case 1: // bulge right
  //       canvas.beginPath();
  //       canvas.moveTo(p2[0], p2[1] + lineWidth / 2);
  //
  //       canvas.bezierCurveTo(
  //           p2[0] + radius * pointiness - lineWidth, (p2[1] + p3[1]) / 2,
  //           p2[0] + radius * pointiness - lineWidth, (p2[1] + p3[1]) / 2,
  //           p3[0], p3[1]);
  //
  //       canvas.closePath();
  //       if (lineWidth > 0) {canvas.stroke();}
  //       canvas.fill();
  //
  //       break;
  //
  //
  //     case 2: // bulge bottom
  //       canvas.beginPath();
  //       canvas.moveTo(p4[0] + lineWidth / 2, p4[1]);
  //
  //       canvas.bezierCurveTo(
  //           (p3[0] + p4[0]) / 2, p3[1] + radius * pointiness - lineWidth,
  //           (p3[0] + p4[0]) / 2, p3[1] + radius * pointiness - lineWidth,
  //           p3[0], p3[1]);
  //
  //       canvas.closePath();
  //       if (lineWidth > 0) {canvas.stroke();}
  //       canvas.fill();
  //
  //       //canvas.moveTo(p3[0], p3[1]);
  //       //canvas.lineTo(p4[0], p4[1]);
  //       //canvas.stroke()
  //
  //       break;
  //
  //     case 3: // bulge left
  //       canvas.beginPath();
  //       canvas.moveTo(p1[0] + lineWidth / 2, p1[1] + lineWidth / 2);
  //       //canvas.lineTo(p4[0] + lineWidth / 2, p4[1]);
  //       //canvas.lineTo(p1[0] - radius + lineWidth, (p1[1] + p4[1]) / 2);
  //
  //       canvas.bezierCurveTo(
  //           p1[0] - radius * pointiness + lineWidth, (p1[1] + p4[1]) / 2,
  //           p1[0] - radius * pointiness + lineWidth, (p1[1] + p4[1]) / 2,
  //           p4[0] + lineWidth / 2, p4[1]);
  //
  //       canvas.closePath();
  //       if (lineWidth > 0) {canvas.stroke();}
  //       canvas.fill();
  //
  //       //canvas.moveTo(p1[0], p1[1]);
  //       //canvas.lineTo(p4[0], p4[1]);
  //       //canvas.stroke()
  //
  //       break;
  //
  //     case 4: // bulge top
  //       canvas.beginPath();
  //       canvas.moveTo(p1[0] + lineWidth / 2, p1[1] + lineWidth / 2);
  //       //canvas.lineTo(p2[0], p2[1] + lineWidth / 2);
  //       //canvas.lineTo((p1[0] + p2[0]) / 2, p1[1] - radius + lineWidth);
  //
  //       canvas.bezierCurveTo(
  //           (p1[0] + p2[0]) / 2, p1[1] - radius * pointiness + lineWidth,
  //           (p1[0] + p2[0]) / 2, p1[1] - radius * pointiness + lineWidth,
  //           p2[0], p2[1] + lineWidth / 2);
  //
  //       canvas.closePath();
  //       if (lineWidth > 0) {canvas.stroke();}
  //       canvas.fill();
  //
  //
  //       //canvas.moveTo(p1[0], p1[1]);
  //       //canvas.lineTo(p2[0], p2[1]);
  //       //canvas.stroke()
  //
  //       break;
  //
  //   }
  //
  //   break;

  // case "bezier2":
  //
  //   switch (direction) {
  //     case 1: // bulge right
  //       canvas.beginPath();
  //       canvas.moveTo(p2[0], p2[1] + lineWidth / 2);
  //
  //       canvas.bezierCurveTo(
  //           p2[0] + radius * pointiness - lineWidth, p2[1],
  //           p3[0] + radius * pointiness - lineWidth, p3[1],
  //           p3[0], p3[1]);
  //
  //       canvas.closePath();
  //       if (lineWidth > 0) {canvas.stroke();}
  //       canvas.fill();
  //
  //       break;
  //
  //
  //     case 2: // bulge bottom
  //       canvas.beginPath();
  //       canvas.moveTo(p4[0] + lineWidth / 2, p4[1]);
  //
  //       canvas.bezierCurveTo(
  //           p4[0], p4[1] + radius * pointiness - lineWidth,
  //           p3[0], p3[1] + radius * pointiness - lineWidth,
  //           p3[0], p3[1]);
  //
  //       canvas.closePath();
  //       if (lineWidth > 0) {canvas.stroke();}
  //       canvas.fill();
  //
  //       break;
  //
  //     case 3: // bulge left
  //       canvas.beginPath();
  //       canvas.moveTo(p1[0] + lineWidth / 2, p1[1] + lineWidth / 2);
  //
  //       canvas.bezierCurveTo(
  //           p1[0] - radius * pointiness + lineWidth, p1[1],
  //           p4[0] - radius * pointiness + lineWidth, p4[1],
  //           p4[0] + lineWidth / 2, p4[1]);
  //
  //       canvas.closePath();
  //       if (lineWidth > 0) {canvas.stroke();}
  //       canvas.fill();
  //
  //       break;
  //
  //     case 4: // bulge top
  //       canvas.beginPath();
  //       canvas.moveTo(p1[0] + lineWidth / 2, p1[1] + lineWidth / 2);
  //       //canvas.lineTo(p2[0], p2[1] + lineWidth / 2);
  //       //canvas.lineTo((p1[0] + p2[0]) / 2, p1[1] - radius + lineWidth);
  //
  //       canvas.bezierCurveTo(
  //           p1[0], p1[1] - radius * pointiness + lineWidth,
  //           p2[0], p2[1] - radius * pointiness + lineWidth,
  //           p2[0], p2[1] + lineWidth / 2);
  //
  //       canvas.closePath();
  //       if (lineWidth > 0) {canvas.stroke();}
  //       canvas.fill();
  //
  //       break;
  //
  //   }
  //
  //   break;

  }





}
//
// function drawTriangle(canvas, colour, p1, p2, p3, lineWidth, lineColour) {
//
//   canvas.fillStyle = colour;
//   canvas.strokeStyle = colour;
//   canvas.lineWidth = 1;
//
//   canvas.beginPath();
//   canvas.moveTo(p1[0], p1[1]);
//   canvas.lineTo(p2[0], p2[1]);
//   canvas.lineTo(p3[0], p3[1]);
//   canvas.closePath();
//   canvas.fill();
//   canvas.stroke()
//
//   // draw the outline
//   if (lineWidth > 0) {
//     canvas.lineWidth = lineWidth;
//     canvas.fillStyle = lineColour;
//     canvas.strokeStyle = lineColour;
//     canvas.lineJoin = "round";
//
//     canvas.moveTo(p1[0], p1[1]);
//     canvas.lineTo(p2[0], p2[1]);
//     canvas.lineTo(p3[0], p3[1]);
//     canvas.closePath();
//     canvas.stroke();
//   }
// }




