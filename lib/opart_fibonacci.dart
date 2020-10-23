import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'package:shake/shake.dart';
import 'package:opart_v2/setting_button.dart';
import 'package:opart_v2/setting_slider.dart';
import 'package:opart_v2/setting_intslider.dart';
import 'package:opart_v2/setting_dropdown.dart';
import 'package:opart_v2/setting_colorpicker.dart';
import 'package:opart_v2/setting_radiobutton.dart';
import 'bottom_app_bar_custom.dart';
import 'opart_model.dart';
import 'palettes.dart';

import 'package:screenshot/screenshot.dart';

Random rnd;
final number = new ValueNotifier(0);
// Settings
Fibonacci currentFibonacci;

// Load the palettes
List palettes = defaultPalettes();
String currentNamedPalette;


class Fibonacci {
  // image settings

  SettingsModelDouble angleIncrement = SettingsModelDouble(
      label: 'Angle Increment',
      tooltip: 'The angle in radians between successive petals of the flower',
      min: 0,
      max: 2 * pi,
      zoom: 2000,
      defaultValue: (sqrt(5) + 1) / 2,
      icon: Icon(Icons.track_changes));
  SettingsModelDouble flowerFill = SettingsModelDouble(
      label: 'Zoom',
      tooltip: 'Zoom in and out',
      min: 0.3,
      max: 2,
      zoom: 100,
      defaultValue: 1.8,
      icon: Icon(Icons.zoom_in));
  SettingsModelDouble petalToRadius = SettingsModelDouble(
      label: 'Petal Size',
      tooltip:
          'The size of the petal as a multiple of its distance from the centre',
      min: 0.01,
      max: 0.5,
      zoom: 100,
      defaultValue: 0.3,
      icon: Icon(Icons.swap_horizontal_circle));
  SettingsModelDouble ratio = SettingsModelDouble(
      label: 'Fill Ratio',
      tooltip: 'The fill ratio of the flower',
      min: 0.995,
      max: 0.9999,
      zoom: 100,
      defaultValue: 0.999,
      icon: Icon(Icons.format_color_fill));
  SettingsModelDouble randomiseAngle = SettingsModelDouble(
      label: 'Randomise Angle',
      tooltip:
          'Randomise the petal position by moving it around the centre by a random angle up to this maximum',
      min: 0,
      max: 0.2,
      zoom: 100,
      defaultValue: 0,
      icon: Icon(Icons.ac_unit));
  SettingsModelDouble petalPointiness = SettingsModelDouble(
      label: 'Petal Pointiness',
      tooltip: 'the pointiness of the petal',
      min: 0,
      max: pi / 2,
      zoom: 200,
      defaultValue: 0.8,
      icon: Icon(Icons.change_history));
  SettingsModelDouble petalRotation = SettingsModelDouble(
      label: 'Petal Rotation',
      tooltip: 'the rotation of the petal',
      min: 0,
      max: pi,
      zoom: 200,
      defaultValue: 0,
      icon: Icon(Icons.rotate_right));
  SettingsModelDouble petalRotationRatio = SettingsModelDouble(
      label: 'Rotation Ratio',
      tooltip: 'the rotation of the petal as multiple of the petal angle',
      min: 0,
      max: 4,
      zoom: 100,
      defaultValue: 0,
      icon: Icon(Icons.autorenew));

  SettingsModelList petalType = SettingsModelList(
    label: "Petal Type",
    tooltip: "The shape of the petal",
    defaultValue: "petal",
    icon: Icon(Icons.local_florist),
    options: <String>['circle', 'triangle', 'square', 'petal'],
  );

  SettingsModelInt maxPetals = SettingsModelInt(
      label: 'Max Petals',
      tooltip: 'The maximum number of petals to draw',
      min: 0,
      max: 20000,
      defaultValue: 10000,
      icon: Icon(Icons.fiber_smart_record));

  SettingsModelDouble radialOscAmplitude = SettingsModelDouble(
      label: 'Radial Oscillation',
      tooltip: 'The amplitude of the radial oscillation',
      min: 0,
      max: 5,
      zoom: 100,
      defaultValue: 0,
      icon: Icon(Icons.all_inclusive));
  SettingsModelDouble radialOscPeriod = SettingsModelDouble(
      label: 'Oscillation Period',
      tooltip: 'The period of the radial oscillation',
      min: 0,
      max: 2,
      zoom: 100,
      defaultValue: 0,
      icon: Icon(Icons.bubble_chart));

  SettingsModelList direction = SettingsModelList(
    label: "Direction",
    tooltip:
        "Start from the outside and draw Inward, or start from the centre and draw Outward",
    defaultValue: "inward",
    icon: Icon(Icons.directions),
    options: <String>['inward', 'outward'],
  );

// palette settings
  SettingsModelColor backgroundColor = SettingsModelColor(
    label: "Background Color",
    tooltip: "The background colour for the canvas",
    defaultValue: Colors.white,
    icon: Icon(Icons.settings_overscan),
  );
  SettingsModelColor lineColor = SettingsModelColor(
    label: "Outline Color",
    tooltip: "The outline colour for the petals",
    defaultValue: Colors.white,
    icon: Icon(Icons.zoom_out_map),
  );

  SettingsModelDouble lineWidth = SettingsModelDouble(
      label: 'Outline Width',
      tooltip: 'The width of the petal outline',
      min: 0,
      max: 3,
      zoom: 100,
      defaultValue: 0,
      icon: Icon(Icons.line_weight));

  SettingsModelBool randomColors = SettingsModelBool(
      label: 'Random Colors',
      tooltip: 'Randomise the coloursl',
      defaultValue: false,
      icon: Icon(Icons.gamepad));

  SettingsModelInt numberOfColors = SettingsModelInt(
      label: 'Number of Colors',
      tooltip: 'The number of colours in the palette',
      min: 1,
      max: 36,
      defaultValue: 10,
      icon: Icon(Icons.palette));

  SettingsModelList paletteType = SettingsModelList(
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
  );

  SettingsModelList paletteList = SettingsModelList(
    label: "Palette",
    tooltip: "Choose from a list of palettes",
    defaultValue: "Default",
    icon: Icon(Icons.palette),
    options: defaultPalleteNames(),
  );

  SettingsModelDouble opacity = SettingsModelDouble(
      label: 'Opactity',
      tooltip: 'The opactity of the petal',
      min: 0.2,
      max: 1,
      zoom: 100,
      defaultValue: 1,
      icon: Icon(Icons.remove_red_eye));

  SettingsModelButton resetDefaults = SettingsModelButton(
      label: 'Reset Defaults',
      tooltip: 'Reset all settings to defaults',
      defaultValue: false,
      icon: Icon(Icons.low_priority)
  );


  List palette;
  double aspectRatio;
  File image;

// lock settings
  bool paletteLOCK = false;
  bool aspectRatioLOCK = false;

  //Random random;

  Fibonacci({
    // palette settings
    this.palette,
    this.aspectRatio = pi / 2,
    this.image,
    this.paletteLOCK = false,
    this.aspectRatioLOCK = false,
    //this.random,
  });

  void randomize() {
    print('-----------------------------------------------------');
    print('randomize');
    print('-----------------------------------------------------');

    rnd = Random(DateTime.now().millisecond);

    this.angleIncrement.randomise(rnd);
    this.flowerFill.randomise(rnd);
    this.petalToRadius.randomise(rnd);
    this.ratio.randomise(rnd);
    this.randomiseAngle.randomise(rnd);
    if (this.randomiseAngle.locked == false && rnd.nextDouble() > 0.2) {
      this.randomiseAngle.value = 0;
    }
    this.petalPointiness.randomise(rnd);
    this.petalRotation.randomise(rnd);
    this.petalRotation.randomise(rnd);
    if (this.petalRotation.locked == false && rnd.nextDouble() > 0.3) {
      this.petalRotationRatio.value = rnd.nextInt(4).toDouble();
    }
    this.petalType.randomise(rnd);
    this.maxPetals.randomise(rnd);
    this.radialOscAmplitude.randomise(rnd);
    if (this.radialOscAmplitude.locked == false && rnd.nextDouble() < 0.7) {
      this.radialOscAmplitude.value = 0;
    }
    this.radialOscPeriod.randomise(rnd);
    this.direction.randomise(rnd);

    if (this.aspectRatioLOCK == false) {
      // this.aspectRatio = rnd.nextDouble() + 0.5;
      // if (rnd.nextBool()){
      this.aspectRatio = pi / 2;
      // }
    }
  }

  void randomizePalette() {
    print('-----------------------------------------------------');
    print('randomizePalette');
    print('-----------------------------------------------------');

    rnd = Random(DateTime.now().millisecond);

    this.numberOfColors.randomise(rnd);
    this.randomColors.randomise(rnd);
    this.lineWidth.randomise(rnd);
    if (this.lineWidth.locked == false && rnd.nextBool()) {
      this.lineWidth.value = 0;
    }
    this.opacity.randomise(rnd);
    this.backgroundColor.randomise(rnd);
    this.lineColor.randomise(rnd);

    this.palette = randomisedPalette(
        this.paletteType.value, this.numberOfColors.value, rnd);
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
    this.backgroundColor.value = this.backgroundColor.defaultValue;
    this.lineColor.value = this.lineColor.defaultValue;

    this.lineWidth.value = this.lineWidth.defaultValue;
    this.randomColors.value = this.randomColors.defaultValue;
    this.numberOfColors.value = this.numberOfColors.defaultValue;
    this.paletteType.value = this.paletteType.defaultValue;
    this.opacity.value = this.opacity.defaultValue;

    this.paletteList.value = this.paletteList.defaultValue;
    this.resetDefaults.value = this.resetDefaults.defaultValue;


    this.palette = [
      Color(0xFF37A7BC),
      Color(0xFFB4B165),
      Color(0xFFA47EA4),
      Color(0xFF69ABCB),
      Color(0xFF79B38E),
      Color(0xFF17B8E0),
      Color(0xFFD1EFED),
      Color(0xFF151E2A),
      Color(0xFF725549),
      Color(0xFF074E71)
    ];

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
  currentFibonacci.backgroundColor,
  currentFibonacci.lineColor,
  currentFibonacci.lineWidth,
  currentFibonacci.numberOfColors,
  currentFibonacci.randomColors,
  currentFibonacci.paletteType,
  currentFibonacci.paletteList,
  currentFibonacci.resetDefaults,
];

class OpArtFibonacciStudio extends StatefulWidget {
  OpArtFibonacciStudio();

  @override
  _OpArtFibonacciStudioState createState() => _OpArtFibonacciStudioState();
}

class _OpArtFibonacciStudioState extends State<OpArtFibonacciStudio>
    with TickerProviderStateMixin {
  int _counter = 0;
  File _imageFile;

  int _currentColor = 0;

  // Animation<double> animation1;
  // AnimationController controller1;

  // Animation<double> animation2;
  // AnimationController controller2;

  cacheFibonacci() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => screenshotController
            .capture(delay: Duration(milliseconds: 100), pixelRatio: 0.2)
            .then((File image) async {
          currentFibonacci.image = image;
          Map<String, dynamic> currentCache = {
            'angleIncrement': currentFibonacci.angleIncrement.value,
            'ratio': currentFibonacci.ratio.value,
            'flowerFill': currentFibonacci.flowerFill.value,
            'opacity': currentFibonacci.opacity.value,
            'petalType': currentFibonacci.petalType.value,
            'petalPointiness': currentFibonacci.petalPointiness.value,
            'petalRotation': currentFibonacci.petalRotation.value,
            'petalRotationRatio': currentFibonacci.petalRotationRatio.value,
            'petalToRadius': currentFibonacci.petalToRadius.value,
            'radialOscAmplitude': currentFibonacci.radialOscAmplitude.value,
            'radialOscPeriod': currentFibonacci.radialOscPeriod.value,
            'randomiseAngle': currentFibonacci.randomiseAngle.value,
            'maxPetals': currentFibonacci.maxPetals.value,
            'direction': currentFibonacci.direction.value,
            'backgroundColor': currentFibonacci.backgroundColor.value,
            'lineColor': currentFibonacci.lineColor.value,
            'lineWidth': currentFibonacci.lineWidth.value,
            'numberOfColors': currentFibonacci.numberOfColors.value,
            'randomColors': currentFibonacci.randomColors.value,
            'paletteType': currentFibonacci.paletteType.value,
            'palette': currentFibonacci.palette,
            'paletteList': currentFibonacci.paletteList.value,
            'aspectRatio': currentFibonacci.aspectRatio,
            'image': image,
          };
          cachedFibonacciList.add(currentCache);
          number.value++;
          await new Future.delayed(const Duration(milliseconds: 20));
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
        }));



  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget bodyWidget() {
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
              // animation1.value,
              // animation2.value
            )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {



    Widget bodyWidget() {
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
                // animation1.value,
                // animation2.value
              )),
            ),
          ),
        ),
      );
    }

    void _showBottomSheetSettings(context, int index) {
      showDialog(
          //  backgroundColor: Colors.white.withOpacity(0.8),
          barrierColor: Colors.white.withOpacity(0.1),
          context: context,
          builder: (BuildContext bc) {
            return StatefulBuilder(
                builder: (BuildContext context, setLocalState) {
              return Center(
                child: AlertDialog(
                  backgroundColor: Colors.white.withOpacity(0.7),
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
                        settingsList[index].zoom,
                            (value) {
                          setState(() {
                            settingsList[index].value = value;
                          });
                          setLocalState((){});
                        },
                            (value) {
                          setState(() {
                            settingsList[index].locked = value;
                          });
                          setLocalState((){});
                        },
                            (){},
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
                            (value) {
                          setState(() {
                            settingsList[index].locked = value;
                          });
                          setLocalState((){});
                        },
                            (){},
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
                            (value) {
                          setState(() {
                            settingsList[index].locked = !settingsList[index].locked;
                          });
                        },

                      )
                          :
                      (settingsList[index].type == 'Color') ?

                      settingsColorPicker(
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
                            (value) {
                          setState(() {
                            settingsList[index].locked = value;
                          });
                          setLocalState((){});
                        },

                      )
                          :

                      (settingsList[index].type == 'Bool') ?

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
                            (value) {
                          setState(() {
                            settingsList[index].locked = value;
                          });
                          setLocalState((){});
                        },


                      )
                          :
                      settingsButton(
                        settingsList[index].label,
                        settingsList[index].tooltip,
                        settingsList[index].value,

                            () {
                          setState(() {
                            settingsList[index].value = true;
                          });
                          setLocalState((){});
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
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, childAspectRatio: 1.3),
                      itemCount: settingsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _showBottomSheetSettings(
                              context,
                              index,
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              settingsList[index].icon,
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    height: 40,
                                    child: Text(
                                      settingsList[index].label,
                                      textAlign: TextAlign.center,
                                    )),
                              )
                            ],
                          ),
                        );
                      }),
                ));
          });
    }

    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        child: GestureDetector(
          onVerticalDragUpdate: (value) {
            _showBottomSheet(context);
          },
          child: CustomBottomAppBar(randomise: () {
            setState(() {
              currentFibonacci.randomize();
              currentFibonacci.randomizePalette();
              cacheFibonacci();
            });
          }, randomisePalette: () {
            setState(() {
              currentFibonacci.randomizePalette();
              cacheFibonacci();
            });
          }, showBottomSheet: () {
            _showBottomSheet(context);
          }),
        ),
      ),
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 60,
              child: ValueListenableBuilder<int>(
                  valueListenable: number,
                  builder: (context, value, child) {

                    return cachedFibonacciList.length == 0
                        ? Container()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            itemCount: cachedFibonacciList.length,
                            reverse: false,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print('---------------------------------------------------------------------');
                                      print('Selected from history');
                                      print('index: $index');
                                      print('---------------------------------------------------------------------');
                                      print('cachedFibonacciList[index]: ${cachedFibonacciList[index]}');

                                      currentFibonacci.angleIncrement.value = cachedFibonacciList[index]['angleIncrement'];
                                      currentFibonacci.ratio.value = cachedFibonacciList[index]['ratio'];
                                      currentFibonacci.maxPetals.value = cachedFibonacciList[index]['maxPetals'];
                                      currentFibonacci.direction.value = cachedFibonacciList[index]['direction'];
                                      currentFibonacci.flowerFill.value = cachedFibonacciList[index]['flowerFill'];

                                      currentFibonacci.flowerFill.value =cachedFibonacciList[index]['flowerFill'];
                                      currentFibonacci.opacity.value = cachedFibonacciList[index]['opacity'];
                                      currentFibonacci.petalType.value = cachedFibonacciList[index]['petalType'];
                                      currentFibonacci.petalPointiness.value = cachedFibonacciList[index]['petalPointiness'];

                                      currentFibonacci.petalRotation.value = cachedFibonacciList[index]['petalRotation'];
                                      currentFibonacci.petalRotationRatio.value = cachedFibonacciList[index]['petalRotationRatio'];
                                      currentFibonacci.petalToRadius.value = cachedFibonacciList[index]['petalToRadius'];

                                      currentFibonacci.radialOscAmplitude.value = cachedFibonacciList[index]['radialOscAmplitude'];
                                      currentFibonacci.radialOscPeriod.value = cachedFibonacciList[index]['radialOscPeriod'];
                                      currentFibonacci.randomiseAngle.value = cachedFibonacciList[index]['randomiseAngle'];
                                      currentFibonacci.maxPetals.value = cachedFibonacciList[index]['maxPetals'];
                                      currentFibonacci.direction.value = cachedFibonacciList[index]['direction'];

                                      currentFibonacci.backgroundColor.value = cachedFibonacciList[index]['backgroundColor'];
                                      currentFibonacci.lineColor.value = cachedFibonacciList[index]['lineColor'];

                                      currentFibonacci.lineWidth.value = cachedFibonacciList[index]['lineWidth'];
                                      currentFibonacci.numberOfColors.value = cachedFibonacciList[index]['numberOfColors'];
                                      currentFibonacci.randomColors.value = cachedFibonacciList[index]['randomColors'];
                                      currentFibonacci.paletteType.value = cachedFibonacciList[index]['paletteType'];
                                      currentFibonacci.palette = cachedFibonacciList[index]['palette'];
                                      currentFibonacci.aspectRatio = cachedFibonacciList[index]['aspectRatio'];
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    width: 50,
                                    height: 50,
                                    child: Image.file(
                                        cachedFibonacciList[index]['image']),
                                  ),
                                ),
                              );
                            },
                          );
                  })),
          Expanded(child: ClipRect(child: bodyWidget())),
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
        cacheFibonacci();
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

    cacheFibonacci();
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

    // Initialise the palette
    if (currentFibonacci == null) {
      currentFibonacci = new Fibonacci();
      currentFibonacci.defaultSettings();
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
      currentFibonacci.randomizePalette();
    }

    // reset the defaults
    if (currentFibonacci.resetDefaults.value == true){
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
    double currentRandomiseAngle,
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
    print('BackgroundColor: $currentBackgroundColor');
    print('LineColor: $currentLineColor');
    print('LineWidth: $currentLineWidth');
    print('RandomColors: $currentRandomColors');
    print('NumberOfColors: $currentNumberOfColors');
    print('PaletteType: $currentPaletteType');
    print('Opacity: $currentOpacity');
    print('palette $currentPalette');

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
          currentRandomiseAngle,
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
    double currentRandomiseAngle,
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
    angle = angle + (rnd.nextDouble() - 0.5) * currentRandomiseAngle;

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
          P1[0] + petalRadius * cos(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 0.0 + currentPetalPointiness + pi / 4),
          P1[1] + petalRadius * sin(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 0.0 + currentPetalPointiness + pi / 4)
                  ];

        List PB = [
          P1[0] + petalRadius * cos(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 0.5 - currentPetalPointiness - pi / 4),
          P1[1] + petalRadius * sin(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 0.5 - currentPetalPointiness - pi / 4)
        ];

        List PC = [
          P1[0] + petalRadius * cos(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 1.0 + currentPetalPointiness + pi / 4),
          P1[1] + petalRadius * sin(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 1.0 + currentPetalPointiness + pi / 4)
        ];

        List PD = [
          P1[0] + petalRadius * cos(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 1.5 - currentPetalPointiness - pi / 4),
          P1[1] + petalRadius * sin(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 1.5 - currentPetalPointiness - pi / 4)
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
          P1[0] + petalRadius * cos(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 0.0),
          P1[1] + petalRadius * sin(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 0.0)
        ];

        List PB = [
          P1[0] + petalRadius * currentPetalPointiness * cos(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 0.5),
          P1[1] + petalRadius * currentPetalPointiness * sin(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 0.5)
        ];

        List PC = [
          P1[0] + petalRadius * cos(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 1.0),
          P1[1] + petalRadius * sin(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 1.0)
        ];

        List PD = [
          P1[0] + petalRadius * currentPetalPointiness * cos(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 1.5),
          P1[1] + petalRadius * currentPetalPointiness * sin(angle + currentPetalRotation + angle * currentPetalRotationRatio + pi * 1.5)
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
