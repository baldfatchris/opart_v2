import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'package:screenshot/screenshot.dart';
import 'package:shake/shake.dart';
import 'package:opart_v2/setting_slider.dart';
import 'package:opart_v2/setting_intslider.dart';
import 'package:opart_v2/setting_dropdown.dart';
import 'package:opart_v2/setting_colorpicker.dart';
import 'package:opart_v2/setting_radiobutton.dart';
import 'model.dart';

Random rnd;

// Settings
Fibonacci currentFibonacci;

List Palettes = [
  ['default', 10, Color(0xFFffffff), [Color(0xFF34a1af), Color(0xFFa570a8), Color(0xFFd6aa27), Color(0xFF5f9d50), Color(0xFF789dd1), Color(0xFFc25666), Color(0xFF2b7b1), Color(0xFFd63aa), Color(0xFF1f4ed), Color(0xFF383c47)]],
];

class Fibonacci {
  // image settings

  SettingsModelDouble angleIncrement = SettingsModelDouble(label: 'Angle Increment', tooltip: 'The angle in radians between successive petals of the flower', min: 0, max: 2 * pi, defaultValue: (sqrt(5) + 1) / 2, icon: Icon(Icons.ac_unit));
  SettingsModelDouble flowerFill = SettingsModelDouble(label: 'Zoom', tooltip: 'Zoom in and out', min: 0.3, max: 2, defaultValue: 1, icon: Icon(Icons.access_alarm));
  SettingsModelDouble petalToRadius = SettingsModelDouble(label: 'Petal Size', tooltip: 'The size of the petal as a multiple of its distance from the centre', min: 0.01, max: 0.1, defaultValue: 0.03,icon: Icon(Icons.zoom_in));
  SettingsModelDouble ratio = SettingsModelDouble(label: 'Ratio', tooltip: 'The fill ratio of the flower', min: 0.995, max: 0.9999, defaultValue: 0.999, icon: Icon(Icons.adjust));
  SettingsModelDouble randomiseAngle = SettingsModelDouble(
      label: 'Randomise Angle',
      tooltip:
          'Randomise the petal position by moving it around the centre by a random angle up to this maximum',
      min: 0,
      max: 0.2,
      defaultValue: 0,
      icon: Icon(Icons.all_inclusive));
  SettingsModelDouble petalPointiness = SettingsModelDouble(
      label: 'Petal Pointiness',
      tooltip: 'the pointiness of the petal',
      min: 0,
      max: pi/2,
      defaultValue: 0.8,
      icon: Icon(Icons.account_circle));
  SettingsModelDouble petalRotation = SettingsModelDouble(
      label: 'Petal Rotation',
      tooltip: 'the rotation of the petal',
      min: 0,
      max: pi,
      defaultValue: 0,
      icon: Icon(Icons.all_out));
  SettingsModelDouble petalRotationRatio = SettingsModelDouble(
      label: 'Rotation Ratio',
      tooltip: 'the rotation of the petal as multiple of the petal angle',
      min: 0,
      max: 4,
      defaultValue: 0,
      icon: Icon(Icons.autorenew));

  SettingsModelList petalType = SettingsModelList(label: "Petal Type", tooltip: "The shape of the petal", defaultValue: "circle", icon: Icon(Icons.format_shapes), options: ['circle', 'triangle', 'square', 'petal'],);

  SettingsModelInt maxPetals = SettingsModelInt(label: 'Max Petals', tooltip: 'The maximum number of petals to draw', min: 0, max: 20000, defaultValue: 10000, icon: Icon(Icons.fiber_smart_record));

  SettingsModelDouble radialOscAmplitude = SettingsModelDouble(
      label: 'Radial Oscillation',
      tooltip: 'The amplitude of the radial oscillation',
      min: 0,
      max: 5,
      defaultValue: 0,
      icon: Icon(Icons.bluetooth_audio));
  SettingsModelDouble radialOscPeriod = SettingsModelDouble(
      label: 'Oscillation Period',
      tooltip: 'The period of the radial oscillation',
      min: 0,
      max: 2,
      defaultValue: 0,
      icon: Icon(Icons.bubble_chart));

  SettingsModelList direction = SettingsModelList(label: "Direction", tooltip: "Start from the outside and draw Inward, or start from the centre and draw Outward", defaultValue: "inward", icon: Icon(Icons.zoom_out_map), options: ['inward', 'outward'], );

// palette settings
  SettingsModelColour backgroundColour = SettingsModelColour(label: "Background Colour", tooltip: "The background colour for the canvas", defaultValue: Colors.white, icon: Icon(Icons.zoom_out_map), );
  SettingsModelColour lineColour = SettingsModelColour(label: "Outline Colour", tooltip: "The outline colour for the petals", defaultValue: Colors.white, icon: Icon(Icons.zoom_out_map), );

  SettingsModelDouble lineWidth = SettingsModelDouble(
      label: 'Outline Width',
      tooltip: 'The width of the petal outline',
      min: 0,
      max: 3,
      defaultValue: 0,
      icon: Icon(Icons.line_weight));

  SettingsModelBool randomColours = SettingsModelBool(
      label: 'Random Colours',
      tooltip: 'Randomise the coloursl',
      defaultValue: false,
      icon: Icon(Icons.gamepad));

  SettingsModelInt numberOfColours = SettingsModelInt(
      label: 'Number of Colours',
      tooltip: 'The number of colours in the palette',
      min: 1,
      max: 36,
      defaultValue: 10,
      icon: Icon(Icons.palette));

  SettingsModelList paletteType = SettingsModelList(label: "Palette Type", tooltip: "The nature of the palette", defaultValue: "random", icon: Icon(Icons.colorize), options: ['random', 'blended random ', 'linear random', 'linear complementary'],);

  SettingsModelDouble opacity = SettingsModelDouble(
      label: 'Opactity',
      tooltip: 'The opactity of the petal',
      min: 0,
      max: 1,
      defaultValue: 1,
      icon: Icon(Icons.opacity));

  List palette;
  double aspectRatio;
  File image;

// lock settings
  bool paletteLOCK = false;
  bool aspectRatioLOCK = false;

  Random random;

  Fibonacci({

    // palette settings
    this.palette,
    this.aspectRatio = pi / 2,
    this.image,

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

    // petalToRadius - 0 01 to 0.5
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
    this.petalType.randomise(random);

    // maxPetals = 5000 to 10000;
    this.maxPetals.randomise(random);

    // radialOscAmplitude 0 to 5
    this.radialOscAmplitude.randomise(random);
    if (this.radialOscAmplitude.locked == false && random.nextDouble() < 0.7) {
      this.radialOscAmplitude.value = 0;
    }

    // radialOscPeriod 0 to 2
    this.radialOscPeriod.randomise(random);

    // direction
    this.direction.randomise(random);

    if (this.aspectRatioLOCK == false) {
      // this.aspectRatio = random.nextDouble() + 0.5;
      // if (random.nextBool()){
      this.aspectRatio = pi / 2;
      // }
    }

    // numberOfColours 1 to 36
    this.numberOfColours.randomise(random);

    // randomColours
    this.randomColours.randomise(random);

    // lineWidth 0 to 3
    this.lineWidth.randomise(random);
    if (this.lineWidth.locked == false && rnd.nextBool()) {
      this.lineWidth.value = 0;
    }

    // opacity 0 to 1
    this.opacity.randomise(random);

    // backgroundColour
    this.backgroundColour.randomise(random);
  }

  void randomizePalette() {
    print('-----------------------------------------------------');
    print('randomizePalette');
    print('-----------------------------------------------------');

    rnd = Random(DateTime.now().millisecond);

    // lineColour
    this.lineColour.randomise(random);

    int numberOfColours = this.numberOfColours.value;

    List palette = [];
    switch (this.paletteType.value) {

      // blended random
      case 'blended random':
        {
          double blendColour = rnd.nextDouble() * 0xFFFFFF;
          for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++) {
            palette.add(Color(((blendColour + rnd.nextDouble() * 0xFFFFFF) / 2).toInt()).withOpacity(1));
          }
        }
        break;

      // linear random
      case 'linear random':
        {
          List startColour = [rnd.nextInt(255), rnd.nextInt(255), rnd.nextInt(255)];
          List endColour = [rnd.nextInt(255), rnd.nextInt(255), rnd.nextInt(255)];
          for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++) {
            palette.add(Color.fromRGBO(
                ((startColour[0] * colourIndex + endColour[0] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                ((startColour[1] * colourIndex + endColour[1] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                ((startColour[2] * colourIndex + endColour[2] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                1));
          }
        }
        break;

      // linear complementary
      case 'linear complementary':
        {
          List startColour = [rnd.nextInt(255), rnd.nextInt(255), rnd.nextInt(255)];
          List endColour = [255 - startColour[0], 255 - startColour[1], 255 - startColour[2]];
          for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++) {
            palette.add(Color.fromRGBO(
                ((startColour[0] * colourIndex + endColour[0] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                ((startColour[1] * colourIndex + endColour[1] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                ((startColour[2] * colourIndex + endColour[2] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                1));
          }
        }
        break;

      // random
      default:
        {
          for (int colorIndex = 0;
              colorIndex < numberOfColours;
              colorIndex++) {
            palette.add(
                Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1));
          }
        }
        break;
    }

    this.palette = palette;
  }

  void defaultSettings() {
    // resets to default settings

    this.angleIncrement.value = this.angleIncrement.defaultValue;
    this.flowerFill.value = this.flowerFill.defaultValue;
    this.petalToRadius.value = this.petalToRadius.defaultValue;
    this.ratio.value = this.ratio.defaultValue;
    this.randomiseAngle.value = this.randomiseAngle.defaultValue;
    this.petalPointiness.value = this.petalPointiness.defaultValue;
    this.petalRotation.value = this.petalRotation.defaultValue;
    this.petalRotationRatio.value = this.petalRotationRatio.defaultValue;
    this.petalType.value = this.petalType.defaultValue;
    this.maxPetals.value = this.maxPetals.defaultValue;
    this.radialOscAmplitude.value = this.radialOscAmplitude.defaultValue;
    this.radialOscPeriod.value = this.radialOscPeriod.defaultValue;
    this.direction.value = this.direction.defaultValue;

    // palette settings
    this.backgroundColour.value = this.backgroundColour.defaultValue;
    this.lineColour.value = this.lineColour.defaultValue;

    this.lineWidth.value = this.lineWidth.defaultValue;
    this.randomColours.value = this.randomColours.defaultValue;
    this.numberOfColours.value = this.numberOfColours.defaultValue;
    this.paletteType.value = this.paletteType.defaultValue;

    this.opacity.value = this.opacity.defaultValue;

    this.palette = [Color(0xFF34a1af), Color(0xFFa570a8), Color(0xFFd6aa27), Color(0xFF5f9d50), Color(0xFF789dd1), Color(0xFFc25666), Color(0xFF2b7b1), Color(0xFFd63aa), Color(0xFF1f4ed), Color(0xFF383c47)];
    this.aspectRatio = pi / 2;

    this.image;

    this.paletteLOCK = false;
    this.aspectRatioLOCK = false;
  }
}

List settingsList = [
  currentFibonacci.angleIncrement,
  currentFibonacci.ratio,
  currentFibonacci.flowerFill,
  currentFibonacci.opacity,
  currentFibonacci.petalType,
  currentFibonacci.petalPointiness,
  currentFibonacci.petalRotation,
  currentFibonacci.petalRotationRatio,
  currentFibonacci.petalToRadius,
  currentFibonacci.radialOscAmplitude,
  currentFibonacci.radialOscPeriod,
  currentFibonacci.randomiseAngle,
  currentFibonacci.maxPetals,
  currentFibonacci.direction,
  currentFibonacci.backgroundColour,
  currentFibonacci.lineColour,
  currentFibonacci.lineWidth,
  currentFibonacci.numberOfColours,
  currentFibonacci.randomColours,
  currentFibonacci.paletteType,
];

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

  List<Map<String, dynamic>> cachedFibonacciList = [];
  cacheFibonacci(
      ScreenshotController screenshotController, Function SetState) async {
    print('cache fibonacci');
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 0.2)
        .then((File image) async {
      currentFibonacci.image = image;

      Map<String, dynamic> currentCache = {
        'maxPetals': currentFibonacci.maxPetals.value,
        'direction': currentFibonacci.direction.value,
        'backgroundColour': currentFibonacci.backgroundColour,
        'lineColour': currentFibonacci.lineColour,
        'numberOfColours': currentFibonacci.numberOfColours.value,
        'paletteType': currentFibonacci.paletteType.value,
        'palette': currentFibonacci.palette,
        'aspectRatio': currentFibonacci.aspectRatio,
        'image': currentFibonacci.image,
        'angleIncrement': currentFibonacci.angleIncrement.value,
        'flowerFill': currentFibonacci.flowerFill.value,
        'petalToRadius': currentFibonacci.petalToRadius.value,
        'ratio': currentFibonacci.ratio.value,
        'randomiseAngle': currentFibonacci.randomiseAngle.value,
        'petalPointiness': currentFibonacci.petalPointiness.value,
        'petalRotation': currentFibonacci.petalRotation.value,
        'petalType': currentFibonacci.petalType.value,
        'radialOscAmplitude': currentFibonacci.radialOscAmplitude.value,
        'radialOscPeriod': currentFibonacci.radialOscPeriod.value,
      };
      cachedFibonacciList.add(currentCache);
      SetState();
    });
  }

  ScrollController _scrollController = new ScrollController();
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
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    SetState() {
      setState(() {});
    }

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

    //Container(height: 400,
    //               child: Column(
    //                 children: <Widget>[
    //                   (settingsList[index].type == 'Double') ?
    //
    //                   settingsSlider(
    //                     settingsList[index].label,
    //                     settingsList[index].tooltip,
    //                     settingsList[index].value,
    //                     settingsList[index].min,
    //                     settingsList[index].max,
    //                     settingsList[index].locked,
    //                         (value) {
    //                       setState(() {
    //                         settingsList[index].value = value;
    //                       });
    //                       SetState();
    //                     },
    //                         () {
    //                       setState(() {
    //                         settingsList[index].locked = !settingsList[index].locked;
    //                       });
    //                     },(){},
    //                   )
    //                       :
    //                   (settingsList[index].type == 'Int') ?
    //
    //                   settingsIntSlider(
    //                       settingsList[index].label,
    //                       settingsList[index].tooltip,
    //                       settingsList[index].value,
    //                       settingsList[index].min,
    //                       settingsList[index].max,
    //                       settingsList[index].locked,
    //                           (value) {
    //                         setState(() {
    //                           settingsList[index].value = value.toInt();
    //                         });
    //                         SetState();
    //                       },
    //                           () {
    //                         setState(() {
    //                           settingsList[index].locked = !settingsList[index].locked;
    //                         });
    //                       }
    //                   )
    //                       :
    //                   (settingsList[index].type == 'List') ?
    //
    //                   settingsDropdown(
    //                     settingsList[index].label,
    //                     settingsList[index].tooltip,
    //                     settingsList[index].value,
    //                     settingsList[index].options,
    //                     settingsList[index].locked,
    //
    //                         (value) {
    //                       setState(() {
    //                         settingsList[index].value = value;
    //                       });
    //                       SetState();
    //                     },
    //                         () {
    //                       setState(() {
    //                         settingsList[index].locked = !settingsList[index].locked;
    //                       });
    //                     },
    //
    //                   )
    //                       :
    //                   settingsRadioButton(
    //                     settingsList[index].label,
    //                     settingsList[index].tooltip,
    //                     settingsList[index].value,
    //                     settingsList[index].locked,
    //
    //                         (value) {
    //                       setState(() {
    //                         settingsList[index].value = value.round();
    //                       });
    //                       SetState();
    //                     },
    //                         () {
    //                       setState(() {
    //                         settingsList[index].locked = !settingsList[index].locked;
    //                       });
    //                     },
    //
    //                   ),
    //
    //                 ],
    //               ),
    //             )
    void _showBottomSheetSettings(context, int index) {
      showDialog(
        //  backgroundColor: Colors.white.withOpacity(0.8),
          barrierColor: Colors.white.withOpacity(0.1),
          context: context,
          builder: (BuildContext bc) {
            return StatefulBuilder(
                builder: (BuildContext context, setLocalState) {
              return Center(
                child: AlertDialog(backgroundColor: Colors.white.withOpacity(0.7),
                  title: Text(settingsList[index].label),
                  content: Column(mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      (settingsList[index].type == 'Double') ?

                      settingsSlider(
                        settingsList[index].label,
                        settingsList[index].tooltip,
                        settingsList[index].value,
                        settingsList[index].min,
                        settingsList[index].max,
                        settingsList[index].locked,
                            (value) {
                          setState(() {
                            settingsList[index].value = value;
                          });
                          setLocalState((){});
                        },
                            () {
                          setState(() {
                            settingsList[index].locked = !settingsList[index].locked;
                          });
                        },(){},
                      )
                          :
                      (settingsList[index].type == 'Int') ?

                      settingsIntSlider(
                          settingsList[index].label,
                          settingsList[index].tooltip,
                          settingsList[index].value,
                          settingsList[index].min,
                          settingsList[index].max,
                          settingsList[index].locked,
                              (value) {
                            setState(() {
                              settingsList[index].value = value.toInt();
                            });
                            setLocalState((){});
                          },
                              () {
                            setState(() {
                              settingsList[index].locked = !settingsList[index].locked;
                            });
                          }
                      )
                          :
                      (settingsList[index].type == 'List') ?

                      settingsDropdown(
                        settingsList[index].label,
                        settingsList[index].tooltip,
                        settingsList[index].value,
                        settingsList[index].options,
                        settingsList[index].locked,

                            (value) {
                          setState(() {
                            settingsList[index].value = value;
                          });
                          setLocalState((){});
                        },
                            () {
                          setState(() {
                            settingsList[index].locked = !settingsList[index].locked;
                          });
                        },

                      )
                          :
                      (settingsList[index].type == 'Colour') ?

                      settingsColourPicker(
                        settingsList[index].label,
                        settingsList[index].tooltip,
                        settingsList[index].value,
                        settingsList[index].locked,

                            (value) {
                          setState(() {
                            settingsList[index].value = value;
                          });
                          setLocalState((){});
                        },
                            () {
                          setState(() {
                            settingsList[index].locked = !settingsList[index].locked;
                          });
                        },

                      )
                          :
                      settingsRadioButton(
                        settingsList[index].label,
                        settingsList[index].tooltip,
                        settingsList[index].value,
                        settingsList[index].locked,

                            (value) {
                          setState(() {
                            settingsList[index].value = value;
                          });
                          setLocalState((){});
                        },
                            () {
                          setState(() {
                            settingsList[index].locked = !settingsList[index].locked;
                          });
                        },

                      ),
                    ],
                  ),
                ),
              );
            });
          });
    }

    void _showBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
                height: 300,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemCount: settingsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 100,
                        width: 100,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _showBottomSheetSettings(context, index,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              settingsList[index].icon,
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 50,
                                    child: Text(
                                      settingsList[index].label,
                                      textAlign: TextAlign.center,
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    }));
          });
    }

    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      setState(() {
                        currentFibonacci.randomize();
                        currentFibonacci.randomizePalette();
                        cacheFibonacci(screenshotController, SetState);
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.refresh),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Randomise \nEverything',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )),
                GestureDetector(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.blur_circular),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Tools',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        currentFibonacci.randomizePalette();
                        cacheFibonacci(screenshotController, SetState);
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.palette),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Randomise \nPalette',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ),
      body: Stack(
        children: [
          bodyWidget(),
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 60,
              child: cachedFibonacciList.length == 0
                  ? Container()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: cachedFibonacciList.length,
                      shrinkWrap: true,
                      reverse: false,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentFibonacci.maxPetals = cachedFibonacciList[index]['maxPetals'];
                                currentFibonacci.direction = cachedFibonacciList[index]['direction'];
                                currentFibonacci.backgroundColour = cachedFibonacciList[index]['backgroundColour'];
                                currentFibonacci.lineColour = cachedFibonacciList[index]['lineColour'];
                                currentFibonacci.numberOfColours = cachedFibonacciList[index]['numberOfColours'];
                                currentFibonacci.paletteType = cachedFibonacciList[index]['paletteType'];
                                currentFibonacci.palette =  cachedFibonacciList[index]['palette'];
                                currentFibonacci.aspectRatio = cachedFibonacciList[index]['aspectRatio'];
                                currentFibonacci.image = cachedFibonacciList[index]['image'];
                                currentFibonacci.angleIncrement.value = cachedFibonacciList[index]['angleIncrement'];
                                currentFibonacci.flowerFill.value = cachedFibonacciList[index]['flowerFill'];
                                currentFibonacci.petalToRadius.value = cachedFibonacciList[index]['petalToRadius'];
                                currentFibonacci.ratio.value = cachedFibonacciList[index]['ratio'];
                                currentFibonacci.randomiseAngle.value = cachedFibonacciList[index]['randomiseAngle'];
                                currentFibonacci.petalPointiness.value = cachedFibonacciList[index]['petalPointiness'];
                                currentFibonacci.petalRotation.value = cachedFibonacciList[index]['petalRotation'];
                                currentFibonacci.petalType.value = cachedFibonacciList[index]['petalType'];
                                currentFibonacci.radialOscAmplitude.value = cachedFibonacciList[index]['radialOscAmplitude'];
                                currentFibonacci.radialOscPeriod.value = cachedFibonacciList[index]['radialOscPeriod'];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              width: 50,
                              height: 50,
                              child: Image.file(
                                  cachedFibonacciList[index]['image']),
                            ),
                          ),
                        );
                      },
                    )),
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
    if (currentFibonacci.numberOfColours.value >
        currentFibonacci.palette.length) {
      currentFibonacci.randomizePalette();
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
      currentFibonacci.petalType.value,
      currentFibonacci.maxPetals.value,
      currentFibonacci.radialOscAmplitude.value,
      currentFibonacci.radialOscPeriod.value,
      currentFibonacci.direction.value,
      currentFibonacci.backgroundColour.value,
      currentFibonacci.lineColour.value,
      currentFibonacci.lineWidth.value,
      currentFibonacci.randomColours.value,
      currentFibonacci.numberOfColours.value,
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

    print('canvasWidth: $canvasWidth');
    print('canvasHeight: $canvasHeight');
    print('imageWidth: $imageWidth');
    print('imageHeight: $imageHeight');
    print('borderX: $borderX');
    print('borderY: $borderY');
    print('flowerCentreX: $flowerCentreX');
    print('flowerCentreY: $flowerCentreY');
    print('AngleIncrement: $currentAngleIncrement');
    print('FlowerFill: $currentFlowerFill');
    print('PetalToRadius: $currentPetalToRadius');
    print('RandomiseAngle: $currentRandomiseAngle');
    print('PetalPointiness: $currentPetalPointiness');
    print('PetalRotation: $currentPetalRotation');
    print('PetalRotationRatio: $currentPetalRotationRatio');
    print('PetalType: $currentPetalType');
    print('MaxPetals: $currentMaxPetals');
    print('RadialOscAmplitude: $currentRadialOscAmplitude');
    print('RadialOscPeriod: $currentRadialOscPeriod');
    print('Direction: $currentDirection');
    print('BackgroundColour: $currentBackgroundColour');
    print('LineColour: $currentLineColour');
    print('LineWidth: $currentLineWidth');
    print('RandomColours: $currentRandomColours');
    print('NumberOfColours: $currentNumberOfColours');
    print('PaletteType: $currentPaletteType');
    print('Opacity: $currentOpacity');

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
        Color petalColor = nextColour.withOpacity(currentOpacity);

        print('P0: $P0');
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
        Color petalColor = nextColour.withOpacity(currentOpacity);

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
        if (currentLineWidth > 0) {
          canvas.drawCircle(
              Offset(P1[0], P1[1]),
              petalRadius,
              Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = currentLineWidth
                ..color = currentLineColour);
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
                ..color = currentLineColour);
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
                      currentPetalPointiness + pi/4),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.0 +
                      currentPetalPointiness + pi/4)
        ];
        List PB = [
          P1[0] +
              petalRadius *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.5 -
                      currentPetalPointiness - pi/4),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 0.5 -
                      currentPetalPointiness - pi/4)
        ];
        List PC = [
          P1[0] +
              petalRadius *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.0 +
                      currentPetalPointiness + pi/4),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.0 +
                      currentPetalPointiness + pi/4)
        ];
        List PD = [
          P1[0] +
              petalRadius *
                  cos(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.5 -
                      currentPetalPointiness - pi/4),
          P1[1] +
              petalRadius *
                  sin(angle +
                      currentPetalRotation +
                      angle * currentPetalRotationRatio +
                      pi * 1.5 -
                      currentPetalPointiness - pi/4)
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
                ..color = currentLineColour);
        }
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

        if (currentLineWidth > 0) {
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
        }
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

        if (currentLineWidth > 0) {
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
        }
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
