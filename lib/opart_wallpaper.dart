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
import 'palettes.dart';

Random rnd;

// Settings
Wallpaper currentWallpaper;

// Load the palettes
List palettes = defaultPalettes();
String currentNamedPalette;

class Wallpaper {
  // image settings

  SettingsModelInt cellsX = SettingsModelInt(label: 'Horizontal Cells', tooltip: 'The number of horizontal cells', min: 1, max: 10, defaultValue: 5, icon: Icon(Icons.swap_horiz));
  SettingsModelInt cellsY = SettingsModelInt(label: 'Vertical Cells', tooltip: 'The number of vertical cells', min: 1, max: 10, defaultValue: 5, icon: Icon(Icons.swap_vert));
  SettingsModelList shape = SettingsModelList(label: "Shape", tooltip: "The shape in the cell", defaultValue: "circle", icon: Icon(Icons.settings), options: ['circle', 'squaricle', 'star',],);
  SettingsModelDouble driftX = SettingsModelDouble(label: 'Horizontal Drift', tooltip: 'The drift in the horizontal axis', min: -20, max: 20, zoom: 100,defaultValue: 0, icon: Icon(Icons.more_horiz));
  SettingsModelDouble driftXStep = SettingsModelDouble(label: 'Horizontal Step', tooltip: 'The acceleration of the drift in the horizontal axis', min: -2, max: 2, zoom: 100, defaultValue: 0, icon: Icon(Icons.screen_lock_landscape));
  SettingsModelDouble driftY = SettingsModelDouble(label: 'Vertical Drift', tooltip: 'The drift in the vertical axis', min: -20, max: 20, zoom: 100, defaultValue: 0, icon: Icon(Icons.more_vert));
  SettingsModelDouble driftYStep = SettingsModelDouble(label: 'Vertical Step', tooltip: 'The acceleration of the drift in the vertical axis', min: -2, max: 2, zoom: 100, defaultValue: 0, icon: Icon(Icons.screen_lock_portrait));
  SettingsModelBool alternateDrift = SettingsModelBool(label: 'Alternate Drift', tooltip: 'Alternate the drift', defaultValue: true, icon: Icon(Icons.gamepad));
  SettingsModelBool box = SettingsModelBool(label: 'Box', tooltip: 'Fill in the box', defaultValue: true, icon: Icon(Icons.check_box_outline_blank));
  SettingsModelDouble step = SettingsModelDouble(label: 'Step', tooltip: 'The decrease ratio of concentric shapes', min: 0.05, max: 1, zoom: 100, defaultValue: 0.3, icon: Icon(Icons.control_point));
  SettingsModelDouble stepStep = SettingsModelDouble(label: 'Step Ratio', tooltip: 'The ratio of change of the ratio', min: 0.5, max: 1, zoom: 100,   defaultValue: 0.9, icon: Icon(Icons.control_point_duplicate));
  SettingsModelDouble ratio  = SettingsModelDouble(label: 'Ratio', tooltip: 'The ratio of the shape to the box', min: 0.75, max: 1.75, zoom: 100, defaultValue: 1, icon: Icon(Icons.zoom_out_map));
  SettingsModelDouble offsetX = SettingsModelDouble(label: 'Horizontal Offset', tooltip: 'The offset in the horizontal axis', min: -40, max: 40, zoom: 100, defaultValue: 0, icon: Icon(Icons.more_horiz));
  SettingsModelDouble offsetY = SettingsModelDouble(label: 'Vertical Offset', tooltip: 'The offset in the vertical axis', min: -40, max: 40, zoom: 100, defaultValue: 0, icon: Icon(Icons.more_vert));
  SettingsModelDouble rotate = SettingsModelDouble(label: 'Rotate', tooltip: 'The shape rotation', min: 0, max: pi, zoom: 200, defaultValue: 0, icon: Icon(Icons.rotate_right));
  SettingsModelBool randomRotation = SettingsModelBool(label: 'Random Rotate', tooltip: 'The random shape rotation', defaultValue: false, icon: Icon(Icons.crop_rotate));
  SettingsModelDouble rotateStep  = SettingsModelDouble(label: 'Rotate Step', tooltip: 'The rate of increase of the rotation', min: 0, max: 2, zoom: 100, defaultValue: 0, icon: Icon(Icons.screen_rotation));

  SettingsModelDouble squareness = SettingsModelDouble(label: 'Squareness', tooltip: 'The squareness of the shape', min: -2, max: 2, zoom: 100, defaultValue: 1, icon: Icon(Icons.center_focus_weak));
  SettingsModelDouble squeezeX = SettingsModelDouble(label: 'Horizontal Squeeze', tooltip: 'The squeeze in the horizontal axis', min: 0.5, max: 1.5, zoom: 100, defaultValue: 1, icon: Icon(Icons.more_horiz));
  SettingsModelDouble squeezeY = SettingsModelDouble(label: 'Vertical Squeeze', tooltip: 'The squeeze in the vertical axis', min: 0.5, max: 1.5, zoom: 100, defaultValue: 1, icon: Icon(Icons.more_vert));
  SettingsModelInt numberOfPetals = SettingsModelInt(label: 'Number Of Points', tooltip: 'The number of points', min: 1, max: 15, defaultValue: 5, icon: Icon(Icons.star));
  SettingsModelBool randomPetals = SettingsModelBool(label: 'Random Petals', tooltip: 'Random Petals', defaultValue: true, icon: Icon(Icons.stars));

// palette settings
  SettingsModelColor backgroundColor = SettingsModelColor(label: "Background Color", tooltip: "The background colour for the canvas", defaultValue: Colors.white, icon: Icon(Icons.settings_overscan), );
  SettingsModelColor lineColor  = SettingsModelColor(label: "Outline Color", tooltip: "The outline colour", defaultValue: Colors.black, icon: Icon(Icons.settings_overscan), );
  SettingsModelDouble lineWidth  = SettingsModelDouble(label: 'Outline Width', tooltip: 'The width of the outline', min: 0, max: 1, zoom: 100, defaultValue: 0.1, icon: Icon(Icons.line_weight));
  SettingsModelBool randomColors = SettingsModelBool(label: 'Random Colors', tooltip: 'Randomise the colours', defaultValue: true, icon: Icon(Icons.gamepad));
  SettingsModelBool resetColors = SettingsModelBool(label: 'Reset Colors', tooltip: 'Reset the colours for each cell', defaultValue: false, icon: Icon(Icons.gamepad));
  SettingsModelInt numberOfColors = SettingsModelInt(label: 'Number of Colors', tooltip: 'The number of colours in the palette', min: 1, max: 36, defaultValue: 10, icon: Icon(Icons.palette));
  SettingsModelList paletteType = SettingsModelList(label: "Palette Type", tooltip: "The nature of the palette", defaultValue: "random", icon: Icon(Icons.colorize), options: ['random', 'blended random ', 'linear random', 'linear complementary'],);
  SettingsModelDouble opacity = SettingsModelDouble(label: 'Opactity', tooltip: 'The opactity of the petal', min: 0.2, max: 1, zoom: 100, defaultValue: 1, icon: Icon(Icons.remove_red_eye));
  SettingsModelList paletteList = SettingsModelList(label: "Palette", tooltip: "Choose from a list of palettes", defaultValue: "Default", icon: Icon(Icons.palette), options: defaultPalleteNames(),);

  List palette;
  double aspectRatio;
  File image;

// lock settings
  bool paletteLOCK = false;
  bool aspectRatioLOCK = false;

  Random random;

  Wallpaper({

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

    this.cellsX.randomise(random);
    this.cellsY.randomise(random);
    this.shape.randomise(random);
    this.driftX.randomise(random);
    this.driftXStep.randomise(random);
    this.driftY.randomise(random);
    this.driftYStep.randomise(random);
    this.alternateDrift.randomise(random);
    this.box.randomise(random);
    this.step.randomise(random);
    this.stepStep.randomise(random);
    this.ratio.randomise(random);
    this.offsetX.randomise(random);
    this.offsetY.randomise(random);
    this.rotate.randomise(random);
    this.randomRotation.randomise(random);
    this.rotateStep.randomise(random);
    this.squareness.randomise(random);
    this.squeezeX.randomise(random);
    this.squeezeY.randomise(random);
    this.numberOfPetals.randomise(random);
    this.randomPetals.randomise(random);

    }

  void randomizePalette() {
    print('-----------------------------------------------------');
    print('randomizePalette');
    print('-----------------------------------------------------');

    rnd = Random(DateTime.now().millisecond);

    this.backgroundColor.randomise(random);
    this.lineColor.randomise(random);
    this.lineWidth.randomise(random);
    this.randomColors.randomise(random);
    this.numberOfColors.randomise(random);
    this.paletteType.randomise(random);
    this.opacity.randomise(random);

    this.palette = randomisedPalette(this.paletteType.value, this.numberOfColors.value, rnd);

  }

  void defaultSettings() {
    // resets to default settings

    this.cellsX.value = this.cellsX.defaultValue;
    this.cellsY.value = this.cellsY.defaultValue;
    this.shape.value = this.shape.defaultValue;
    this.driftX.value = this.driftX.defaultValue;
    this.driftXStep.value = this.driftXStep.defaultValue;
    this.driftY.value = this.driftY.defaultValue;
    this.driftYStep.value = this.driftYStep.defaultValue;
    this.alternateDrift.value = this.alternateDrift.defaultValue;
    this.box.value = this.box.defaultValue;
    this.step.value = this.step.defaultValue;
    this.stepStep.value = this.stepStep.defaultValue;
    this.ratio.value = this.ratio.defaultValue;
    this.offsetX.value = this.offsetX.defaultValue;
    this.offsetY.value = this.offsetY.defaultValue;
    this.rotate.value = this.rotate.defaultValue;
    this.randomRotation.value = this.randomRotation.defaultValue;
    this.rotateStep.value = this.rotateStep.defaultValue;
    this.squareness.value = this.squareness.defaultValue;
    this.squeezeX.value = this.squeezeX.defaultValue;
    this.squeezeY.value = this.squeezeY.defaultValue;
    this.numberOfPetals.value = this.numberOfPetals.defaultValue;
    this.randomPetals.value = this.randomPetals.defaultValue;

    // palette settings
    this.backgroundColor.value = this.backgroundColor.defaultValue;
    this.lineColor.value = this.lineColor.defaultValue;
    this.lineWidth.value = this.lineWidth.defaultValue;
    this.randomColors.value = this.randomColors.defaultValue;
    this.resetColors.value = this.resetColors.defaultValue;
    this.numberOfColors.value = this.numberOfColors.defaultValue;
    this.paletteType.value = this.paletteType.defaultValue;
    this.opacity.value = this.opacity.defaultValue;

    this.paletteList.value = this.paletteList.defaultValue;

    this.palette = [Color(0xFF37A7BC), Color(0xFFB4B165), Color(0xFFA47EA4), Color(0xFF69ABCB), Color(0xFF79B38E), Color(0xFF17B8E0), Color(0xFFD1EFED), Color(0xFF151E2A), Color(0xFF725549), Color(0xFF074E71)];



    this.aspectRatio = pi / 2;

    this.image;

    this.paletteLOCK = false;
    this.aspectRatioLOCK = false;
  }
}

List settingsList = [
  currentWallpaper.cellsX ,
  currentWallpaper.cellsY ,
  currentWallpaper.shape ,
  currentWallpaper.driftX ,
  currentWallpaper.driftXStep ,
  currentWallpaper.driftY ,
  currentWallpaper.driftYStep ,
  currentWallpaper.alternateDrift ,
  currentWallpaper.box ,
  currentWallpaper.step ,
  currentWallpaper.stepStep ,
  currentWallpaper.ratio ,
  currentWallpaper.offsetX ,
  currentWallpaper.offsetY  ,
  currentWallpaper.rotate  ,
  currentWallpaper.randomRotation ,
  currentWallpaper.rotateStep ,
  currentWallpaper.squareness ,
  currentWallpaper.squeezeX ,
  currentWallpaper.squeezeY ,
  currentWallpaper.numberOfPetals ,
  currentWallpaper.randomPetals ,
  currentWallpaper.backgroundColor,
  currentWallpaper.lineColor ,
  currentWallpaper.lineWidth,
  currentWallpaper.randomColors ,
  currentWallpaper.resetColors ,
  currentWallpaper.numberOfColors,
  currentWallpaper.paletteType,
  currentWallpaper.opacity ,
  currentWallpaper.paletteList,
];

class OpArtWallpaperStudio extends StatefulWidget {


  OpArtWallpaperStudio();

  @override
  _OpArtWallpaperStudioState createState() => _OpArtWallpaperStudioState();
}

class _OpArtWallpaperStudioState extends State<OpArtWallpaperStudio>
    with TickerProviderStateMixin {
  int _counter = 0;
  File _imageFile;

  int _currentColor = 0;

  // Animation<double> animation1;
  // AnimationController controller1;

  // Animation<double> animation2;
  // AnimationController controller2;


  List<Map<String, dynamic>> cachedWallpaperList = [];
  cacheWallpaper(
     Function SetState) async {
    await new Future.delayed(const Duration(milliseconds: 200));
    screenshotController
        .capture(delay: Duration(milliseconds: 100), pixelRatio: 0.2)
        .then((File image) async {
      currentWallpaper.image = image;

      Map<String, dynamic> currentCache = {
        'aspectRatio': currentWallpaper.aspectRatio,
        'cellsX': currentWallpaper.cellsX.value,
        'cellsY': currentWallpaper.cellsY.value,
        'shape': currentWallpaper.shape.value,
        'driftX': currentWallpaper.driftX.value,
        'driftXStep': currentWallpaper.driftXStep.value,
        'driftY': currentWallpaper.driftY.value,
        'driftYStep': currentWallpaper.driftYStep.value,
        'alternateDrift': currentWallpaper.alternateDrift.value,
        'box': currentWallpaper.box.value,
        'step': currentWallpaper.step.value,
        'stepStep': currentWallpaper.stepStep.value,
        'ratio': currentWallpaper.ratio.value,
        'offsetX': currentWallpaper.offsetX.value,
        'offsetY': currentWallpaper.offsetY.value,
        'rotate': currentWallpaper.rotate.value,
        'randomRotation': currentWallpaper.randomRotation.value,
        'rotateStep': currentWallpaper.rotateStep.value,
        'squareness': currentWallpaper.squareness.value,
        'squeezeX': currentWallpaper.squeezeX.value,
        'squeezeY': currentWallpaper.squeezeY.value,
        'numberOfPetals': currentWallpaper.numberOfPetals.value,
        'randomPetals': currentWallpaper.randomPetals.value,
        'backgroundColor': currentWallpaper.backgroundColor.value,
        'lineColor': currentWallpaper.lineColor.value,
        'lineWidth': currentWallpaper.lineWidth.value,
        'randomColors': currentWallpaper.randomColors.value,
        'resetColors': currentWallpaper.resetColors.value,
        'numberOfColors': currentWallpaper.numberOfColors.value,
        'paletteType': currentWallpaper.paletteType.value,
        'opacity': currentWallpaper.opacity.value,
        'paletteList': currentWallpaper.paletteList.value,
        'image': currentWallpaper.image,

      };
      cachedWallpaperList.add(currentCache);
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
                    painter: OpArtWallpaperPainter(
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
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    SetState() {
      setState(() {});
    }


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
                      painter: OpArtWallpaperPainter(
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
                            _showBottomSheetSettings(context, index,
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
                FlatButton(
                    onPressed: () {
                      setState(() {
                        currentWallpaper.randomize();
                        currentWallpaper.randomizePalette();
                        cacheWallpaper( SetState);
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
                FlatButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tools',
                        textAlign: TextAlign.center,
                      ),
                    )),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        currentWallpaper.randomizePalette();
                        cacheWallpaper( SetState);
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
      body: Column(
        children: [

          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 60,
              child: cachedWallpaperList.length == 0
                  ? Container()
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: cachedWallpaperList.length,
                shrinkWrap: true,
                reverse: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {

                          currentWallpaper.aspectRatio = cachedWallpaperList[index]['aspectRatio'];
                          currentWallpaper.cellsX.value = cachedWallpaperList[index]['cellsX'];
                          currentWallpaper.cellsY.value = cachedWallpaperList[index]['cellsY'];
                          currentWallpaper.shape.value = cachedWallpaperList[index]['shape'];
                          currentWallpaper.driftX.value = cachedWallpaperList[index]['driftX'];
                          currentWallpaper.driftXStep.value = cachedWallpaperList[index]['driftXStep'];
                          currentWallpaper.driftY.value = cachedWallpaperList[index]['driftY'];
                          currentWallpaper.driftYStep.value = cachedWallpaperList[index]['driftYStep'];
                          currentWallpaper.alternateDrift.value = cachedWallpaperList[index]['alternateDrift'];
                          currentWallpaper.box.value = cachedWallpaperList[index]['box'];
                          currentWallpaper.step.value = cachedWallpaperList[index]['step'];
                          currentWallpaper.stepStep.value = cachedWallpaperList[index]['stepStep'];
                          currentWallpaper.ratio.value = cachedWallpaperList[index]['ratio'];
                          currentWallpaper.offsetX.value = cachedWallpaperList[index]['offsetX'];
                          currentWallpaper.offsetY.value = cachedWallpaperList[index]['offsetY'];
                          currentWallpaper.rotate.value = cachedWallpaperList[index]['rotate'];
                          currentWallpaper.randomRotation.value = cachedWallpaperList[index]['randomRotation'];
                          currentWallpaper.rotateStep.value = cachedWallpaperList[index]['rotateStep'];
                          currentWallpaper.squareness.value = cachedWallpaperList[index]['squareness'];
                          currentWallpaper.squeezeX.value = cachedWallpaperList[index]['squeezeX'];
                          currentWallpaper.squeezeY.value = cachedWallpaperList[index]['squeezeY'];
                          currentWallpaper.numberOfPetals.value = cachedWallpaperList[index]['numberOfPetals'];
                          currentWallpaper.randomPetals.value = cachedWallpaperList[index]['randomPetals'];
                          currentWallpaper.backgroundColor.value = cachedWallpaperList[index]['backgroundColor'];
                          currentWallpaper.lineColor.value = cachedWallpaperList[index]['lineColor'];
                          currentWallpaper.lineWidth.value = cachedWallpaperList[index]['lineWidth'];
                          currentWallpaper.randomColors.value = cachedWallpaperList[index]['randomColors'];
                          currentWallpaper.resetColors.value = cachedWallpaperList[index]['resetColors'];
                          currentWallpaper.numberOfColors.value = cachedWallpaperList[index]['numberOfColors'];
                          currentWallpaper.paletteType.value = cachedWallpaperList[index]['paletteType'];
                          currentWallpaper.paletteList.value = cachedWallpaperList[index]['paletteList'];
                          currentWallpaper.opacity.value = cachedWallpaperList[index]['opacity'];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        width: 50,
                        height: 50,
                        child: Image.file(
                            cachedWallpaperList[index]['image']),
                      ),
                    ),
                  );
                },
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
        currentWallpaper.randomize();
        currentWallpaper.randomizePalette();
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
    cacheWallpaper( (){setState(() {

    });});
  }

// @override
// void dispose() {
//   controller1.dispose();
//   // controller2.dispose();
//   super.dispose();
// }

}

class OpArtWallpaperPainter extends CustomPainter {
  int seed;
  Random rnd;
  // double angle;
  // double fill;

  OpArtWallpaperPainter(
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
    print('Wallpaper');
    print('----------------------------------------------------------------');


    // Initialise the palette
    if (currentWallpaper == null) {
      currentWallpaper = new Wallpaper(random: rnd);
      currentWallpaper.defaultSettings();
      currentNamedPalette = currentWallpaper.paletteList.value;
    }
    if (currentNamedPalette != null && currentWallpaper.paletteList.value != currentNamedPalette) {
      // find the index of the palette in the list
      List newPalette = palettes.firstWhere((palette) => palette[0]==currentWallpaper.paletteList.value);
      // set the palette details
      currentWallpaper.numberOfColors.value = newPalette[1].toInt();
      currentWallpaper.backgroundColor.value = Color(int.parse(newPalette[2]));
      currentWallpaper.palette = [];
      for (int z = 0; z < currentWallpaper.numberOfColors.value; z++){
        currentWallpaper.palette.add(Color(int.parse(newPalette[3][z])));
      }
      currentNamedPalette = currentWallpaper.paletteList.value;
    } else if (currentWallpaper.numberOfColors.value >
        currentWallpaper.palette.length) {
      currentWallpaper.randomizePalette();
    }


    // Initialise the canvas
    double canvasWidth = size.width;
    double canvasHeight = size.height;
    double borderX = 0;
    double borderY = 0;
    double imageWidth = canvasWidth;
    double imageHeight = canvasHeight;

    print('currentWallpaper.aspectRatio: ${currentWallpaper.aspectRatio}');
    // Initialise the aspect ratio
    if (currentWallpaper.aspectRatio == pi/2){
      if (canvasHeight>canvasWidth){
        currentWallpaper.cellsY.value  = (canvasHeight/canvasWidth*currentWallpaper.cellsX.value).toInt();
      }
      else {
        currentWallpaper.cellsX.value  = (canvasWidth/canvasHeight*currentWallpaper.cellsY.value).toInt();
      }
      currentWallpaper.aspectRatio = currentWallpaper.cellsX.value / currentWallpaper.cellsY.value;
    }

    if (canvasWidth / canvasHeight < currentWallpaper.aspectRatio) {
      borderY = (canvasHeight - canvasWidth * currentWallpaper.aspectRatio) / 2;
      imageHeight = imageWidth / currentWallpaper.aspectRatio;
    } else {
      borderX = (canvasWidth - canvasHeight / currentWallpaper.aspectRatio) / 2;
      imageWidth = imageHeight * currentWallpaper.aspectRatio;
    }
    print('currentWallpaper.aspectRatio: ${currentWallpaper.aspectRatio}');

    print('height: ${canvasHeight}');
    print('width: ${canvasWidth}');
    print('canvasWidth / canvasHeight = ${canvasWidth / canvasHeight}');
    print('aspectRatio = ${currentWallpaper.aspectRatio}');
    print('borderX = $borderX');
    print('borderY = $borderY');
    print('imageWidth = $imageWidth');
    print('imageHeight = $imageHeight');

    print('cellsX: ${currentWallpaper.cellsX.value}');
    print('cellsY: ${currentWallpaper.cellsY.value}');

    borderY = 55;
    int colourOrder = 0;


    // Now make some art

    // fill
    bool fill = true; // rnd.nextBool();
    print('fill: $fill');

    int extraCellsX = 0;
    int extraCellsY = 0;
    if (fill) {
      extraCellsX = currentWallpaper.cellsX.value * 2;
      extraCellsY = currentWallpaper.cellsY.value * 2;
    }

    // work out the radius from the width and the cells
    double radius = imageWidth / (currentWallpaper.cellsX.value * 2);
    print('radius: $radius');



    for (int j = 0 - extraCellsY; j < currentWallpaper.cellsY.value + extraCellsY; j++) {
      for (int i = 0 - extraCellsX; i < currentWallpaper.cellsX.value + extraCellsX; i++) {

        int k = 0; // count the steps

        double dX = 0;
        double dY = 0;

        double stepRadius = radius * currentWallpaper.ratio.value;
        double localStep = currentWallpaper.step.value * radius;

        double localRotate = currentWallpaper.rotate.value;
        if (currentWallpaper.randomRotation.value) {
          localRotate = rnd.nextDouble() * currentWallpaper.rotate.value;
        }
        if (currentWallpaper.alternateDrift.value && (i + j ) % 2 == 0) {
          localRotate = 0 - localRotate;
        }

        // Number of petals
        var localNumberOfPetals = currentWallpaper.numberOfPetals.value;
        if (currentWallpaper.randomPetals.value) {
          localNumberOfPetals =  rnd.nextInt(currentWallpaper.numberOfPetals.value) + 3;
        }

        // Centre of the square
        List PO = [
          borderX + radius * (1 - currentWallpaper.squeezeX.value) + dX + (currentWallpaper.offsetX.value * j) + (i * 2 + 1) * radius * currentWallpaper.squeezeX.value,
          borderY + radius * (1 - currentWallpaper.squeezeY.value) + dY + (currentWallpaper.offsetY.value * i) + (j * 2 + 1) * radius * currentWallpaper.squeezeY.value
        ];
        // print('i: $i j: $j');
        // print('PO: $PO');

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
        if (currentWallpaper.resetColors.value) {
          colourOrder = 0;
        }


        if (currentWallpaper.box.value) {

          // Choose the next colour
          colourOrder++;
          nextColor = currentWallpaper.palette[colourOrder%currentWallpaper.numberOfColors.value];
          if (currentWallpaper.randomColors.value) {
            nextColor = currentWallpaper.palette[rnd.nextInt(currentWallpaper.numberOfColors.value)];
          }

          // fill the square
          Path path = Path();
          path.moveTo(PA[0], PA[1]);
          path.lineTo(PB[0], PB[1]);
          path.lineTo(PC[0], PC[1]);
          path.lineTo(PD[0], PD[1]);
          path.close();

          canvas.drawPath(path, Paint() ..style = PaintingStyle.fill ..color = nextColor.withOpacity(currentWallpaper.opacity.value));

          // if (lineWidth > 0) {
          //   canvas.drawPath(path, Paint() ..style = PaintingStyle.stroke ..strokeWidth = lineWidth ..color = lineColor);
          // }

        }



        do {

          // drift...
          PO = [PO[0] + dX, PO[1] + dY];

          switch (currentWallpaper.shape.value) {
            case 'circle':

            // Choose the next colour
              colourOrder++;
              nextColor = currentWallpaper.palette[colourOrder%currentWallpaper.numberOfColors.value];
              if (currentWallpaper.randomColors.value) {
                nextColor = currentWallpaper.palette[rnd.nextInt(currentWallpaper.numberOfColors.value)];
              }

              canvas.drawCircle(Offset(PO[0], PO[1]), stepRadius, Paint() ..style = PaintingStyle.fill ..color = nextColor.withOpacity(currentWallpaper.opacity.value));
              canvas.drawCircle(Offset(PO[0], PO[1]), stepRadius, Paint() ..style = PaintingStyle.stroke ..strokeWidth = currentWallpaper.lineWidth.value ..color = currentWallpaper.lineColor.value.withOpacity(currentWallpaper.opacity.value));

              break;

            case 'squaricle':

              List PA = [
                PO[0] + stepRadius * sqrt(2) * cos(pi * (1 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (1 / 4 + localRotate))
              ];
              List PB = [
                PO[0] + stepRadius * sqrt(2) * cos(pi * (3 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (3 / 4 + localRotate))
              ];
              List PC = [
                PO[0] + stepRadius * sqrt(2) * cos(pi * (5 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (5 / 4 + localRotate))
              ];
              List PD = [
                PO[0] + stepRadius * sqrt(2) * cos(pi * (7 / 4 + localRotate)),
                PO[1] + stepRadius * sqrt(2) * sin(pi * (7 / 4 + localRotate))
              ];


              // 16 points - 2 on each edge and 8 curve centres

              List P1 = edgePoint(PA, PB, 0.5 + currentWallpaper.squareness.value / 2);
              List P2 = edgePoint(PA, PB, 0.5 - currentWallpaper.squareness.value / 2);

              List P4 = edgePoint(PB, PC, 0.5 + currentWallpaper.squareness.value / 2);
              List P5 = edgePoint(PB, PC, 0.5 - currentWallpaper.squareness.value / 2);

              List P7 = edgePoint(PC, PD, 0.5 + currentWallpaper.squareness.value / 2);
              List P8 = edgePoint(PC, PD, 0.5 - currentWallpaper.squareness.value / 2);

              List P10 = edgePoint(PD, PA, 0.5 + currentWallpaper.squareness.value / 2);
              List P11 = edgePoint(PD, PA, 0.5 - currentWallpaper.squareness.value / 2);

              Path squaricle = Path();

              squaricle.moveTo(P1[0], P1[1]);
              squaricle.lineTo(P2[0], P2[1]);
              squaricle.quadraticBezierTo(PB[0], PB[1], P4[0], P4[1]);
              squaricle.lineTo(P5[0], P5[1]);
              squaricle.quadraticBezierTo(PC[0], PC[1], P7[0], P7[1]);
              squaricle.lineTo(P8[0], P8[1]);
              squaricle.quadraticBezierTo(PD[0], PD[1], P10[0], P10[1]);
              squaricle.lineTo(P11[0], P11[1]);
              squaricle.quadraticBezierTo(PA[0], PA[1], P1[0], P1[1]);
              squaricle.close();

              // Choose the next colour
              colourOrder++;
              nextColor = currentWallpaper.palette[colourOrder%currentWallpaper.numberOfColors.value];
              if (currentWallpaper.randomColors.value) {
                nextColor = currentWallpaper.palette[rnd.nextInt(currentWallpaper.numberOfColors.value)];
              }

              canvas.drawPath(
                  squaricle,
                  Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = currentWallpaper.lineWidth.value
                    ..color = currentWallpaper.lineColor.value.withOpacity(currentWallpaper.opacity.value));
              canvas.drawPath(
                  squaricle,
                  Paint()
                    ..style = PaintingStyle.fill
                    ..color = nextColor.withOpacity(currentWallpaper.opacity.value));

              break;

            case 'star':
              for (var p = 0; p < localNumberOfPetals; p++) {

                List petalPoint = [PO[0] + stepRadius * cos(localRotate * pi + p * pi * 2 / localNumberOfPetals),
                  PO[1] + stepRadius * sin(localRotate * pi + p * pi * 2 / localNumberOfPetals)];

                List petalMidPointA = [PO[0] + (currentWallpaper.squareness.value) * stepRadius * cos(localRotate * pi + (p - 1) * pi * 2 / localNumberOfPetals),
                  PO[1] + (currentWallpaper.squareness.value) * stepRadius * sin(localRotate * pi + (p - 1) * pi * 2 / localNumberOfPetals)];

                List petalMidPointP = [PO[0] + (currentWallpaper.squareness.value) * stepRadius * cos(localRotate * pi + (p + 1) * pi * 2 / localNumberOfPetals),
                  PO[1] + (currentWallpaper.squareness.value) * stepRadius * sin(localRotate * pi + (p + 1) * pi * 2 / localNumberOfPetals)];

                Path star = Path();

                star.moveTo(PO[0], PO[1]);
                star.quadraticBezierTo(petalMidPointA[0], petalMidPointA[1], petalPoint[0], petalPoint[1]);
                star.quadraticBezierTo(petalMidPointP[0], petalMidPointP[1], PO[0], PO[1]);
                star.close();

                // Choose the next colour
                colourOrder++;
                nextColor = currentWallpaper.palette[colourOrder%currentWallpaper.numberOfColors.value];
                if (currentWallpaper.randomColors.value) {
                nextColor = currentWallpaper.palette[rnd.nextInt(currentWallpaper.numberOfColors.value)];
                }

                canvas.drawPath(
                    star,
                    Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = currentWallpaper.lineWidth.value
                      ..color = currentWallpaper.lineColor.value.withOpacity(currentWallpaper.opacity.value));
                canvas.drawPath(
                    star,
                    Paint()
                      ..style = PaintingStyle.fill
                      ..color = nextColor.withOpacity(currentWallpaper.opacity.value));

              }

              break;

          }


          // Drift & Rotate
          if (currentWallpaper.alternateDrift.value && (i + j) % 2 == 0) {
            localRotate = localRotate - currentWallpaper.rotateStep.value;
          }
          else {
            localRotate = localRotate + currentWallpaper.rotateStep.value;
          }
          if (currentWallpaper.alternateDrift.value && (i) % 2 == 0) {
            dX = dX - currentWallpaper.driftX.value - k * currentWallpaper.driftXStep.value;
          }
          else {
            dX = dX + currentWallpaper.driftX.value + k * currentWallpaper.driftXStep.value;
          }
          if (currentWallpaper.alternateDrift.value && (j) % 2 == 0) {
            dY = dY - currentWallpaper.driftY.value - k * currentWallpaper.driftYStep.value;
          }
          else {
            dY = dY + currentWallpaper.driftY.value + k * currentWallpaper.driftYStep.value;
          }

          localStep = localStep * currentWallpaper.stepStep.value;
          stepRadius = stepRadius - localStep;
          k++;


        } while (k<40 && stepRadius > 0 && currentWallpaper.step.value > 0);

      }
    }

    // colour in the outer canvas
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(0, 0) & Size(borderX, canvasHeight), paint1);
    canvas.drawRect(Offset(canvasWidth-borderX, 0) & Size(borderX, canvasHeight), paint1);

    canvas.drawRect(Offset(0, 0) & Size(canvasWidth, borderY ), paint1);
    canvas.drawRect(Offset(0, borderY+currentWallpaper.cellsY.value*radius*2) & Size(canvasWidth, borderY+1000), paint1);

    print('borderX: $borderX');
    print('borderY: $borderY');
    print('canvasWidth: $canvasWidth');
    print('canvasHeight: $canvasHeight');



  }


  @override
  bool shouldRepaint(OpArtWallpaperPainter oldDelegate) => false;
}

List edgePoint(List Point1, List Point2, double ratio) {
  return [Point1[0] * (ratio) + Point2[0] * (1 - ratio), Point1[1] * (ratio) + Point2[1] * (1 - ratio)];
}
