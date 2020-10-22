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
import 'opart_model.dart';
import 'palettes.dart';
import 'bottom_app_bar_custom.dart';

Random rnd;
final number = new ValueNotifier(0);
// Settings
Tree currentTree;

// Load the palettes
List palettes = defaultPalettes();
String currentNamedPalette;

class Tree {
  // image settings

  SettingsModelDouble trunkWidth = SettingsModelDouble(
      label: 'Trunk Width',
      tooltip: 'The width of the base of the trunk',
      min: 0,
      max: 50,
      zoom: 100,
      defaultValue: 20,
      icon: Icon(Icons.track_changes));
  SettingsModelDouble widthDecay = SettingsModelDouble(
      label: 'Trunk Decay ',
      tooltip: 'The rate at which the trunk width decays',
      min: 0.7,
      max: 1,
      zoom: 100,
      defaultValue: 0.8,
      icon: Icon(Icons.zoom_in));
  SettingsModelDouble segmentLength = SettingsModelDouble(
      label: 'Segment Length',
      tooltip: 'The length of the first segment of the trunk',
      min: 10,
      max: 100,
      zoom: 100,
      defaultValue: 50,
      icon: Icon(Icons.swap_horizontal_circle));
  SettingsModelDouble segmentDecay = SettingsModelDouble(
      label: 'Segment Decay',
      tooltip: 'The rate at which the length of each successive segment decays',
      min: 0.95,
      max: 1,
      zoom: 100,
      defaultValue: 0.92,
      icon: Icon(Icons.format_color_fill));
  SettingsModelDouble branch = SettingsModelDouble(
      label: 'Branch Ratio',
      tooltip: 'The proportion of segments that branch',
      min: 0.4,
      max: 1,
      zoom: 100,
      defaultValue: 0.7,
      icon: Icon(Icons.ac_unit));
  SettingsModelDouble angle = SettingsModelDouble(
      label: 'Branch Angle',
      tooltip: 'The angle of the branch',
      min: 0.1,
      max: 0.7,
      zoom: 100,
      defaultValue: 0.5,
      icon: Icon(Icons.rotate_right));
  SettingsModelDouble ratio = SettingsModelDouble(
      label: 'Angle Ratio',
      tooltip: 'The ratio of the branch',
      min: 0.5,
      max: 1.5,
      zoom: 100,
      defaultValue: 0.7,
      icon: Icon(Icons.rotate_right));
  SettingsModelDouble bulbousness = SettingsModelDouble(
      label: 'Bulbousness',
      tooltip: 'The bulbousness of each segment',
      min: 0,
      max: 2,
      zoom: 100,
      defaultValue: 1.5,
      icon: Icon(Icons.autorenew));
  SettingsModelInt maxDepth = SettingsModelInt(
      label: 'Max Depth',
      tooltip: 'The number of segments',
      min: 10,
      max: 28,
      defaultValue: 20,
      icon: Icon(Icons.fiber_smart_record));
  SettingsModelInt leavesAfter = SettingsModelInt(
      label: 'Leaves After',
      tooltip: 'The number of segments before leaves start to sprout',
      min: 0,
      max: 28,
      defaultValue: 5,
      icon: Icon(Icons.fiber_smart_record));
  SettingsModelDouble leafAngle = SettingsModelDouble(
      label: 'Branch Angle',
      tooltip: 'The angle of the leaf',
      min: 0.2,
      max: 0.8,
      zoom: 100,
      defaultValue: 0.5,
      icon: Icon(Icons.rotate_right));
  SettingsModelDouble leafLength = SettingsModelDouble(
      label: 'Leaf Length',
      tooltip: 'The fixed length of each leaf',
      min: 0,
      max: 20,
      zoom: 100,
      defaultValue: 8,
      icon: Icon(Icons.rotate_right));
  SettingsModelDouble randomLeafLength = SettingsModelDouble(
      label: 'Random Length',
      tooltip: 'The random length of each leaf',
      min: 0,
      max: 20,
      zoom: 100,
      defaultValue: 3,
      icon: Icon(Icons.rotate_right));
  SettingsModelDouble leafSquareness = SettingsModelDouble(
      label: 'Squareness',
      tooltip: 'The squareness leaf',
      min: 0,
      max: 3,
      zoom: 100,
      defaultValue: 1,
      icon: Icon(Icons.rotate_right));
  SettingsModelDouble leafDecay = SettingsModelDouble(
      label: 'Leaf Decay',
      tooltip: 'The rate at which the leaves decay along the branch',
      min: 0.9,
      max: 1,
      zoom: 100,
      defaultValue: 0.95,
      icon: Icon(Icons.rotate_right));

  SettingsModelList petalType = SettingsModelList(
    label: "Petal Type",
    tooltip: "The shape of the petal",
    defaultValue: "circle",
    icon: Icon(Icons.local_florist),
    options: ['circle', 'triangle', 'square', 'petal'],
  );

  SettingsModelList direction = SettingsModelList(
    label: "Direction",
    tooltip:
        "Start from the outside and draw Inward, or start from the centre and draw Outward",
    defaultValue: "inward",
    icon: Icon(Icons.directions),
    options: ['inward', 'outward'],
  );

// palette settings
  SettingsModelColor backgroundColor = SettingsModelColor(
    label: "Background Color",
    tooltip: "The background colour for the canvas",
    defaultValue: Colors.cyan[200],
    icon: Icon(Icons.settings_overscan),
  );
  SettingsModelColor trunkFillColor = SettingsModelColor(
    label: "Trunk Color",
    tooltip: "The fill colour of the trunk",
    defaultValue: Colors.grey,
    icon: Icon(Icons.settings_overscan),
  );
  SettingsModelColor trunkOutlineColor = SettingsModelColor(
    label: "Trunk Outline",
    tooltip: "The outline colour of the trunk",
    defaultValue: Colors.black,
    icon: Icon(Icons.settings_overscan),
  );
  SettingsModelDouble trunkStrokeWidth = SettingsModelDouble(
      label: 'Outline Width',
      tooltip: 'The width of the trunk outline',
      min: 0,
      max: 1,
      zoom: 100,
      defaultValue: 0.1,
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
    options: [
      'random',
      'blended random ',
      'linear random',
      'linear complementary'
    ],
  );
  SettingsModelDouble opacity = SettingsModelDouble(
      label: 'Opactity',
      tooltip: 'The opactity of the petal',
      min: 0.2,
      max: 1,
      zoom: 100,
      defaultValue: 1,
      icon: Icon(Icons.remove_red_eye));
  SettingsModelList paletteList = SettingsModelList(
    label: "Palette",
    tooltip: "Choose from a list of palettes",
    defaultValue: "Default",
    icon: Icon(Icons.palette),
    options: defaultPalleteNames(),
  );

  List palette;
  double aspectRatio;
  File image;

// lock settings
  bool paletteLOCK = false;
  bool aspectRatioLOCK = false;

  Random random;

  Tree({
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

    rnd = Random(DateTime.now().millisecond);

    this.trunkWidth.randomise(random);
    this.widthDecay.randomise(random);
    this.segmentLength.randomise(random);
    this.segmentDecay.randomise(random);
    this.branch.randomise(random);
    this.angle.randomise(random);
    this.ratio.randomise(random);
    this.bulbousness.randomise(random);
    this.maxDepth.randomise(random);
    this.leavesAfter.randomise(random);
    this.leafAngle.randomise(random);
    this.leafLength.randomise(random);
    this.randomLeafLength.randomise(random);
    this.leafSquareness.randomise(random);
    this.leafDecay.randomise(random);
    this.trunkStrokeWidth.randomise(random);

    //  this.paletteList.randomise(random);
  }

  void randomizePalette() {
    print('-----------------------------------------------------');
    print('randomizePalette');
    print('-----------------------------------------------------');

    rnd = Random(DateTime.now().millisecond);

    this.backgroundColor.randomise(random);
    this.trunkFillColor.randomise(random);
    this.trunkOutlineColor.randomise(random);
    this.randomColors.randomise(random);
    this.numberOfColors.randomise(random);
    this.paletteType.randomise(random);
    this.opacity.randomise(random);

    this.palette = randomisedPalette(
        this.paletteType.value, this.numberOfColors.value, rnd);
  }

  void defaultSettings() {
    // resets to default settings

    this.trunkWidth.value = this.trunkWidth.defaultValue;
    this.widthDecay.value = this.widthDecay.defaultValue;
    this.segmentLength.value = this.segmentLength.defaultValue;
    this.segmentDecay.value = this.segmentDecay.defaultValue;
    this.branch.value = this.branch.defaultValue;
    this.angle.value = this.angle.defaultValue;
    this.ratio.value = this.ratio.defaultValue;
    this.bulbousness.value = this.bulbousness.defaultValue;
    this.maxDepth.value = this.maxDepth.defaultValue;
    this.leavesAfter.value = this.leavesAfter.defaultValue;
    this.leafAngle.value = this.leafAngle.defaultValue;
    this.leafLength.value = this.leafLength.defaultValue;
    this.randomLeafLength.value = this.randomLeafLength.defaultValue;
    this.leafSquareness.value = this.leafSquareness.defaultValue;
    this.leafDecay.value = this.leafDecay.defaultValue;
    this.randomLeafLength.value = this.randomLeafLength.defaultValue;

    // palette settings
    this.backgroundColor.value = this.backgroundColor.defaultValue;
    this.trunkFillColor.value = this.trunkFillColor.defaultValue;
    this.trunkOutlineColor.value = this.trunkOutlineColor.defaultValue;
    this.trunkStrokeWidth.value = this.trunkStrokeWidth.defaultValue;

    this.randomColors.value = this.randomColors.defaultValue;
    this.numberOfColors.value = this.numberOfColors.defaultValue;
    this.paletteType.value = this.paletteType.defaultValue;
    this.paletteList.value = this.paletteList.defaultValue;

    this.opacity.value = this.opacity.defaultValue;

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
  currentTree.trunkWidth,
  currentTree.widthDecay,
  currentTree.segmentLength,
  currentTree.segmentDecay,
  currentTree.branch,
  currentTree.angle,
  currentTree.ratio,
  currentTree.bulbousness,
  currentTree.maxDepth,
  currentTree.leavesAfter,
  currentTree.leafAngle,
  currentTree.leafLength,
  currentTree.randomLeafLength,
  currentTree.leafSquareness,
  currentTree.leafDecay,
  currentTree.backgroundColor,
  currentTree.trunkFillColor,
  currentTree.trunkOutlineColor,
  currentTree.trunkStrokeWidth,
  currentTree.numberOfColors,
  currentTree.randomColors,
  currentTree.paletteType,
  currentTree.opacity,
  currentTree.paletteList,
];

class OpArtTreeStudio extends StatefulWidget {
  OpArtTreeStudio();

  @override
  _OpArtTreeStudioState createState() => _OpArtTreeStudioState();
}

class _OpArtTreeStudioState extends State<OpArtTreeStudio>
    with TickerProviderStateMixin {
  int _counter = 0;
  File _imageFile;

  int _currentColor = 0;

  // Animation<double> animation1;
  // AnimationController controller1;

  // Animation<double> animation2;
  // AnimationController controller2;

  cacheTree() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => screenshotController
            .capture(delay: Duration(milliseconds: 100), pixelRatio: 0.2)
            .then((File image) async {
          currentTree.image = image;
          Map<String, dynamic> currentCache = {
            'aspectRatio': currentTree.aspectRatio,
            'trunkWidth': currentTree.trunkWidth.value,
            'widthDecay': currentTree.widthDecay.value,
            'segmentLength': currentTree.segmentLength.value,
            'segmentDecay': currentTree.segmentDecay.value,
            'branch': currentTree.branch.value,
            'angle': currentTree.angle.value,
            'ratio': currentTree.ratio.value,
            'bulbousness': currentTree.bulbousness.value,
            'maxDepth': currentTree.maxDepth.value,
            'leavesAfter': currentTree.leavesAfter.value,
            'leafAngle': currentTree.leafAngle.value,
            'leafLength': currentTree.leafLength.value,
            'randomLeafLength': currentTree.randomLeafLength.value,
            'leafSquareness': currentTree.leafSquareness.value,
            'leafDecay': currentTree.leafDecay.value,
            'backgroundColor': currentTree.backgroundColor.value,
            'trunkFillColor': currentTree.trunkFillColor.value,
            'trunkOutlineColor': currentTree.trunkOutlineColor.value,
            'trunkStrokeWidth': currentTree.trunkStrokeWidth.value,
            'randomColors': currentTree.randomColors.value,
            'numberOfColors': currentTree.numberOfColors.value,
            'paletteType': currentTree.paletteType.value,
            'opacity': currentTree.opacity.value,
            'image': currentTree.image,
          };
          cachedTreeList.add(currentCache);
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
      child: Stack(
        children: [
          Visibility(
            visible: true,
            child: LayoutBuilder(
              builder: (_, constraints) => Container(
                width: constraints.widthConstraints().maxWidth,
                height: constraints.heightConstraints().maxHeight,
                child: CustomPaint(
                    painter: OpArtTreePainter(
                  seed, rnd,
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
                      painter: OpArtTreePainter(
                    seed, rnd,
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
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      (settingsList[index].type == 'Double')
                          ? settingsSlider(
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
                                setLocalState(() {});
                              },
                              (value) {
                                setState(() {
                                  settingsList[index].locked = value;
                                });
                                setLocalState(() {});
                              },
                              () {},
                            )
                          : (settingsList[index].type == 'Int')
                              ? settingsIntSlider(
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
                                    setLocalState(() {});
                                  },
                                  (value) {
                                    setState(() {
                                      settingsList[index].locked = value;
                                    });
                                    setLocalState(() {});
                                  },
                                  () {},
                                )
                              : (settingsList[index].type == 'List')
                                  ? settingsDropdown(
                                      settingsList[index].label,
                                      settingsList[index].tooltip,
                                      settingsList[index].value,
                                      settingsList[index].options,
                                      settingsList[index].locked,
                                      (value) {
                                        setState(() {
                                          settingsList[index].value = value;
                                        });
                                        setLocalState(() {});
                                      },
                                      (value) {
                                        setState(() {
                                          settingsList[index].locked =
                                              !settingsList[index].locked;
                                        });
                                      },
                                    )
                                  : (settingsList[index].type == 'Color')
                                      ? settingsColorPicker(
                                          settingsList[index].label,
                                          settingsList[index].tooltip,
                                          settingsList[index].value,
                                          settingsList[index].locked,
                                          (value) {
                                            setState(() {
                                              settingsList[index].value = value;
                                            });
                                            setLocalState(() {});
                                          },
                                          (value) {
                                            setState(() {
                                              settingsList[index].locked =
                                                  value;
                                            });
                                            setLocalState(() {});
                                          },
                                        )
                                      : settingsRadioButton(
                                          settingsList[index].label,
                                          settingsList[index].tooltip,
                                          settingsList[index].value,
                                          settingsList[index].locked,
                                          (value) {
                                            setState(() {
                                              settingsList[index].value = value;
                                            });
                                            setLocalState(() {});
                                          },
                                          (value) {
                                            setState(() {
                                              settingsList[index].locked =
                                                  value;
                                            });
                                            setLocalState(() {});
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
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                  height: 350,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemCount: settingsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 10,
                          width: 10,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              _showBottomSheetSettings(
                                context,
                                index,
                              );
                            },
                            child: Column(
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
                          ),
                        );
                      })),
            );
          });
    }

    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: GestureDetector(
          onVerticalDragUpdate: (value) {
            _showBottomSheet(context);
          },
          child: CustomBottomAppBar(randomise: () {
            setState(() {
              currentTree.randomize();
              currentTree.randomizePalette();
              cacheTree();
            });
          }, randomisePalette: () {
            setState(() {
              currentTree.randomizePalette();
              cacheTree();
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
                    print('***********rebuilding');
                    return cachedTreeList.length == 0
                      ? Container()
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          itemCount: cachedTreeList.length,
                          shrinkWrap: true,
                          reverse: false,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentTree.trunkWidth.value =
                                        cachedTreeList[index]['trunkWidth'];
                                    currentTree.widthDecay.value =
                                        cachedTreeList[index]['widthDecay'];
                                    currentTree.segmentLength.value =
                                        cachedTreeList[index]['segmentLength'];
                                    currentTree.segmentDecay.value =
                                        cachedTreeList[index]['segmentDecay'];
                                    currentTree.branch.value =
                                        cachedTreeList[index]['branch'];
                                    currentTree.angle.value =
                                        cachedTreeList[index]['angle'];
                                    currentTree.ratio.value =
                                        cachedTreeList[index]['ratio'];
                                    currentTree.bulbousness.value =
                                        cachedTreeList[index]['bulbousness'];
                                    currentTree.image =
                                        cachedTreeList[index]['image'];
                                    currentTree.maxDepth.value =
                                        cachedTreeList[index]['maxDepth'];
                                    currentTree.leavesAfter.value =
                                        cachedTreeList[index]['leavesAfter'];
                                    currentTree.leafAngle.value =
                                        cachedTreeList[index]['leafAngle'];
                                    currentTree.leafLength.value =
                                        cachedTreeList[index]['leafLength'];
                                    currentTree.randomLeafLength.value =
                                        cachedTreeList[index]['randomLeafLength'];
                                    currentTree.leafSquareness.value =
                                        cachedTreeList[index]['leafSquareness'];
                                    currentTree.leafDecay.value =
                                        cachedTreeList[index]['leafDecay'];
                                    currentTree.backgroundColor.value =
                                        cachedTreeList[index]['backgroundColor'];
                                    currentTree.trunkFillColor.value =
                                        cachedTreeList[index]['trunkFillColor'];
                                    currentTree.trunkOutlineColor.value =
                                        cachedTreeList[index]['trunkOutlineColor'];
                                    currentTree.randomColors.value =
                                        cachedTreeList[index]['randomColors'];
                                    currentTree.numberOfColors.value =
                                        cachedTreeList[index]['numberOfColors'];
                                    currentTree.paletteType.value =
                                        cachedTreeList[index]['paletteType'];
                                    currentTree.opacity.value =
                                        cachedTreeList[index]['opacity'];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle),
                                  width: 50,
                                  height: 50,
                                  child: Image.file(cachedTreeList[index]['image']),
                                ),
                              ),
                            );
                          },
                        );
                }
              )),
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
        currentTree.randomize();
        currentTree.randomizePalette();
        cacheTree();
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
    cacheTree();
  }

// @override
// void dispose() {
//   controller1.dispose();
//   // controller2.dispose();
//   super.dispose();
// }

}

class OpArtTreePainter extends CustomPainter {
  int seed;
  Random rnd;
  // double angle;
  // double fill;

  OpArtTreePainter(
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
    print('Tree');
    print('----------------------------------------------------------------');

    // Initialise the palette
    if (currentTree == null) {
      currentTree = new Tree(random: rnd);
      currentTree.defaultSettings();
      currentNamedPalette = currentTree.paletteList.value;
    }

    if (currentNamedPalette != null &&
        currentTree.paletteList.value != currentNamedPalette) {
      // find the index of the palette in the list

      List newPalette = palettes
          .firstWhere((palette) => palette[0] == currentTree.paletteList.value);

      // set the palette details
      currentTree.numberOfColors.value = newPalette[1].toInt();
      currentTree.backgroundColor.value = Color(int.parse(newPalette[2]));
      currentTree.palette = [];
      for (int z = 0; z < currentTree.numberOfColors.value; z++) {
        currentTree.palette.add(Color(int.parse(newPalette[3][z])));
      }

      currentNamedPalette = currentTree.paletteList.value;
    } else if (currentTree.numberOfColors.value > currentTree.palette.length) {
      currentTree.randomizePalette();
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

    // if (currentTree.aspectRatio == pi/2){
    currentTree.aspectRatio = canvasWidth / canvasHeight;
    // }

    if (canvasWidth / canvasHeight < currentTree.aspectRatio) {
      borderY = (canvasHeight - canvasWidth / currentTree.aspectRatio) / 2;
      imageHeight = imageWidth / currentTree.aspectRatio;
    } else {
      borderX = (canvasWidth - canvasHeight * currentTree.aspectRatio) / 2;
      imageWidth = imageHeight * currentTree.aspectRatio;
    }

    // colour in the canvas
    var paint1 = Paint()
      ..color = currentTree.backgroundColor.value
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight), paint1);

    double direction = pi / 2;

    double lineWidth = 2;
    // Color trunkFillColor = Colors.grey[800];

    String leafStyle = 'quadratic';

    List treeBaseA = [
      (canvasWidth - currentTree.trunkWidth.value) / 2,
      canvasHeight
    ];
    List treeBaseB = [
      (canvasWidth + currentTree.trunkWidth.value) / 2,
      canvasHeight
    ];

    drawSegment(
        canvas,
        borderX,
        borderY,
        treeBaseA,
        treeBaseB,
        currentTree.trunkWidth.value,
        currentTree.segmentLength.value,
        direction,
        0,
        lineWidth,
        currentTree.leafLength.value,
        leafStyle,
        false);
  }

  drawSegment(
    Canvas canvas,
    double borderX,
    double borderY,
    List rootA,
    List rootB,
    double width,
    double segmentLength,
    double direction,
    int currentDepth,
    double lineWidth,
    double leafLength,
    String leafStyle,
    bool justBranched,
  ) {
    List segmentBaseCentre = [
      (rootA[0] + rootB[0]) / 2,
      (rootA[1] + rootB[1]) / 2
    ];

    //branch

    if (!justBranched && rnd.nextDouble() < currentTree.branch.value) {
      List rootX = [
        segmentBaseCentre[0] + width * cos(direction),
        segmentBaseCentre[1] - width * sin(direction)
      ];

      // draw the triangle
      drawTheTriangle(canvas, borderX, borderY, rootA, rootB, rootX);

      double directionA;
      double directionB;

      if (rnd.nextDouble() > 0.5) {
        directionA =
            direction + currentTree.ratio.value * currentTree.angle.value;
        directionB =
            direction - (1 - currentTree.ratio.value) * currentTree.angle.value;
      } else {
        directionA =
            direction - currentTree.ratio.value * currentTree.angle.value;
        directionB =
            direction + (1 - currentTree.ratio.value) * currentTree.angle.value;
      }

      if (rnd.nextDouble() > 0.5) {
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootA,
            rootX,
            width * currentTree.widthDecay.value,
            segmentLength * currentTree.segmentDecay.value,
            directionA,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true);
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootX,
            rootB,
            width * currentTree.widthDecay.value,
            segmentLength * currentTree.segmentDecay.value,
            directionB,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true);
      } else {
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootX,
            rootB,
            width * currentTree.widthDecay.value,
            segmentLength * currentTree.segmentDecay.value,
            directionB,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true);
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootA,
            rootX,
            width * currentTree.widthDecay.value,
            segmentLength * currentTree.segmentDecay.value,
            directionA,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true);
      }
    } else {
      //grow
      List PD = [
        segmentBaseCentre[0] + segmentLength * cos(direction),
        segmentBaseCentre[1] - segmentLength * sin(direction)
      ];
      List P2 = [
        PD[0] + 0.5 * width * currentTree.widthDecay.value * sin(direction),
        PD[1] + 0.5 * width * currentTree.widthDecay.value * cos(direction)
      ];
      List P3 = [
        PD[0] - 0.5 * width * currentTree.widthDecay.value * sin(direction),
        PD[1] - 0.5 * width * currentTree.widthDecay.value * cos(direction)
      ];

      // draw the trunk
      drawTheTrunk(canvas, borderX, borderY, rootB, P2, P3, rootA,
          currentTree.bulbousness.value);

      // Draw the leaves
      if (currentDepth > currentTree.leavesAfter.value) {
        drawTheLeaf(canvas, borderX, borderY, P2, lineWidth,
            direction - currentTree.leafAngle.value, leafLength, leafStyle);
        drawTheLeaf(canvas, borderX, borderY, P3, lineWidth,
            direction + currentTree.leafAngle.value, leafLength, leafStyle);
      }

      // next
      if (currentDepth < currentTree.maxDepth.value) {
        drawSegment(
            canvas,
            borderX,
            borderY,
            P3,
            P2,
            width * currentTree.widthDecay.value,
            segmentLength * currentTree.segmentDecay.value,
            direction,
            currentDepth + 1,
            lineWidth,
            leafLength * currentTree.leafDecay.value,
            leafStyle,
            false);
      }
    }
  }

  drawTheTrunk(
    Canvas canvas,
    double borderX,
    double borderY,
    List P1,
    List P2,
    List P3,
    List P4,
    double bulbousness,
  ) {
    List PC = [
      (P1[0] + P2[0] + P3[0] + P4[0]) / 4,
      (P1[1] + P2[1] + P3[1] + P4[1]) / 4
    ];
    List P12 = [(P1[0] + P2[0]) / 2, (P1[1] + P2[1]) / 2];
    List PX = [
      PC[0] * (1 - bulbousness) + P12[0] * bulbousness,
      PC[1] * (1 - bulbousness) + P12[1] * bulbousness
    ];
    List P34 = [(P3[0] + P4[0]) / 2, (P3[1] + P4[1]) / 2];
    List PY = [
      PC[0] * (1 - bulbousness) + P34[0] * bulbousness,
      PC[1] * (1 - bulbousness) + P34[1] * bulbousness
    ];

    Path trunk = Path();
    trunk.moveTo(borderX + P1[0], -borderY + P1[1]);
    trunk.quadraticBezierTo(
        borderX + PX[0], -borderY + PX[1], borderX + P2[0], -borderY + P2[1]);
    trunk.lineTo(borderX + P3[0], -borderY + P3[1]);
    trunk.quadraticBezierTo(
        borderX + PY[0], -borderY + PY[1], borderX + P4[0], -borderY + P4[1]);
    trunk.close();

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.fill
          ..color = currentTree.trunkFillColor.value
              .withOpacity(currentTree.opacity.value));

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = currentTree.trunkStrokeWidth.value
          ..color = currentTree.trunkOutlineColor.value
              .withOpacity(currentTree.opacity.value));
  }

  drawTheTriangle(
    Canvas canvas,
    double borderX,
    double borderY,
    List P1,
    List P2,
    List P3,
  ) {
    Path trunk = Path();
    trunk.moveTo(borderX + P1[0], -borderY + P1[1]);
    trunk.lineTo(borderX + P2[0], -borderY + P2[1]);
    trunk.lineTo(borderX + P3[0], -borderY + P3[1]);
    trunk.close();

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.fill
          ..color = currentTree.trunkFillColor.value
              .withOpacity(currentTree.opacity.value));

    canvas.drawPath(
        trunk,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = currentTree.trunkStrokeWidth.value
          ..color = currentTree.trunkOutlineColor.value
              .withOpacity(currentTree.opacity.value));
  }

  drawTheLeaf(
    Canvas canvas,
    double borderX,
    double borderY,
    List leafPosition,
    double lineWidth,
    double leafAngle,
    double leafLength,
    String leafStyle,
  ) {
    double leafAssymetery = 0.75;

    // pick a random color
    print('drawTheLeaf: oopacity: ${currentTree.opacity.value}');
    Color leafColor = currentTree
        .palette[rnd.nextInt(currentTree.palette.length)]
        .withOpacity(currentTree.opacity.value);

    var leafRadius =
        leafLength + rnd.nextDouble() * currentTree.randomLeafLength.value;

    // find the centre of the leaf
    List PC = [
      leafPosition[0] + leafRadius * cos(leafAngle),
      leafPosition[1] - leafRadius * sin(leafAngle)
    ];

//    List PN = [PC[0] - leafRadius * cos(leafAngle), PC[1] + leafRadius * sin(leafAngle)];

    // find the tip of the leaf
    List PS = [
      PC[0] - leafRadius * cos(leafAngle + pi),
      PC[1] + leafRadius * sin(leafAngle + pi)
    ];

    // find the offset centre of the leaf
    List POC = [
      PC[0] + leafAssymetery * leafRadius * cos(leafAngle + pi),
      PC[1] - leafAssymetery * leafRadius * sin(leafAngle + pi)
    ];

    List PE = [
      POC[0] -
          currentTree.leafSquareness.value *
              leafRadius *
              cos(leafAngle + pi * 0.5),
      POC[1] +
          currentTree.leafSquareness.value *
              leafRadius *
              sin(leafAngle + pi * 0.5)
    ];
    List PW = [
      POC[0] -
          currentTree.leafSquareness.value *
              leafRadius *
              cos(leafAngle + pi * 1.5),
      POC[1] +
          currentTree.leafSquareness.value *
              leafRadius *
              sin(leafAngle + pi * 1.5)
    ];

    // List PSE = [PS[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 0.5), PS[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 0.5)];
    // List PSW = [PS[0] - leafSquareness * leafRadius * cos(leafAngle + pi * 1.5), PS[1] + leafSquareness * leafRadius * sin(leafAngle + pi * 1.5)];

    switch (leafStyle) {
      case "quadratic":
        Path leaf = Path();
        leaf.moveTo(borderX + leafPosition[0], -borderY + leafPosition[1]);
        leaf.quadraticBezierTo(borderX + PE[0], -borderY + PE[1],
            borderX + PS[0], -borderY + PS[1]);
        leaf.quadraticBezierTo(borderX + PW[0], -borderY + PW[1],
            borderX + leafPosition[0], -borderY + leafPosition[1]);
        leaf.close();

        canvas.drawPath(
            leaf,
            Paint()
              ..style = PaintingStyle.fill
              ..color = leafColor);

        break;
    }
  }

  @override
  bool shouldRepaint(OpArtTreePainter oldDelegate) => false;
}
