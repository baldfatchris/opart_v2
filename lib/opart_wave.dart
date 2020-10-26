import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:shake/shake.dart';

import 'model.dart';
import 'palettes.dart';


Random rnd;

// Settings
Wave currentWave;

// Load the palettes
List palettes = defaultPalettes();
String currentNamedPalette;

List<Map<String, dynamic>> waveCachedList = List<Map<String, dynamic>>();
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
    tooltip: 'randomize the coloursl',
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

List<dynamic> waveSettingsList = [
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
void waveRandomize() {
  print('-----------------------------------------------------');
  print('randomize');
  print('-----------------------------------------------------');

  rnd = Random(DateTime.now().millisecond);

  currentWave.stepX.randomize(rnd);
  currentWave.stepY.randomize(rnd);
  currentWave.frequency.randomize(rnd);
  currentWave.amplitude.randomize(rnd);
  currentWave.offset.randomize(rnd);
  currentWave.fanWidth.randomize(rnd);
  currentWave.zigZag.value = rnd.nextDouble()>0.8 ? true : false;

  // this.paletteList.randomize(random);
}
void waveRandomizePalette() {
  print('-----------------------------------------------------');
  print('randomizePalette');
  print('-----------------------------------------------------');

  rnd = Random(DateTime.now().millisecond);

  currentWave.backgroundColor.randomize(rnd);
  currentWave.randomColors.randomize(rnd);
  currentWave.numberOfColors.randomize(rnd);
  currentWave.paletteType.randomize(rnd);
  currentWave.opacity.randomize(rnd);

  int numberOfColors = currentWave.numberOfColors.value;

  currentWave.palette = randomizedPalette(currentWave.paletteType.value, currentWave.numberOfColors.value, rnd);


}
waveAddToCache() async {
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
    waveCachedList.add(currentCache);
    rebuildCache.value++;
    await new Future.delayed(const Duration(milliseconds: 20));
    if (scrollController.hasClients) {
      scrollController
          .jumpTo(scrollController.position.maxScrollExtent);
    }
    enableButton = true;
  }));
}
Widget waveBodyWidget(Animation animation1) {
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
waveRevertToCache(index){
  currentWave.stepX.value = waveCachedList[index]['stepX'];
  currentWave.stepY.value = waveCachedList[index]['stepY'];
  currentWave.frequency.value = waveCachedList[index]['frequency'];
  currentWave.amplitude.value = waveCachedList[index]['amplitude'];
  currentWave.offset.value = waveCachedList[index]['offset'];
  currentWave.fanWidth.value = waveCachedList[index]['fanWidth'];
  currentWave.zigZag.value = waveCachedList[index]['zigZag'];
  currentWave.image = waveCachedList[index]['image'];
  currentWave.backgroundColor.value = waveCachedList[index]['backgroundColor'];
  currentWave.randomColors.value = waveCachedList[index]['randomColors'];
  currentWave.numberOfColors.value = waveCachedList[index]['numberOfColors'];
  currentWave.paletteType.value = waveCachedList[index]['paletteType'];
  currentWave.opacity.value = waveCachedList[index]['opacity'];
  currentWave.palette = waveCachedList[index]['palette'];
  rebuildCache.value++;
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

    print('----------------------------------------------------------------');
    print('Wave');
    print('----------------------------------------------------------------');

    print('seed: $seed');
    print('animationVariable: $animationVariable');

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
      waveRandomizePalette();
    }

    if (currentWave == null) {
      currentWave = new Wave(random: rnd);
      currentWave.defaultSettings();
    }

    if (currentWave.numberOfColors.value > currentWave.palette.length) {
      waveRandomizePalette();
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
      animationVariable * 100,
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
          delta = currentAmplitude * sin(pi * 2 * (j / imageHeight * currentFrequency + currentOffset * (animationVariable / 0.5) * (2*i-imageWidth) / imageWidth)) + currentFanWidth * ((i -(imageWidth/2))/ imageWidth) * (j / imageHeight);
        }
        else {
          delta = currentAmplitude * asin(sin(pi * 2 * (j / imageHeight * currentFrequency + currentOffset * (animationVariable / 0.5) * (2*i-imageWidth) / imageWidth))) + currentFanWidth * ((i -(imageWidth/2))/ imageWidth) * (j / imageHeight);
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
          delta = currentAmplitude * sin(pi * 2 * (k / imageHeight * currentFrequency + currentOffset * (animationVariable / 0.5) * (2*(i + currentStepX)-imageWidth) / imageWidth)) + currentFanWidth * (((i + currentStepX) -(imageWidth/2))/ imageWidth) * (k / imageHeight);
        }
        else
        {
          delta = currentAmplitude * asin(sin(pi * 2 * (k / imageHeight * currentFrequency + currentOffset * (animationVariable / 0.5) * (2*(i + currentStepX)-imageWidth) / imageWidth))) + currentFanWidth * (((i + currentStepX) -(imageWidth/2))/ imageWidth) * (k / imageHeight);
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
