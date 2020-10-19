import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'package:screenshot/screenshot.dart';
import 'package:shake/shake.dart';
import 'package:opart_v2/setting_slider.dart';
import 'package:opart_v2/setting_dropdown.dart';
import 'model.dart';

Random rnd;

// Settings
Fibonacci currentFibonacci;

List Palettes = [
  [
    'default',
    10,
    Color(0xFFffffff),
    [
      Color(0xFF34a1af),
      Color(0xFFa570a8),
      Color(0xFFd6aa27),
      Color(0xFF5f9d50),
      Color(0xFF789dd1),
      Color(0xFFc25666),
      Color(0xFF2b7b1),
      Color(0xFFd63aa),
      Color(0xFF1f4ed),
      Color(0xFF383c47)
    ]
  ]
];

class Fibonacci {
  // image settings
  SettingsModelDouble angleIncrement = SettingsModelDouble(
      label: 'Angle Increment',
      tooltip: 'The angle in radians between successive petals of the flower',
      min: 0,
      max: 2 * pi,
      defaultValue: (sqrt(5) + 1) / 2,
      icon: Icon(Icons.ac_unit));

  SettingsModelDouble flowerFill;
  SettingsModelDouble petalToRadius;
  SettingsModelDouble ratio;
  SettingsModelDouble randomiseAngle;
  SettingsModelDouble petalPointiness;
  SettingsModelDouble petalRotation;
  SettingsModelDouble petalRotationRatio;
  String petalType;
  int maxPetals;
  double radialOscAmplitude;
  double radialOscPeriod;
  String direction;

// palette settings
  Color backgroundColour;
  Color lineColour;
  double lineWidth;
  bool randomColours;
  int numberOfColours;
  String paletteType;
  double opacity;
  List palette;
  double aspectRatio;
  File image;

// lock settings
  bool petalTypeLOCK = false;
  bool maxPetalsLOCK = false;
  bool radialOscAmplitudeLOCK = false;
  bool radialOscPeriodLOCK = false;
  bool directionLOCK = false;
  bool backgroundColourLOCK = false;
  bool lineColourLOCK = false;
  bool lineWidthLOCK = false;
  bool randomColoursLOCK = false;
  bool numberOfColoursLOCK = false;
  bool paletteTypeLOCK = false;
  bool opacityLOCK = false;
  bool paletteLOCK = false;
  bool aspectRatioLOCK = false;

  Random random;

  Fibonacci({
    // image settings
    // this.angleIncrement  ,
    this.flowerFill,
    this.petalToRadius,
    this.ratio,
    this.randomiseAngle,
    this.petalPointiness,
    this.petalRotation,
    this.petalRotationRatio,
    this.petalType,
    this.maxPetals,
    this.radialOscAmplitude,
    this.radialOscPeriod,
    this.direction,

    // palette settings
    this.backgroundColour,
    this.lineColour,
    this.lineWidth,
    this.randomColours,
    this.numberOfColours,
    this.paletteType,
    this.opacity,
    this.palette,
    this.aspectRatio = pi / 2,
    this.image,
    this.petalTypeLOCK = false,
    this.maxPetalsLOCK = false,
    this.radialOscAmplitudeLOCK = false,
    this.radialOscPeriodLOCK = false,
    this.directionLOCK = false,
    this.backgroundColourLOCK = false,
    this.lineColourLOCK = false,
    this.lineWidthLOCK = false,
    this.randomColoursLOCK = false,
    this.numberOfColoursLOCK = false,
    this.paletteTypeLOCK = false,
    this.opacityLOCK = false,
    this.paletteLOCK = false,
    this.aspectRatioLOCK = false,
    this.random,
  });

  void randomize() {
    print('-----------------------------------------------------');
    print('randomize');
    print('-----------------------------------------------------');

    // angleIncrement 0 - pi
    this.angleIncrement.randomise(random);

    // flowerFill 0.7 - 1.3
    this.flowerFill.randomise(random);

    // petalToRadius - 0 01 to 0.1
    this.petalToRadius.randomise(random);

    // ratio 0.995 - 0.99999
    this.ratio.randomise(random);

    // randomiseAngle 0 to 0.2
    this.randomiseAngle.randomise(random);
    if (this.randomiseAngle.locked == false && random.nextDouble() > 0.2) {
      this.randomiseAngle.value = 0;
    }

    // petalPointiness: 0 to pi
    this.petalPointiness.randomise(random);

    // petalRotation: 0 to pi
    this.petalRotation.randomise(random);

    // petalRotationRatio 0 to 4
    this.petalRotation.randomise(random);
    if (this.petalRotation.locked == false && random.nextDouble() > 0.3) {
      this.petalRotationRatio.value = random.nextInt(4).toDouble();
    }

    // petalType = 0/1/2/3  circle/triangle/square/petal
    if (this.petalTypeLOCK == false) {
      this.petalType =
          ['circle', 'triangle', 'square', 'petal'][random.nextInt(3)];
    }

    // maxPetals = 5000 to 10000;
    if (this.maxPetalsLOCK == false) {
      this.maxPetals = random.nextInt(5000) + 5000;
    }

    // radialOscAmplitude 0 to 5
    if (this.radialOscAmplitudeLOCK == false) {
      this.radialOscAmplitude = 0;
      if (random.nextDouble() > 0.7) {
        this.radialOscAmplitude = random.nextDouble() * 5;
      }
    }

    // radialOscPeriod 0 to 2
    if (this.radialOscPeriodLOCK == false) {
      this.radialOscPeriod = random.nextDouble() * 2;
    }

    // direction
    if (this.directionLOCK == false) {
      this.direction = random.nextBool() ? 'inward' : 'outward';
    }

    if (this.aspectRatioLOCK == false) {
      // this.aspectRatio = random.nextDouble() + 0.5;
      // if (random.nextBool()){
      this.aspectRatio = pi / 2;
      // }
    }

    // numberOfColours 2 to 36
    if (this.numberOfColoursLOCK == false) {
      this.numberOfColours = random.nextInt(34) + 2;
    }

    // randomColours
    if (this.randomColoursLOCK == false) {
      this.randomColours = random.nextBool();
    }

    // lineWidth 0 to 3
    if (this.lineWidthLOCK == false) {
      this.lineWidth = random.nextDouble() * 3;
    }

    // opacity 0.6 to 1
    if (this.opacityLOCK == false) {
      this.opacity = random.nextDouble() * 0.4 + 0.6;
    }

    // backgroundColour
    if (this.backgroundColourLOCK == false) {
      this.backgroundColour =
          Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity);
    }
  }

  void randomizePalette() {
    print('-----------------------------------------------------');
    print('randomizePalette');
    print('-----------------------------------------------------');
    print(currentFibonacci.angleIncrement.locked);
    rnd = Random(DateTime.now().millisecond);

    // lineColour
    if (this.lineColourLOCK == false) {
      this.lineColour =
          Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity);
    }

    List palette = [];
    switch (this.paletteType) {

      // blended random
      case 'blended random':
        {
          double blendColour = rnd.nextDouble() * 0xFFFFFF;
          for (int colourIndex = 0;
              colourIndex < this.numberOfColours;
              colourIndex++) {
            palette.add(
                Color(((blendColour + rnd.nextDouble() * 0xFFFFFF) / 2).toInt())
                    .withOpacity(opacity));
          }
        }
        break;

      // linear random
      case 'linear random':
        {
          List startColour = [
            rnd.nextInt(255),
            rnd.nextInt(255),
            rnd.nextInt(255)
          ];
          List endColour = [
            rnd.nextInt(255),
            rnd.nextInt(255),
            rnd.nextInt(255)
          ];
          for (int colourIndex = 0;
              colourIndex < this.numberOfColours;
              colourIndex++) {
            palette.add(Color.fromRGBO(
                ((startColour[0] * colourIndex +
                            endColour[0] *
                                (this.numberOfColours - colourIndex)) /
                        this.numberOfColours)
                    .round(),
                ((startColour[1] * colourIndex +
                            endColour[1] *
                                (this.numberOfColours - colourIndex)) /
                        this.numberOfColours)
                    .round(),
                ((startColour[2] * colourIndex +
                            endColour[2] *
                                (this.numberOfColours - colourIndex)) /
                        this.numberOfColours)
                    .round(),
                opacity));
          }
        }
        break;

      // linear complementary
      case 'linear complementary':
        {
          List startColour = [
            rnd.nextInt(255),
            rnd.nextInt(255),
            rnd.nextInt(255)
          ];
          List endColour = [
            255 - startColour[0],
            255 - startColour[1],
            255 - startColour[2]
          ];
          for (int colourIndex = 0;
              colourIndex < this.numberOfColours;
              colourIndex++) {
            palette.add(Color.fromRGBO(
                ((startColour[0] * colourIndex +
                            endColour[0] *
                                (this.numberOfColours - colourIndex)) /
                        this.numberOfColours)
                    .round(),
                ((startColour[1] * colourIndex +
                            endColour[1] *
                                (this.numberOfColours - colourIndex)) /
                        this.numberOfColours)
                    .round(),
                ((startColour[2] * colourIndex +
                            endColour[2] *
                                (this.numberOfColours - colourIndex)) /
                        this.numberOfColours)
                    .round(),
                opacity));
          }
        }
        break;

      // random
      default:
        {
          for (int colorIndex = 0;
              colorIndex < this.numberOfColours;
              colorIndex++) {
            palette.add(Color((rnd.nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(opacity));
          }
        }
        break;
    }

    this.palette = palette;
  }

  void defaultSettings() {
    // resets to default settings

//    this.angleIncrement = SettingsModelDouble(label: 'Angle Increment', tooltip: 'The angle in radians between successive petals of the flower', min: 0, max: 2*pi, defaultValue: (sqrt(5)+1)/2, icon: Icon(Icons.ac_unit));
    this.angleIncrement.value = this.angleIncrement.defaultValue;

    this.flowerFill = SettingsModelDouble(
        label: 'Zoom',
        tooltip: 'Zoom in and out',
        min: 0.3,
        max: 2,
        defaultValue: 1,
        icon: Icon(Icons.access_alarm));
    this.flowerFill.value = this.flowerFill.defaultValue;

    this.petalToRadius = SettingsModelDouble(
        label: 'Petal to Radius',
        tooltip:
            'The size of the petal as a multiple of its distance from the centre',
        min: 0.01,
        max: 0.1,
        defaultValue: 0.03,
        icon: Icon(Icons.backup));
    this.petalToRadius.value = this.petalToRadius.defaultValue;

    this.ratio = SettingsModelDouble(
        label: 'Ratio',
        tooltip: 'The fill ratio of the flower',
        min: 0.995,
        max: 0.9999,
        defaultValue: 0.999,
        icon: Icon(Icons.adjust));
    this.ratio.value = this.ratio.defaultValue;

    // randomiseAngle 0 to 0.2
    this.randomiseAngle = SettingsModelDouble(
        label: 'Randomise Angle',
        tooltip:
            'Randomise the petal position by moving it around the centre by a random angle up to this maximum',
        min: 0,
        max: 0.2,
        defaultValue: 0,
        icon: Icon(Icons.all_inclusive));
    this.randomiseAngle.value = this.randomiseAngle.defaultValue;

    // petalPointiness: 0 to pi
    this.petalPointiness = SettingsModelDouble(
        label: 'Petal Pointiness',
        tooltip: 'the pointiness of the petal',
        min: 0,
        max: pi,
        defaultValue: 0.8,
        icon: Icon(Icons.account_circle));
    this.petalPointiness.value = this.petalPointiness.defaultValue;

    // petalRotation: 0 to pi
    this.petalRotation = SettingsModelDouble(
        label: 'Petal Rotation',
        tooltip: 'the rotation of the petal',
        min: 0,
        max: pi,
        defaultValue: 0,
        icon: Icon(Icons.all_out));
    this.petalRotation.value = this.petalRotation.defaultValue;

    // petalRotationRatio 0 to 4
    this.petalRotationRatio = SettingsModelDouble(
        label: 'Rotation Ratio',
        tooltip: 'the rotation of the petal as multiple of the petal angle',
        min: 0,
        max: 4,
        defaultValue: 0,
        icon: Icon(Icons.autorenew));
    this.petalRotationRatio.value = this.petalRotationRatio.defaultValue;

    this.petalType = 'circle';
    this.maxPetals = 10000;
    this.radialOscAmplitude = 0;
    this.radialOscPeriod = 0;
    this.direction = 'inward';

    // palette settings
    this.backgroundColour = Colors.white;
    this.lineColour = Colors.white;
    this.lineWidth = 0;
    this.randomColours = false;
    this.numberOfColours = 6;
    this.paletteType = 'random';
    this.opacity = 1;
    this.palette = [
      Color(0xFF34a1af),
      Color(0xFFa570a8),
      Color(0xFFd6aa27),
      Color(0xFF5f9d50),
      Color(0xFF789dd1),
      Color(0xFFc25666),
      Color(0xFF2b7b1),
      Color(0xFFd63aa),
      Color(0xFF1f4ed),
      Color(0xFF383c47)
    ];
    this.aspectRatio = pi / 2;
    this.image;

    this.petalTypeLOCK = false;
    this.maxPetalsLOCK = false;
    this.radialOscAmplitudeLOCK = false;
    this.radialOscPeriodLOCK = false;
    this.directionLOCK = false;
    this.backgroundColourLOCK = false;
    this.lineColourLOCK = false;
    this.lineWidthLOCK = false;
    this.randomColoursLOCK = false;
    this.numberOfColoursLOCK = false;
    this.paletteTypeLOCK = false;
    this.opacityLOCK = false;
    this.paletteLOCK = false;
    this.aspectRatioLOCK = false;
  }
}

class OpArtFibonacciStudio extends StatefulWidget {
  int seed;
  bool showSettings;
  ScreenshotController screenshotController;

  OpArtFibonacciStudio(this.seed, this.showSettings,
      {this.screenshotController});

  @override
  _OpArtFibonacciStudioState createState() => _OpArtFibonacciStudioState();
}

class _OpArtFibonacciStudioState extends State<OpArtFibonacciStudio>
    with TickerProviderStateMixin {
  int _counter = 0;
  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  int _currentColor = 0;

  // Animation<double> animation1;
  // AnimationController controller1;

  // Animation<double> animation2;
  // AnimationController controller2;

  Widget settingsWidget() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            'Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Randomise Palette
            Flexible(
              flex: 1,
              child: FloatingActionButton.extended(
                label: Text('Randomise Palette'),
                icon: Icon(Icons.palette),
                //backgroundColour: Colors.pink,

                onPressed: () {
                  setState(() {
                    print('Randomise Palette Button Pressed');
                    currentFibonacci.randomizePalette();
                  });
                },
              ),
            ),

            SizedBox(
              width: 10,
            ),

            // Randomise All
            Flexible(
              flex: 1,
              child: FloatingActionButton.extended(
                label: Text('Randomise All'),
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    print('Randomise All');
                    currentFibonacci.randomize();
                    currentFibonacci.randomizePalette();
                  });
                },
              ),
            ),
          ],
        ),

        // angleIncrement
        settingsSlider(
          currentFibonacci.angleIncrement.label,
          currentFibonacci.angleIncrement.value,
          currentFibonacci.angleIncrement.min,
          currentFibonacci.angleIncrement.max,
          currentFibonacci.angleIncrement.locked,
          (value) {
            setState(() {
              currentFibonacci.angleIncrement.value = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.angleIncrement.locked =
                  !currentFibonacci.angleIncrement.locked;
            });
          },
        ),

        // flowerFill
        settingsSlider(
          currentFibonacci.flowerFill.label,
          currentFibonacci.flowerFill.value,
          currentFibonacci.flowerFill.min,
          currentFibonacci.flowerFill.max,
          currentFibonacci.flowerFill.locked,
          (value) {
            setState(() {
              currentFibonacci.flowerFill.value = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.flowerFill.locked =
                  !currentFibonacci.flowerFill.locked;
            });
          },
        ),

        // ratio
        settingsSlider(
          currentFibonacci.ratio.label,
          currentFibonacci.ratio.value,
          currentFibonacci.ratio.min,
          currentFibonacci.ratio.max,
          currentFibonacci.ratio.locked,
          (value) {
            setState(() {
              currentFibonacci.ratio.value = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.ratio.locked = !currentFibonacci.ratio.locked;
            });
          },
        ),

        // petalToRadius
        settingsSlider(
          currentFibonacci.petalToRadius.label,
          currentFibonacci.petalToRadius.value,
          currentFibonacci.petalToRadius.min,
          currentFibonacci.petalToRadius.max,
          currentFibonacci.petalToRadius.locked,
          (value) {
            setState(() {
              currentFibonacci.petalToRadius.value = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.petalToRadius.locked =
                  !currentFibonacci.petalToRadius.locked;
            });
          },
        ),

        // randomiseAngle
        settingsSlider(
          currentFibonacci.randomiseAngle.label,
          currentFibonacci.randomiseAngle.value,
          currentFibonacci.randomiseAngle.min,
          currentFibonacci.randomiseAngle.max,
          currentFibonacci.randomiseAngle.locked,
          (value) {
            setState(() {
              currentFibonacci.randomiseAngle.value = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.randomiseAngle.locked =
                  !currentFibonacci.randomiseAngle.locked;
            });
          },
        ),

        // petalType
        settingsDropdown(
          'petalType',
          currentFibonacci.petalType,
          ['circle', 'triangle', 'square', 'petal'],
          currentFibonacci.petalTypeLOCK,
          (value) {
            setState(() {
              currentFibonacci.petalType = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.petalTypeLOCK = !currentFibonacci.petalTypeLOCK;
            });
          },
        ),

        // petalPointiness
        settingsSlider(
          currentFibonacci.petalPointiness.label,
          currentFibonacci.petalPointiness.value,
          currentFibonacci.petalPointiness.min,
          currentFibonacci.petalPointiness.max,
          currentFibonacci.petalPointiness.locked,
          (value) {
            setState(() {
              currentFibonacci.petalPointiness.value = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.petalPointiness.locked =
                  !currentFibonacci.petalPointiness.locked;
            });
          },
        ),

        // petalRotation 0 to pi
        settingsSlider(
          currentFibonacci.petalRotation.label,
          currentFibonacci.petalRotation.value,
          currentFibonacci.petalRotation.min,
          currentFibonacci.petalRotation.max,
          currentFibonacci.petalRotation.locked,
          (value) {
            setState(() {
              currentFibonacci.petalRotation.value = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.petalRotation.locked =
                  !currentFibonacci.petalRotation.locked;
            });
          },
        ),

        // petalRotationRatio 0 to 4
        settingsSlider(
          currentFibonacci.petalRotationRatio.label,
          currentFibonacci.petalRotationRatio.value,
          currentFibonacci.petalRotationRatio.min,
          currentFibonacci.petalRotationRatio.max,
          currentFibonacci.petalRotationRatio.locked,
          (value) {
            setState(() {
              currentFibonacci.petalRotationRatio.value = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.petalRotationRatio.locked =
                  !currentFibonacci.petalRotationRatio.locked;
            });
          },
        ),

        // radialOscAmplitude
        settingsSlider(
          'radialOscAmplitude',
          currentFibonacci.radialOscAmplitude,
          0,
          5,
          currentFibonacci.radialOscAmplitudeLOCK,
          (value) {
            setState(() {
              currentFibonacci.radialOscAmplitude = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.radialOscAmplitudeLOCK =
                  !currentFibonacci.radialOscAmplitudeLOCK;
            });
          },
        ),

        // radialOscPeriod
        settingsSlider(
          'radialOscPeriod',
          currentFibonacci.radialOscPeriod,
          0,
          2,
          currentFibonacci.radialOscPeriodLOCK,
          (value) {
            setState(() {
              currentFibonacci.radialOscPeriod = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.radialOscPeriodLOCK =
                  !currentFibonacci.radialOscPeriodLOCK;
            });
          },
        ),

        // direction
        settingsDropdown(
          'direction',
          currentFibonacci.direction,
          ['inward', 'outward'],
          currentFibonacci.directionLOCK,
          (value) {
            setState(() {
              currentFibonacci.direction = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.directionLOCK = !currentFibonacci.directionLOCK;
            });
          },
        ),

        // maxPetals 1000 to 10000
        settingsSlider(
          'maxPetals',
          currentFibonacci.maxPetals.toDouble(),
          1,
          10000,
          currentFibonacci.maxPetalsLOCK,
          (value) {
            setState(() {
              currentFibonacci.maxPetals = value.toInt();
            });
          },
          () {
            setState(() {
              currentFibonacci.maxPetalsLOCK = !currentFibonacci.maxPetalsLOCK;
            });
          },
        ),

        // lineWidth 0-3
        settingsSlider(
          'lineWidth',
          currentFibonacci.lineWidth,
          0,
          3,
          currentFibonacci.lineWidthLOCK,
          (value) {
            setState(() {
              currentFibonacci.lineWidth = value;
            });
          },
          () {
            setState(() {
              currentFibonacci.lineWidthLOCK = !currentFibonacci.lineWidthLOCK;
            });
          },
        ),

        // numberOfColours
        settingsSlider(
          'numberOfColours',
          currentFibonacci.numberOfColours.toDouble(),
          1,
          36,
          currentFibonacci.numberOfColoursLOCK,
          (value) {
            setState(() {
              if (currentFibonacci.numberOfColours < value.toInt()) {
                currentFibonacci.numberOfColours = value.toInt();
                currentFibonacci.randomizePalette();
              } else {
                currentFibonacci.numberOfColours = value.toInt();
              }
            });
          },
          () {
            setState(() {
              currentFibonacci.numberOfColoursLOCK =
                  !currentFibonacci.numberOfColoursLOCK;
            });
          },
        ),

        // randomColours
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      // toggle lock
                      if (currentFibonacci.randomColoursLOCK) {
                        currentFibonacci.randomColoursLOCK = false;
                        print('randomColours UNLOCK');
                      } else {
                        currentFibonacci.randomColoursLOCK = true;
                        print('randomColours LOCK');
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'randomColours:',
                        style: currentFibonacci.randomColoursLOCK
                            ? TextStyle(fontWeight: FontWeight.normal)
                            : TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        currentFibonacci.randomColoursLOCK
                            ? Icons.lock
                            : Icons.lock_open,
                        size: 20,
                        color: currentFibonacci.randomColoursLOCK
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ],
                  )),
            ),
            Flexible(
              flex: 2,
              child: Switch(
                value: currentFibonacci.randomColours,
                onChanged: currentFibonacci.randomColoursLOCK
                    ? null
                    : (value) {
                        setState(() {
                          currentFibonacci.randomColours = value;
                        });
                      },
              ),
            ),
          ],
        ),

        // paletteType
        settingsDropdown(
          'paletteType',
          currentFibonacci.paletteType,
          ['random', 'blended random', 'linear random', 'linear complementary'],
          currentFibonacci.paletteTypeLOCK,
          (value) {
            setState(() {
              print('new paletteType: $value');
              currentFibonacci.paletteType = value;
              currentFibonacci.randomizePalette();
            });
          },
          () {
            setState(() {
              currentFibonacci.paletteTypeLOCK =
                  !currentFibonacci.paletteTypeLOCK;
            });
          },
        ),

        // aspectRatio
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        // toggle lock
                        if (currentFibonacci.aspectRatioLOCK) {
                          currentFibonacci.aspectRatioLOCK = false;
                        } else {
                          currentFibonacci.aspectRatioLOCK = true;
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'aspectRatio:',
                          style: currentFibonacci.aspectRatioLOCK
                              ? TextStyle(fontWeight: FontWeight.normal)
                              : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          currentFibonacci.aspectRatioLOCK
                              ? Icons.lock
                              : Icons.lock_open,
                          size: 20,
                          color: currentFibonacci.aspectRatioLOCK
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ],
                    ))),
            Flexible(
              flex: 2,
              child: Slider(
                value: currentFibonacci.aspectRatio,
                min: 0.5,
                max: 2,
                onChanged: currentFibonacci.aspectRatioLOCK
                    ? null
                    : (value) {
                        setState(() {
                          currentFibonacci.aspectRatio = value;
                        });
                      },
                label: '$currentFibonacci.aspectRatio ',
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget bodyWidget() {
    return Screenshot(
      controller: screenshotController,
      child: Stack(
        children: [
          Visibility(
            visible: true,
            child: LayoutBuilder(
              builder: (_, constraints) => Container(
                width: constraints.widthConstraints().maxWidth,
                height: constraints.heightConstraints().maxHeight,
                child: CustomPaint(
                    painter: OpArtFibonacciPainter(
                  widget.seed, rnd,
                  // animation1.value,
                  // animation2.value
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = widget.screenshotController;
    Widget bodyWidget() {
      return Screenshot(
        controller: screenshotController,
        child: Stack(
          children: [
            Visibility(
              visible: true,
              child: LayoutBuilder(
                builder: (_, constraints) => Container(
                  width: constraints.widthConstraints().maxWidth,
                  height: constraints.heightConstraints().maxHeight,
                  child: CustomPaint(
                      painter: OpArtFibonacciPainter(
                    widget.seed, rnd,
                    // animation1.value,
                    // animation2.value
                  )),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 7,
            child: widget.showSettings
                ? Column(
                    children: [
                      Flexible(flex: 3, child: bodyWidget()),
                      Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: settingsWidget(),
                          )),
                    ],
                  )
                : bodyWidget(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      print(
          '---------------------------------------------------------------------------');
      print('SHAKE');
      print(
          '---------------------------------------------------------------------------');
      setState(() {
        currentFibonacci.randomize();
        currentFibonacci.randomizePalette();
        //randomiseSettings();
      });
    });
    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();

    // Animation Stuff
    // controller1 = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 7200),
    // );

    // controller2 = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 60),
    // );

    // Tween<double> _angleTween = Tween(begin: -pi, end: pi);
    // Tween<double> _fillTween = Tween(begin: 1, end: 1);

    // animation1 = _angleTween.animate(controller1)
    //   ..addListener(() {
    //     setState(() {});
    //   })
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       controller1.repeat();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller1.forward();
    //     }
    //   });

    // animation2 = _fillTween.animate(controller2)
    //   ..addListener(() {
    //     setState(() {});
    //   })
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       controller2.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller2.forward();
    //     }
    //   });

    // controller1.forward();
    // controller2.forward();
  }

  // @override
  // void dispose() {
  //   controller1.dispose();
  //   // controller2.dispose();
  //   super.dispose();
  // }

}

class OpArtFibonacciPainter extends CustomPainter {
  int seed;
  Random rnd;
  // double angle;
  // double fill;

  OpArtFibonacciPainter(
    this.seed,
    this.rnd,
    // this.angle,
    // this.fill
  );

  @override
  void paint(Canvas canvas, Size size) {
    rnd = Random(seed);
    print('seed: $seed');

    print('----------------------------------------------------------------');
    print('Fibonacci');
    print('----------------------------------------------------------------');

    if (currentFibonacci == null) {
      currentFibonacci = new Fibonacci(random: rnd);
      currentFibonacci.defaultSettings();
    }

    double canvasWidth = size.width;
    double canvasHeight = size.height;
    print('canvasWidth: $canvasWidth');
    print('canvasHeight: $canvasHeight');
    print('canvasWidth / canvasHeight = ${canvasWidth / canvasHeight}');

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

    print('aspectRatio = $currentFibonacci.aspectRatio');
    print('imageWidth = $imageWidth');
    print('imageHeight = $imageHeight');
    print('borderX = $borderX');
    print('borderY = $borderY');
    print('flowerCentreX: $flowerCentreX');
    print('flowerCentreY: $flowerCentreY');

    print('numberOfColours: ${currentFibonacci.numberOfColours}');
    print('opacity: ${currentFibonacci.opacity}');
    print('paletteType: ${currentFibonacci.paletteType}');
    print('direction ${currentFibonacci.direction}');
    print('randomColours: ${currentFibonacci.randomColours}');

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

      // angle, //currentFibonacci.angleIncrement,
      currentFibonacci.angleIncrement.value,
      currentFibonacci.flowerFill.value,
      currentFibonacci.petalToRadius.value,
      currentFibonacci.ratio.value,
      currentFibonacci.randomiseAngle.value,
      currentFibonacci.petalPointiness.value,
      currentFibonacci.petalRotation.value,
      currentFibonacci.petalRotationRatio.value,
      currentFibonacci.petalType,
      currentFibonacci.maxPetals,
      currentFibonacci.radialOscAmplitude,
      currentFibonacci.radialOscPeriod,
      currentFibonacci.direction,
      currentFibonacci.backgroundColour,
      currentFibonacci.lineColour,
      currentFibonacci.lineWidth,
      currentFibonacci.randomColours,
      currentFibonacci.numberOfColours,
      currentFibonacci.paletteType,
      currentFibonacci.opacity,
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
    double currentRandomiseAngle,
    double currentPetalPointiness,
    double currentPetalRotation,
    double currentPetalRotationRatio,
    String currentPetalType,
    int currentMaxPetals,
    double currentRadialOscAmplitude,
    double currentRadialOscPeriod,
    String currentDirection,
    Color currentBackgroundColour,
    Color currentLineColour,
    double currentLineWidth,
    bool currentRandomColours,
    int currentNumberOfColours,
    String currentPaletteType,
    double currentOpacity,
    List currentPalette,
  ) {
    // colour in the canvas
    //a rectangle
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight * 2),
        Paint()
          ..color = currentBackgroundColour
          ..style = PaintingStyle.fill);

    int maxPetalCount = currentMaxPetals;

    // start the colour order
    int colourOrder = 0;
    Color nextColour;

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
        nextColour = currentPalette[colourOrder % currentNumberOfColours];
        if (currentRandomColours) {
          nextColour = currentPalette[rnd.nextInt(currentNumberOfColours)];
        }

        print('P0: $P0');
        drawPetal(
          canvas,
          P0,
          angle,
          radius,
          nextColour,
          currentAngleIncrement,
          currentFlowerFill,
          currentPetalToRadius,
          currentRatio,
          currentRandomiseAngle,
          currentPetalPointiness,
          currentPetalRotation,
          currentPetalRotationRatio,
          currentPetalType,
          currentMaxPetals,
          currentRadialOscAmplitude,
          currentRadialOscPeriod,
          currentDirection,
          currentBackgroundColour,
          currentLineColour,
          currentLineWidth,
          currentRandomColours,
          currentNumberOfColours,
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
        nextColour = currentPalette[colourOrder % currentNumberOfColours];
        if (currentRandomColours) {
          nextColour = currentPalette[rnd.nextInt(currentNumberOfColours)];
        }

        drawPetal(
          canvas,
          P0,
          angle,
          radius,
          nextColour,
          currentAngleIncrement,
          currentFlowerFill,
          currentPetalToRadius,
          currentRatio,
          currentRandomiseAngle,
          currentPetalPointiness,
          currentPetalRotation,
          currentPetalRotationRatio,
          currentPetalType,
          currentMaxPetals,
          currentRadialOscAmplitude,
          currentRadialOscPeriod,
          currentDirection,
          currentBackgroundColour,
          currentLineColour,
          currentLineWidth,
          currentRandomColours,
          currentNumberOfColours,
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
    double currentRandomiseAngle,
    double currentPetalPointiness,
    double currentPetalRotation,
    double currentPetalRotationRatio,
    String currentPetalType,
    int currentMaxPetals,
    double currentRadialOscAmplitude,
    double currentRadialOscPeriod,
    String currentDirection,
    Color currentBackgroundColour,
    Color currentLineColour,
    double currentLineWidth,
    bool currentRandomColours,
    int currentNumberOfColours,
    String currentPaletteType,
    double currentOpacity,
    List currentPalette,
  ) {
    angle = angle + (rnd.nextDouble() - 0.5) * currentRandomiseAngle;

    radius = radius +
        radius *
            (sin(currentRadialOscPeriod * angle) + 1) *
            currentRadialOscAmplitude;

    switch (currentPetalType) {
      case 'circle': //"circle":

        List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
        var petalRadius = radius * currentPetalToRadius;

        canvas.drawCircle(
            Offset(P1[0], P1[1]),
            petalRadius,
            Paint()
              ..style = PaintingStyle.fill
              ..color = colour);
        canvas.drawCircle(
            Offset(P1[0], P1[1]),
            petalRadius,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColour);

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
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColour);
        canvas.drawPath(
            triangle,
            Paint()
              ..style = PaintingStyle.fill
              ..color = colour);

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
                      currentPetalPointiness),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.0 +
                      currentPetalPointiness)
        ];
        List PB = [
          P1[0] +
              petalRadius *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.5 -
                      currentPetalPointiness),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.5 -
                      currentPetalPointiness)
        ];
        List PC = [
          P1[0] +
              petalRadius *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.0 +
                      currentPetalPointiness),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.0 +
                      currentPetalPointiness)
        ];
        List PD = [
          P1[0] +
              petalRadius *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.5 -
                      currentPetalPointiness),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.5 -
                      currentPetalPointiness)
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
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColour);
        canvas.drawPath(
            square,
            Paint()
              ..style = PaintingStyle.fill
              ..color = colour);

        break;

      case 'petal': //"petal":

        List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
        double petalRadius = radius * currentPetalToRadius;

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
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.5),
          P1[1] +
              petalRadius *
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
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.5),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.5)
        ];

        canvas.drawArc(
            Offset(PB[0] - petalRadius * 2, PB[1] - petalRadius * 2) &
                Size(petalRadius * 4, petalRadius * 4),
            angle +
                currentPetalRotation +
                angle * currentPetalRotationRatio +
                pi * (0.5 + 2 / 3),
            pi * 2 / 3,
            false,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColour);

        canvas.drawArc(
            Offset(PB[0] - petalRadius * 2, PB[1] - petalRadius * 2) &
                Size(petalRadius * 4, petalRadius * 4),
            angle +
                currentPetalRotation +
                angle * currentPetalRotationRatio +
                pi * (0.5 + 2 / 3),
            pi * 2 / 3,
            false,
            Paint()
              ..style = PaintingStyle.fill
              ..color = colour);

        canvas.drawArc(
            Offset(PD[0] - petalRadius * 2, PD[1] - petalRadius * 2) &
                Size(petalRadius * 4, petalRadius * 4),
            angle +
                currentPetalRotation +
                angle * currentPetalRotationRatio +
                pi * (1.5 + 2 / 3),
            pi * 2 / 3,
            false,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentLineWidth
              ..color = currentLineColour);

        canvas.drawArc(
            Offset(PD[0] - petalRadius * 2, PD[1] - petalRadius * 2) &
                Size(petalRadius * 4, petalRadius * 4),
            angle +
                currentPetalRotation +
                angle * currentPetalRotationRatio +
                pi * (1.5 + 2 / 3),
            pi * 2 / 3,
            false,
            Paint()
              ..style = PaintingStyle.fill
              ..color = colour);

        break;
    }
  }

  @override
  bool shouldRepaint(OpArtFibonacciPainter oldDelegate) => false;
}
