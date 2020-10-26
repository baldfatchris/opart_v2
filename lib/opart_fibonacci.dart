import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'settings_model.dart';

import 'model.dart';
import 'palettes.dart';

import 'package:screenshot/screenshot.dart';


List<SettingsModel> initializeFibonacci(){
return [
   SettingsModel(
settingType: SettingType.double,
    label: 'Angle Increment',
    tooltip: 'The angle in radians between successive petals of the flower',
    min: 0,
    max: 2 * pi,
    zoom: 2000,
    defaultValue: (sqrt(5) + 1) / 2,
    icon: Icon(Icons.track_changes),
    proFeature: false,
), SettingsModel(
    settingType: SettingType.double,
    label: 'Zoom',
    tooltip: 'Zoom in and out',
    min: 0.3,
    max: 2,
    randomMin: 0.5,
    randomMax: 1.5,
    zoom: 100,
    defaultValue: 1.8,
    icon: Icon(Icons.zoom_in),
    proFeature: false,
  ), SettingsModel(
    settingType: SettingType.double,
    label: 'Petal Size',
    tooltip:
        'The size of the petal as a multiple of its distance from the centre',
    min: 0.01,
    max: 0.5,
    zoom: 100,
    defaultValue: 0.3,
    icon: Icon(Icons.swap_horizontal_circle),
    proFeature: false,
  ),SettingsModel(
    settingType: SettingType.double,
    label: 'Fill Ratio',
    tooltip: 'The fill ratio of the flower',
    min: 0.995,
    max: 0.9999,
    zoom: 100,
    defaultValue: 0.999,
    icon: Icon(Icons.format_color_fill),
    proFeature: false,
  ),SettingsModel(
    settingType: SettingType.double,
    label: 'randomize Angle',
    tooltip:
        'randomize the petal position by moving it around the centre by a random angle up to this maximum',
    min: 0,
    max: 0.2,
    zoom: 100,
    defaultValue: 0,
    icon: Icon(Icons.ac_unit),
    proFeature: false,
  ), SettingsModel(
    settingType: SettingType.double,
    label: 'Petal Pointiness',
    tooltip: 'the pointiness of the petal',
    min: 0,
    max: pi / 2,
    zoom: 200,
    defaultValue: 0.8,
    icon: Icon(Icons.change_history),
    proFeature: false,
  ),SettingsModel(
    settingType: SettingType.double,
    label: 'Petal Rotation',
    tooltip: 'the rotation of the petal',
    min: 0,
    max: pi,
    zoom: 200,
    defaultValue: 0,
    icon: Icon(Icons.rotate_right),
    proFeature: false,
  ),SettingsModel(
    settingType: SettingType.double,
    label: 'Rotation Ratio',
    tooltip: 'the rotation of the petal as multiple of the petal angle',
    min: 0,
    max: 4,
    zoom: 100,
    defaultValue: 0,
    icon: Icon(Icons.autorenew),
    proFeature: false,
  ),SettingsModel(
    settingType: SettingType.list,
    label: "Petal Type",
    tooltip: "The shape of the petal",
    defaultValue: "petal",
    icon: Icon(Icons.local_florist),
    options: <String>['circle', 'triangle', 'square', 'petal'],
    proFeature: false,
  ),SettingsModel(settingType: SettingType.int,
    label: 'Max Petals',
    tooltip: 'The maximum number of petals to draw',
    min: 0,
    max: 20000,
    defaultValue: 10000,
    icon: Icon(Icons.fiber_smart_record),
    proFeature: false,
  ),SettingsModel(
    settingType: SettingType.double,
    label: 'Radial Oscillation',
    tooltip: 'The amplitude of the radial oscillation',
    min: 0,
    max: 5,
    randomMin: 0,
    randomMax: 0,
    zoom: 100,
    defaultValue: 0,
    icon: Icon(Icons.all_inclusive),
    proFeature: true,
  ),SettingsModel(
    settingType: SettingType.double,
    label: 'Oscillation Period',
    tooltip: 'The period of the radial oscillation',
    min: 0,
    max: 2,
    randomMin: 0,
    randomMax: 0,
    zoom: 100,
    defaultValue: 0,
    icon: Icon(Icons.bubble_chart),
    proFeature: true,
  ),SettingsModel(
    settingType: SettingType.list,
    label: "Direction",
    tooltip:
        "Start from the outside and draw Inward, or start from the centre and draw Outward",
    defaultValue: "inward",
    icon: Icon(Icons.directions),
    options: <String>['inward', 'outward'],
    proFeature: false,
  ), SettingsModel(settingType: SettingType.color,
    label: "Background Color",
    tooltip: "The background colour for the canvas",
    defaultValue: Colors.white,
    icon: Icon(Icons.settings_overscan),
    proFeature: false,
  ),SettingsModel(settingType: SettingType.color,
    label: "Outline Color",
    tooltip: "The outline colour for the petals",
    defaultValue: Colors.white,
    icon: Icon(Icons.zoom_out_map),
    proFeature: false,
  ),SettingsModel(settingType: SettingType.double,
    label: 'Outline Width',
    tooltip: 'The width of the petal outline',
    min: 0,
    max: 3,
    zoom: 100,
    defaultValue: 0,
    icon: Icon(Icons.line_weight),
    proFeature: false,
  ), SettingsModel(
    settingType: SettingType.int,
    label: 'Random Colors',
    tooltip: 'randomize the coloursl',
    defaultValue: false,
    icon: Icon(Icons.gamepad),
    proFeature: false,
  ),SettingsModel(settingType: SettingType.int,
    label: 'Number of Colors',
    tooltip: 'The number of colours in the palette',
    min: 1,
    max: 36,
    defaultValue: 10,
    icon: Icon(Icons.palette),
    proFeature: false,
  ), SettingsModel(settingType: SettingType.list,
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
  ), SettingsModel(settingType: SettingType.list,
    label: "Palette",
    tooltip: "Choose from a list of palettes",
    defaultValue: "Default",
    icon: Icon(Icons.palette),
    options: defaultPalleteNames(),
    proFeature: false,
  ), SettingsModel(settingType: SettingType.double,
    label: 'Opactity',
    tooltip: 'The opactity of the petal',
    min: 0.2,
    max: 1,
    zoom: 100,
    defaultValue: 1,
    icon: Icon(Icons.remove_red_eye),
    proFeature: false,
  ), SettingsModel(settingType: SettingType.button,
    label: 'Reset Defaults',
    tooltip: 'Reset all settings to defaults',
    defaultValue: false,
    icon: Icon(Icons.low_priority),
    proFeature: false,
  )];
}



Widget fibonacciBodyWidget(Animation animation1) {
  return ValueListenableBuilder<int>(
      valueListenable: rebuildCanvas,
      builder: (context, value, child) {
        return Screenshot(
          controller: screenshotController,
          child: Visibility(
            visible: true,
            child: LayoutBuilder(
              builder: (_, constraints) => Container(
                width: constraints.widthConstraints().maxWidth,
                height: constraints.heightConstraints().maxHeight,
                child: CustomPaint(
                    painter: OpArtFibonacciPainter(
                  seed, rnd,
                  animation1.value,
                  // animation2.value
                )),
              ),
            ),
          ),
        );
      });
}

class OpArtFibonacciPainter extends CustomPainter {
  int seed;
  Random rnd;
  double angle;
  // double fill;

  OpArtFibonacciPainter(
    this.seed,
    this.rnd,
    this.angle,
    // this.fill
  );

  @override
  void paint(Canvas canvas, Size size) {
    rnd = Random(seed);
    // print('seed: $seed');
    //
    // print('----------------------------------------------------------------');
    // print('Fibonacci');
    // print('----------------------------------------------------------------');

    // Initialise the palette
    if (currentFibonacci == null) {
      currentFibonacci = new Fibonacci();
      fibonacciDefaultSettings();
      currentNamedPalette = currentFibonacci.paletteList.value;
    }

    if (currentFibonacci.paletteList.value != currentNamedPalette) {
      // find the index of the palette in the list

      List newPalette = palettes.firstWhere(
          (palette) => palette[0] == currentFibonacci.paletteList.value);

      // set the palette details
      currentFibonacci.numberOfColors.value = newPalette[1].toInt();
      currentFibonacci.backgroundColor.value = Color(int.parse(newPalette[2]));
      currentFibonacci.palette = [];
      for (int z = 0; z < currentFibonacci.numberOfColors.value; z++) {
        currentFibonacci.palette.add(Color(int.parse(newPalette[3][z])));
      }

      currentNamedPalette = currentFibonacci.paletteList.value;
    } else if (currentFibonacci.numberOfColors.value >
        currentFibonacci.palette.length) {
      fibonacciRandomizePalette();
    }

    // reset the defaults
    if (currentFibonacci.resetDefaults.value == true) {
      fibonacciDefaultSettings();
    }

    double canvasWidth = size.width;
    double canvasHeight = size.height;
    // print('canvasWidth: $canvasWidth');
    // print('canvasHeight: $canvasHeight');
    // print('canvasWidth / canvasHeight = ${canvasWidth / canvasHeight}');

    double borderX = 0;
    double borderY = 0;
    double imageWidth = canvasWidth;
    double imageHeight = canvasHeight;

    // if (currentFibonacci.aspectRatio == pi/2){
    currentFibonacci.aspectRatio = canvasWidth / canvasHeight;
    // }

    if (canvasWidth / canvasHeight < currentFibonacci.aspectRatio) {
      borderY = (canvasHeight - canvasWidth / currentFibonacci.aspectRatio) / 2;
      imageHeight = imageWidth / currentFibonacci.aspectRatio;
    } else {
      borderX = (canvasWidth - canvasHeight * currentFibonacci.aspectRatio) / 2;
      imageWidth = imageHeight * currentFibonacci.aspectRatio;
    }

    double flowerCentreX = imageWidth / 2;
    double flowerCentreY = imageHeight / 2;

    //  print('aspectRatio = $currentFibonacci.aspectRatio');

    int colourOrder = 0;

    // Now make some art

    generateFlower(
      canvas,
      canvasWidth,
      canvasHeight,
      imageWidth,
      imageHeight,
      borderX,
      borderY,
      flowerCentreX,
      flowerCentreY,
      angle + currentFibonacci.angleIncrement.value,
      currentFibonacci.flowerFill.value,
      currentFibonacci.petalToRadius.value,
      currentFibonacci.ratio.value,
      currentFibonacci.randomizeAngle.value,
      currentFibonacci.petalPointiness.value,
      currentFibonacci.petalRotation.value,
      currentFibonacci.petalRotationRatio.value,
      currentFibonacci.petalType.value,
      currentFibonacci.maxPetals.value,
      currentFibonacci.radialOscAmplitude.value,
      currentFibonacci.radialOscPeriod.value,
      currentFibonacci.direction.value,
      currentFibonacci.backgroundColor.value,
      currentFibonacci.lineColor.value,
      currentFibonacci.lineWidth.value,
      currentFibonacci.randomColors.value,
      currentFibonacci.numberOfColors.value,
      currentFibonacci.paletteType.value,
      currentFibonacci.opacity.value,
      currentFibonacci.palette,
    );
  }

  generateFlower(
    Canvas canvas,
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
    double currentrandomizeAngle,
    double currentPetalPointiness,
    double currentPetalRotation,
    double currentPetalRotationRatio,
    String currentPetalType,
    int currentMaxPetals,
    double currentRadialOscAmplitude,
    double currentRadialOscPeriod,
    String currentDirection,
    Color currentBackgroundColor,
    Color currentLineColor,
    double currentLineWidth,
    bool currentRandomColors,
    int currentNumberOfColors,
    String currentPaletteType,
    double currentOpacity,
    List currentPalette,
  ) {
    // print('canvasWidth: $canvasWidth');
    // print('canvasHeight: $canvasHeight');
    // print('imageWidth: $imageWidth');
    // print('imageHeight: $imageHeight');
    // print('borderX: $borderX');
    // print('borderY: $borderY');
    // print('flowerCentreX: $flowerCentreX');
    // print('flowerCentreY: $flowerCentreY');
    // print('AngleIncrement: $currentAngleIncrement');
    // print('FlowerFill: $currentFlowerFill');
    // print('PetalToRadius: $currentPetalToRadius');
    // print('randomizeAngle: $currentrandomizeAngle');
    // print('PetalPointiness: $currentPetalPointiness');
    // print('PetalRotation: $currentPetalRotation');
    // print('PetalRotationRatio: $currentPetalRotationRatio');
    // print('PetalType: $currentPetalType');
    // print('MaxPetals: $currentMaxPetals');
    // print('RadialOscAmplitude: $currentRadialOscAmplitude');
    // print('RadialOscPeriod: $currentRadialOscPeriod');
    // print('Direction: $currentDirection');
    // print('BackgroundColor: $currentBackgroundColor');
    // print('LineColor: $currentLineColor');
    // print('LineWidth: $currentLineWidth');
    // print('RandomColors: $currentRandomColors');
    // print('NumberOfColors: $currentNumberOfColors');
    // print('PaletteType: $currentPaletteType');
    // print('Opacity: $currentOpacity');
    // print('palette $currentPalette');

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

    // clear the canvas
    //ctx.clearRect(0, 0, canvas.width, canvas.height);
    //canvas.clearRect(0, 0, canvas.width, canvas.height);

    List P0 = [flowerCentreX + borderX, flowerCentreY + borderY];

    double maxRadius = (imageWidth < imageHeight)
        ? currentFlowerFill * imageWidth / 2
        : currentFlowerFill * imageWidth / 2;
    double minRadius = 2;
    double angle = 0;

    // if direction = inward
    if (currentDirection == 'inward') {
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
          P0,
          angle,
          radius,
          petalColor,
          currentAngleIncrement,
          currentFlowerFill,
          currentPetalToRadius,
          currentRatio,
          currentrandomizeAngle,
          currentPetalPointiness,
          currentPetalRotation,
          currentPetalRotationRatio,
          currentPetalType,
          currentMaxPetals,
          currentRadialOscAmplitude,
          currentRadialOscPeriod,
          currentDirection,
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
    } else {
      double radius = minRadius;
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
          P0,
          angle,
          radius,
          petalColor,
          currentAngleIncrement,
          currentFlowerFill,
          currentPetalToRadius,
          currentRatio,
          currentrandomizeAngle,
          currentPetalPointiness,
          currentPetalRotation,
          currentPetalRotationRatio,
          currentPetalType,
          currentMaxPetals,
          currentRadialOscAmplitude,
          currentRadialOscPeriod,
          currentDirection,
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

        radius = radius / currentRatio;

        maxPetalCount = maxPetalCount - 1;
      } while (radius > minRadius && radius < maxRadius && maxPetalCount > 0);
    }

    // colour in the outer canvas
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(0, 0) & Size(borderX, canvasHeight), paint1);
    canvas.drawRect(
        Offset(canvasWidth - borderX, 0) & Size(borderX, canvasHeight), paint1);

    canvas.drawRect(Offset(0, 0) & Size(canvasWidth, borderY), paint1);
    canvas.drawRect(
        Offset(
              0,
              canvasHeight - borderY,
            ) &
            Size(canvasWidth, borderY + canvasHeight * 2),
        paint1);
  }

  drawPetal(
    Canvas canvas,
    List P0,
    double angle,
    double radius,
    Color colour,
    double currentAngleIncrement,
    double currentFlowerFill,
    double currentPetalToRadius,
    double currentRatio,
    double currentrandomizeAngle,
    double currentPetalPointiness,
    double currentPetalRotation,
    double currentPetalRotationRatio,
    String currentPetalType,
    int currentMaxPetals,
    double currentRadialOscAmplitude,
    double currentRadialOscPeriod,
    String currentDirection,
    Color currentBackgroundColor,
    Color currentLineColor,
    double currentLineWidth,
    bool currentRandomColors,
    int currentNumberOfColors,
    String currentPaletteType,
    double currentOpacity,
    List currentPalette,
  ) {
    angle = angle + (rnd.nextDouble() - 0.5) * currentrandomizeAngle;

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

      case 'petal': //"petal":

        List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
        var petalRadius = radius * currentPetalToRadius;

        List PA = [
          P1[0] +
              petalRadius *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.0),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.0)
        ];

        List PB = [
          P1[0] +
              petalRadius *
                  currentPetalPointiness *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.5),
          P1[1] +
              petalRadius *
                  currentPetalPointiness *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.5)
        ];

        List PC = [
          P1[0] +
              petalRadius *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.0),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.0)
        ];

        List PD = [
          P1[0] +
              petalRadius *
                  currentPetalPointiness *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.5),
          P1[1] +
              petalRadius *
                  currentPetalPointiness *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.5)
        ];

        Path petal = Path();

        petal.moveTo(PA[0], PA[1]);
        petal.quadraticBezierTo(PB[0], PB[1], PC[0], PC[1]);
        petal.quadraticBezierTo(PD[0], PD[1], PA[0], PA[1]);
        petal.close();

        canvas.drawPath(
            petal,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColor);
        canvas.drawPath(
            petal,
            Paint()
              ..style = PaintingStyle.fill
              ..color = colour);

        break;
    }
  }

  @override
  bool shouldRepaint(OpArtFibonacciPainter oldDelegate) => false;
}
