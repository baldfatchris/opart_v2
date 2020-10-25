import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:shake/shake.dart';
import 'package:opart_v2/setting_button.dart';
import 'package:opart_v2/setting_slider.dart';
import 'package:opart_v2/setting_intslider.dart';
import 'package:opart_v2/setting_dropdown.dart';
import 'package:opart_v2/setting_colorpicker.dart';
import 'package:opart_v2/setting_radiobutton.dart';
import 'model.dart';
import 'palettes.dart';
import 'bottom_app_bar_custom.dart';
import 'toolbox.dart';

Random rnd;

// Settings
Wave currentWave;

// Load the palettes
List palettes = defaultPalettes();
String currentNamedPalette;

class Wave {
  // image settings

  SettingsModelDouble stepX = SettingsModelDouble(
    label: 'stepX',
    tooltip: 'The horizontal width of each stripe ',
    min: 1,
    max: 50,
    zoom: 100,
    defaultValue: 5,
    icon: Icon(Icons.more_horiz),
    proFeature: false,
  );
  SettingsModelDouble stepY = SettingsModelDouble(
    label: 'stepY',
    tooltip: 'The vertical distance between points on each stripe ',
    min: 1,
    max: 500,
    randomMin: 1,
    randomMax: 250,
    zoom: 100,
    defaultValue: 1,
    icon: Icon(Icons.more_vert),
    proFeature: false,
  );
  SettingsModelDouble frequency = SettingsModelDouble(
    label: 'frequency',
    tooltip: 'The frequency of the wave ',
    min: 0,
    max: 5,
    zoom: 100,
    defaultValue: 1,
    icon: Icon(Icons.adjust),
    proFeature: false,
  );

  SettingsModelDouble amplitude = SettingsModelDouble(
    label: 'amplitude',
    tooltip: 'The amplitude of the wave ',
    min: 0,
    max: 500,
    randomMin: 0,
    randomMax: 200,
    zoom: 100,
    defaultValue: 15,
    icon: Icon(Icons.weekend),
    proFeature: false,
  );

  SettingsModelDouble offset = SettingsModelDouble(
    label: 'Offset',
    tooltip: 'The slope of the wave ',
    min: -5,
    max: 5,
    randomMin: -2,
    randomMax: 2,
    zoom: 100,
    defaultValue: 1,
    icon: Icon(Icons.call_made),
    proFeature: false,
  );

  SettingsModelDouble fanWidth = SettingsModelDouble(
    label: 'Fan Width',
    tooltip: 'The amout the wave fans out',
    min: 0,
    max: 2000,
    randomMin: 0,
    randomMax: 200,
    zoom: 100,
    defaultValue: 15,
    icon: Icon(Icons.weekend),
    proFeature: false,
  );

  SettingsModelBool zigZag = SettingsModelBool(
    label: 'Zig Zag',
    tooltip: 'Make the baby zig!',
    defaultValue: false,
    icon: Icon(Icons.show_chart),
    proFeature: false,
  );

// palette settings
  SettingsModelColor backgroundColor = SettingsModelColor(
    label: "Background Color",
    tooltip: "The background colour for the canvas",
    defaultValue: Colors.white,
    icon: Icon(Icons.settings_overscan),
    proFeature: false,
  );
  SettingsModelBool randomColors = SettingsModelBool(
    label: 'Random Colors',
    tooltip: 'Randomise the coloursl',
    defaultValue: false,
    icon: Icon(Icons.gamepad),
    proFeature: false,
  );
  SettingsModelInt numberOfColors = SettingsModelInt(
    label: 'Number of Colors',
    tooltip: 'The number of colours in the palette',
    min: 1,
    max: 36,
    defaultValue: 10,
    icon: Icon(Icons.palette),
    proFeature: false,
  );
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
    proFeature: false,
  );
  SettingsModelDouble opacity = SettingsModelDouble(
    label: 'Opactity',
    tooltip: 'The opactity of the petal',
    min: 0.2,
    max: 1,
    zoom: 100,
    defaultValue: 1,
    icon: Icon(Icons.remove_red_eye),
    proFeature: false,
  );
  SettingsModelList paletteList = SettingsModelList(
    label: "Palette",
    tooltip: "Choose from a list of palettes",
    defaultValue: "Default",
    icon: Icon(Icons.palette),
    options: defaultPalleteNames(),
    proFeature: false,
  );

  SettingsModelButton resetDefaults = SettingsModelButton(
    label: 'Reset Defaults',
    tooltip: 'Reset all settings to defaults',
    defaultValue: false,
    icon: Icon(Icons.low_priority),
    proFeature: false,
  );

  List palette;
  double aspectRatio;
  File image;

// lock settings
  bool paletteLOCK = false;
  bool aspectRatioLOCK = false;

  Random random;

  Wave({
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

    this.stepX.randomise(rnd);
    this.stepY.randomise(rnd);
    this.frequency.randomise(rnd);
    this.amplitude.randomise(rnd);
    this.offset.randomise(rnd);
    this.fanWidth.randomise(rnd);
    this.zigZag.value = rnd.nextDouble()>0.8 ? true : false;

    // this.paletteList.randomise(random);
  }

  void randomizePalette() {
    print('-----------------------------------------------------');
    print('randomizePalette');
    print('-----------------------------------------------------');

    rnd = Random(DateTime.now().millisecond);

    this.backgroundColor.randomise(rnd);
    this.randomColors.randomise(rnd);
    this.numberOfColors.randomise(rnd);
    this.paletteType.randomise(rnd);
    this.opacity.randomise(rnd);

    int numberOfColors = this.numberOfColors.value;

    this.palette = randomisedPalette(this.paletteType.value, this.numberOfColors.value, rnd);


  }

  void defaultSettings() {
    // resets to default settings

    this.stepX.value = this.stepX.defaultValue;
    this.stepY.value = this.stepY.defaultValue;
    this.frequency.value = this.frequency.defaultValue;
    this.amplitude.value = this.amplitude.defaultValue;
    this.offset.value = this.offset.defaultValue;
    this.fanWidth.value = this.fanWidth.defaultValue;
    this.zigZag.value = this.zigZag.defaultValue;
    this.resetDefaults.value = this.resetDefaults.defaultValue;

    // palette settings
    this.backgroundColor.value = this.backgroundColor.defaultValue;
    this.randomColors.value = this.randomColors.defaultValue;
    this.numberOfColors.value = this.numberOfColors.defaultValue;
    this.paletteType.value = this.paletteType.defaultValue;
    this.opacity.value = this.opacity.defaultValue;
    this.paletteList.value = this.paletteList.defaultValue;


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
  currentWave.stepX,
  currentWave.stepY,
  currentWave.frequency,
  currentWave.amplitude,
  currentWave.offset,
  currentWave.fanWidth,
  currentWave.zigZag,
  currentWave.backgroundColor,
  currentWave.numberOfColors,
  currentWave.randomColors,
  currentWave.paletteType,
  currentWave.opacity,
  currentWave.paletteList,
  currentWave.resetDefaults,

];

class OpArtWaveStudio extends StatefulWidget {
  OpArtWaveStudio();

  @override
  _OpArtWaveStudioState createState() => _OpArtWaveStudioState();
}

class _OpArtWaveStudioState extends State<OpArtWaveStudio>
    with TickerProviderStateMixin {
  int _counter = 0;
  File _imageFile;
  int _currentColor = 0;

  Animation<double> animation1;
  AnimationController controller1;

  // Animation<double> animation2;
  // AnimationController controller2;

  cacheWave() async {
    WidgetsBinding.instance.addPostFrameCallback((_) => screenshotController
            .capture(delay: Duration(milliseconds: 100), pixelRatio: 0.2)
            .then((File image) async {
          currentWave.image = image;

          Map<String, dynamic> currentCache = {
            'aspectRatio': currentWave.aspectRatio,
            'stepX': currentWave.stepX.value,
            'stepY': currentWave.stepY.value,
            'frequency': currentWave.frequency.value,
            'amplitude': currentWave.amplitude.value,
            'offset': currentWave.offset.value,
            'zigZag': currentWave.zigZag.value,
            'fanWidth': currentWave.fanWidth.value,
            'backgroundColor': currentWave.backgroundColor.value,
            'randomColors': currentWave.randomColors.value,
            'numberOfColors': currentWave.numberOfColors.value,
            'paletteType': currentWave.paletteType.value,
            'opacity': currentWave.opacity.value,
            'image': currentWave.image,
            'palette': currentWave.palette,
          };
          cachedWaveList.add(currentCache);
          rebuildCache.value++;
          await new Future.delayed(const Duration(milliseconds: 20));
          if (_scrollController.hasClients) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          }
          enableButton = true;
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
                    painter: OpArtWavePainter(
                  seed, rnd,
                  animation1.value,
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
                      painter: OpArtWavePainter(
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

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomBottomAppBar(randomise: () {
          currentWave.randomize();
          currentWave.randomizePalette();
          rebuildCanvas.value++;
          cacheWave();
        }, randomisePalette: () {
          currentWave.randomizePalette();
          rebuildCanvas.value++;
          cacheWave();
        }, showToolBox: () {
          ToolBox(context, settingsList, cacheWave);
        }),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            height: 60,
            child: ValueListenableBuilder<int>(
              valueListenable: rebuildCache,
              builder: (context, value, child) {
                print('***********rebuilding');
                return cachedWaveList.length == 0

                  ? Container()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      itemCount: cachedWaveList.length,
                      reverse: false,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentWave.stepX.value = cachedWaveList[index]['stepX'];
                                currentWave.stepY.value = cachedWaveList[index]['stepY'];
                                currentWave.frequency.value = cachedWaveList[index]['frequency'];
                                currentWave.amplitude.value = cachedWaveList[index]['amplitude'];
                                currentWave.offset.value = cachedWaveList[index]['offset'];
                                currentWave.fanWidth.value = cachedWaveList[index]['fanWidth'];
                                currentWave.zigZag.value = cachedWaveList[index]['zigZag'];
                                currentWave.image = cachedWaveList[index]['image'];
                                currentWave.backgroundColor.value = cachedWaveList[index]['backgroundColor'];
                                currentWave.randomColors.value = cachedWaveList[index]['randomColors'];
                                currentWave.numberOfColors.value = cachedWaveList[index]['numberOfColors'];
                                currentWave.paletteType.value = cachedWaveList[index]['paletteType'];
                                currentWave.opacity.value = cachedWaveList[index]['opacity'];
                                currentWave.palette = cachedWaveList[index]['palette'];
                              });
                            },
                            child: Container(
                              decoration:
                                  BoxDecoration(shape: BoxShape.circle),
                              width: 50,
                              height: 50,
                              child: Image.file(
                                  cachedWaveList[index]['image']),
                            ),
                          ),
                        );
                      },
                    );
              })
          ),
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

      currentWave.randomize();
      currentWave.randomizePalette();
      rebuildCanvas.value++;
      cacheWave();
      //randomiseSettings();
    });
    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();

    // Animation Stuff
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7200),
    );

    // controller2 = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 60),
    // );

    Tween<double> _angleTween = Tween(begin: 0, end: 200);
    // Tween<double> _fillTween = Tween(begin: 1, end: 1);

    animation1 = _angleTween.animate(controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });

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

    controller1.forward();
    // controller2.forward();
    cacheWave();
  }

@override
void dispose() {
  controller1.dispose();
  // controller2.dispose();
  super.dispose();
}

}

class OpArtWavePainter extends CustomPainter {
  int seed;
  Random rnd;
  double animationVariable;
  // double fill;

  OpArtWavePainter(
    this.seed,
    this.rnd,
    this.animationVariable,
    // this.fill
  );

  @override
  void paint(Canvas canvas, Size size) {
    rnd = Random(seed);
    print('seed: $seed');

    print('----------------------------------------------------------------');
    print('Wave');
    print('----------------------------------------------------------------');

    // Initialise the palette
    if (currentWave == null) {
      currentWave = new Wave(random: rnd);
      currentWave.defaultSettings();
      currentNamedPalette = currentWave.paletteList.value;
    }
    if (currentNamedPalette != null &&
        currentWave.paletteList.value != currentNamedPalette) {
      // find the index of the palette in the list
      List newPalette = palettes.firstWhere((palette) => palette[0] == currentWave.paletteList.value);
      // set the palette details
      currentWave.numberOfColors.value = newPalette[1].toInt();
      currentWave.backgroundColor.value = Color(int.parse(newPalette[2]));
      currentWave.palette = [];
      for (int z = 0; z < currentWave.numberOfColors.value; z++) {
        currentWave.palette.add(Color(int.parse(newPalette[3][z])));
      }
      currentNamedPalette = currentWave.paletteList.value;
    } else if (currentWave.numberOfColors.value > currentWave.palette.length) {
      currentWave.randomizePalette();
    }

    if (currentWave == null) {
      currentWave = new Wave(random: rnd);
      currentWave.defaultSettings();
    }

    if (currentWave.numberOfColors.value > currentWave.palette.length) {
      currentWave.randomizePalette();
    }

    // reset the defaults
    print('reset${currentWave.resetDefaults.value}');
    if (currentWave.resetDefaults.value == true) {
      currentWave.defaultSettings();
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

    // if (currentWave.aspectRatio == pi/2){
    currentWave.aspectRatio = canvasWidth / canvasHeight;
    // }

    if (canvasWidth / canvasHeight < currentWave.aspectRatio) {
      borderY = (canvasHeight - canvasWidth / currentWave.aspectRatio) / 2;
      imageHeight = imageWidth / currentWave.aspectRatio;
    } else {
      borderX = (canvasWidth - canvasHeight * currentWave.aspectRatio) / 2;
      imageWidth = imageHeight * currentWave.aspectRatio;
    }

    print('aspectRatio = $currentWave.aspectRatio');
    print('imageWidth = $imageWidth');
    print('imageHeight = $imageHeight');
    print('borderX = $borderX');
    print('borderY = $borderY');

    print('numberOfColors: ${currentWave.numberOfColors}');
    print('opacity: ${currentWave.opacity}');
    print('paletteType: ${currentWave.paletteType}');
    print('randomColors: ${currentWave.randomColors}');

    int colourOrder = 0;


    print('currentWave.offset.value ${currentWave.offset.value}');
    // Now make some art
    generateWave(
      canvas,
      canvasWidth,
      canvasHeight,
      imageWidth,
      imageHeight,
      borderX,
      borderY,

      // angle, //currentWave.angleIncrement,
      currentWave.stepX.value,
      currentWave.stepY.value,
      currentWave.frequency.value,
      currentWave.amplitude.value,
      currentWave.offset.value,
      currentWave.fanWidth.value,
      currentWave.zigZag.value,
      currentWave.backgroundColor.value,
      currentWave.randomColors.value,
      currentWave.numberOfColors.value,
      currentWave.paletteType.value,
      currentWave.opacity.value,
      currentWave.palette,
      animationVariable,
    );
  }

  generateWave(
    Canvas canvas,
    double canvasWidth,
    double canvasHeight,
    double imageWidth,
    double imageHeight,
    double borderX,
    double borderY,
    double currentStepX,
    double currentStepY,
    double currentFrequency,
    double currentAmplitude,
    double currentOffset,
    double currentFanWidth,
    bool currentZigZag,
    Color currentBackgroundColor,
    bool currentRandomColors,
    int currentNumberOfColors,
    String currentPaletteType,
    double currentOpacity,
    List currentPalette,
    double animationVariable,
  ) {
    int colourOrder = 0;

    // colour in the canvas
    //a rectangle
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight * 2),
        Paint()
          ..color = currentBackgroundColor
          ..style = PaintingStyle.fill);

    double start = 0 - currentAmplitude;
    double end = imageWidth + currentStepX + currentAmplitude;

    for (double i = start; i < end; i += currentStepX) {
      Color waveColor;
      if (currentRandomColors) {
        waveColor = currentPalette[rnd.nextInt(currentNumberOfColors)];
      } else {
        colourOrder++;
        waveColor = currentPalette[colourOrder % currentNumberOfColors];
      }

      Path wave = Path();

      double j;
      for (j = 0; j < imageHeight + currentStepY; j += currentStepY) {

        double delta = 0.0;

        if (currentZigZag == false){
          delta = currentAmplitude * sin(pi * 2 * (j / imageHeight * currentFrequency + (currentOffset*animationVariable+animationVariable) * (i+imageWidth/2) / imageWidth)) + currentFanWidth * ((i -(imageWidth/2))/ imageWidth) * (j / imageHeight);
        }
        else {
          delta = currentAmplitude * asin(sin(pi * 2 * (j / imageHeight * currentFrequency + (currentOffset*animationVariable+animationVariable) * (i+imageWidth/2) / imageWidth))) + currentFanWidth * ((i -(imageWidth/2))/ imageWidth) * (j / imageHeight);
        }

        if (j == 0) {
          wave.moveTo(borderX + i + delta, borderY + j);
        } else {
          wave.lineTo(borderX + i + delta, borderY + j);
        }
      }
      for (double k = j; k >= -currentStepY; k -= currentStepY) {

        double delta = 0.0;

        if (currentZigZag == false){
          delta = currentAmplitude * sin(pi * 2 * (k / imageHeight * currentFrequency + (currentOffset*animationVariable+animationVariable) * ((i+imageWidth/2) + currentStepX) / imageWidth)) + currentFanWidth * (((i + currentStepX) -(imageWidth/2))/ imageWidth) * (k / imageHeight);
        }
        else
        {
          delta = currentAmplitude * asin(sin(pi * 2 * (k / imageHeight * currentFrequency + (currentOffset*animationVariable+animationVariable) * ((i+imageWidth/2) + currentStepX) / imageWidth))) + currentFanWidth * (((i + currentStepX) -(imageWidth/2))/ imageWidth) * (k / imageHeight);
        }

        wave.lineTo(borderX + i + currentStepX + delta, borderY + k);
      }

//      wave.lineTo(borderX + imageWidth, borderY + imageHeight);
      wave.close();

      canvas.drawPath(
          wave,
          Paint()
            ..style = PaintingStyle.fill
            ..color = waveColor);
    }

    // colour in the outer canvas
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Offset(-canvasWidth, 0) & Size(canvasWidth + borderX, canvasHeight),
        paint1);
    canvas.drawRect(
        Offset(canvasWidth - borderX, 0) &
            Size(borderX + canvasWidth, canvasHeight),
        paint1);

    canvas.drawRect(
        Offset(-canvasWidth, -canvasHeight) &
            Size(3 * canvasWidth, canvasHeight + borderY),
        paint1);
    canvas.drawRect(
        Offset(-canvasWidth, borderY + canvasHeight) &
            Size(3 * canvasWidth, borderY + canvasHeight * 2),
        paint1);
  }

  @override
  bool shouldRepaint(OpArtWavePainter oldDelegate) => false;
}
