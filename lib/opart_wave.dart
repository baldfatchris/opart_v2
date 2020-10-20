import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'package:screenshot/screenshot.dart';
import 'package:shake/shake.dart';
import 'package:opart_v2/setting_slider.dart';
import 'package:opart_v2/setting_intslider.dart';
import 'package:opart_v2/setting_dropdown.dart';
import 'package:opart_v2/setting_radiobutton.dart';
import 'model.dart';

Random rnd;

// Settings
Wave currentWave;

List Palettes = [
  ['default',10,Color(0xFFffffff),[Color(0xFF34a1af),Color(0xFFa570a8),Color(0xFFd6aa27),Color(0xFF5f9d50),Color(0xFF789dd1),Color(0xFFc25666), Color(0xFF2b7b1),Color(0xFFd63aa),Color(0xFF1f4ed),Color(0xFF383c47)]]
];

class Wave {
  // image settings



  SettingsModelDouble stepX = SettingsModelDouble(label: 'stepX',tooltip: 'The horizontal width of each stripe ', min: 0.01, max: 50, defaultValue: 10, icon: Icon(Icons.ac_unit));
  SettingsModelDouble stepY = SettingsModelDouble(label: 'stepY',tooltip: 'The vertical distance between points on each stripe ',min: 0.01,max: 500, defaultValue: 0.1, icon: Icon(Icons.bluetooth_audio));
  SettingsModelDouble frequency = SettingsModelDouble(label: 'frequency',tooltip: 'The frequency of the wave ', min: 0, max: 5, defaultValue: 1, icon: Icon(Icons.smoke_free));
  SettingsModelDouble amplitude = SettingsModelDouble(label: 'amplitude',tooltip: 'The amplitude of the wave ', min: 0, max: 500, defaultValue: 100, icon: Icon(Icons.weekend));

// palette settings
  Color backgroundColour;

  SettingsModelBool randomColours = SettingsModelBool(label: 'Random Colours', tooltip: 'Randomise the colours', defaultValue: false, icon: Icon(Icons.gamepad));
  SettingsModelInt numberOfColours = SettingsModelInt(label: 'Number of Colours',tooltip: 'The number of colours in the palette', min: 2, max: 36, defaultValue: 10, icon: Icon(Icons.book));
  SettingsModelList paletteType = SettingsModelList(label: "Palette Type", tooltip: "The nature of the palette", defaultValue: "random", icon: Icon(Icons.colorize), options: ['random', 'blended random ', 'linear random', 'linear complementary'],);
  SettingsModelDouble opacity = SettingsModelDouble(label: 'Opactity', tooltip: 'The opactity of the petal', min: 0, max: 1, defaultValue: 1, icon: Icon(Icons.opacity));

  List palette;
  double aspectRatio;
  File image;

// lock settings
  bool backgroundColourLOCK = false;
  bool paletteLOCK = false;
  bool aspectRatioLOCK = false;

  Random random;

  Wave({
    this.backgroundColour,
    this.palette,

    this.aspectRatio = pi / 2,
    this.image,
    this.backgroundColourLOCK = false,
    this.paletteLOCK = false,
    this.aspectRatioLOCK = false,
    this.random,
  });

  void randomize() {
    print('-----------------------------------------------------');
    print('randomize');
    print('-----------------------------------------------------');

    this.stepX.randomise(random);
    this.stepY.randomise(random);
    this.frequency.randomise(random);
    this.amplitude.randomise(random);

    // backgroundColour
    if (this.backgroundColourLOCK == false) {
      this.backgroundColour = Color((random.nextDouble() * 0xFFFFFF).toInt());
    }

    this.randomColours.randomise(random);
    this.numberOfColours.randomise(random);
    this.paletteType.randomise(random);
    this.opacity.randomise(random);

    if (this.aspectRatioLOCK == false) {
      // this.aspectRatio = random.nextDouble() + 0.5;
      // if (random.nextBool()){
      this.aspectRatio = pi / 2;
      // }
    }

  }

  void randomizePalette() {
    print('-----------------------------------------------------');
    print('randomizePalette');
    print('-----------------------------------------------------');

    rnd = Random(DateTime.now().millisecond);


    List palette = [];
    switch (this.paletteType.value) {

    // blended random
      case 'blended random':
        {
          double blendColour = rnd.nextDouble() * 0xFFFFFF;
          for (int colourIndex = 0;
          colourIndex < this.numberOfColours.value;
          colourIndex++) {
            palette.add(
                Color(((blendColour + rnd.nextDouble() * 0xFFFFFF) / 2).toInt())
                    .withOpacity(1));
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
          colourIndex < this.numberOfColours.value;
          colourIndex++) {
            palette.add(Color.fromRGBO(
                ((startColour[0] * colourIndex +
                    endColour[0] *
                        (this.numberOfColours.value - colourIndex)) /
                    this.numberOfColours.value)
                    .round(),
                ((startColour[1] * colourIndex +
                    endColour[1] *
                        (this.numberOfColours.value - colourIndex)) /
                    this.numberOfColours)
                    .round(),
                ((startColour[2] * colourIndex +
                    endColour[2] *
                        (this.numberOfColours.value - colourIndex)) /
                    this.numberOfColours.value)
                    .round(),
                1));
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
          colourIndex < this.numberOfColours.value;
          colourIndex++) {
            palette.add(Color.fromRGBO(
                ((startColour[0] * colourIndex +
                    endColour[0] *
                        (this.numberOfColours.value - colourIndex)) /
                    this.numberOfColours)
                    .round(),
                ((startColour[1] * colourIndex +
                    endColour[1] *
                        (this.numberOfColours.value - colourIndex)) /
                    this.numberOfColours.value)
                    .round(),
                ((startColour[2] * colourIndex +
                    endColour[2] *
                        (this.numberOfColours.value - colourIndex)) /
                    this.numberOfColours.value)
                    .round(),
                1));
          }
        }
        break;

    // random
      default:
        {
          for (int colorIndex = 0;
          colorIndex < this.numberOfColours.value;
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

    this.stepX.value = this.stepX.defaultValue;
    this.stepY.value = this.stepY.defaultValue;
    this.frequency.value = this.frequency.defaultValue;
    this.amplitude.value = this.amplitude.defaultValue;

    // palette settings
    this.backgroundColour = Colors.white;

    this.randomColours.value = this.randomColours.defaultValue;

    this.numberOfColours.value = this.numberOfColours.defaultValue;
    this.paletteType.value = this.paletteType.defaultValue;

    this.opacity.value = this.opacity.defaultValue;

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


    this.backgroundColourLOCK = false;
    this.paletteLOCK = false;
    this.aspectRatioLOCK = false;
  }
}

List settingsList = [
  currentWave.stepX,
  currentWave.stepY,
  currentWave.frequency,
  currentWave.amplitude,
  currentWave.paletteType,
  currentWave.numberOfColours,
  currentWave.opacity,
  currentWave.randomColours,
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
                    currentWave.randomizePalette();
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
                    currentWave.randomize();
                    currentWave.randomizePalette();
                  });
                },
              ),
            ),
          ],
        ),


      ],
    );
  }

  List<Wave> cachedWaveList = [];
  cacheWave(ScreenshotController screenshotController, Function SetState) async {
    print('cache wave');
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 0.2)
        .then((File image) async {
      currentWave.image = image;

      cachedWaveList.add(Wave(
        // stepX: currentWave.stepX,
        // stepY: currentWave.stepY,
        // frequency: currentWave.frequency,
        // amplitude: currentWave.amplitude,
        // numberOfColours: currentWave.numberOfColours,
        // paletteType: currentWave.paletteType,
        palette: currentWave.palette,
        aspectRatio: currentWave.aspectRatio,
        image: currentWave.image,
      ));
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
                    painter: OpArtWavePainter(
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
    SetState(){
      setState(() {

      });
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
                      painter: OpArtWavePainter(
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
      showModalBottomSheet(
          backgroundColor: Colors.white.withOpacity(0.8),
          barrierColor: Colors.white.withOpacity(0.1),
          context: context,
          builder: (BuildContext bc) {
            return StatefulBuilder(
                builder: (BuildContext context, setLocalState) {
                  return Column(
                    children: <Widget>[
                      Container(
                          height: 200,
                          child:
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
                            }, (){


                          },
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
                          settingsRadioButton(
                            settingsList[index].label,
                            settingsList[index].tooltip,
                            settingsList[index].value,
                            settingsList[index].locked,

                                (value) {
                              setState(() {
                                settingsList[index].value = value.round();
                              });
                              setLocalState((){});
                            },
                                () {
                              setState(() {
                                settingsList[index].locked = !settingsList[index].locked;
                              });
                            },

                          )


                      ),
                      Container(height: 100)
                    ],
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
                      return Container(height: 100, width: 100,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _showBottomSheetSettings(context, index);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [settingsList[index].icon,Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(height: 50,child: Text(settingsList[index].label, textAlign: TextAlign.center,)),
                            )],
                          ),
                        ),
                      );})
            );});}



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
                        currentWave.randomize();
                        currentWave.randomizePalette();
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
                    child: Text(
                      'Tools',
                      textAlign: TextAlign.center,
                    )),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        currentWave.randomizePalette();
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
          Flexible(
            flex: 7,
            child: bodyWidget(),
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
        currentWave.randomize();
        currentWave.randomizePalette();
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

class OpArtWavePainter extends CustomPainter {
  int seed;
  Random rnd;
  // double angle;
  // double fill;

  OpArtWavePainter(
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
    print('Wave');
    print('----------------------------------------------------------------');


    if (currentWave == null) {
      currentWave = new Wave(random: rnd);
      currentWave.defaultSettings();
    }

    if (currentWave.numberOfColours.value>currentWave.palette.length){
      currentWave.randomizePalette();
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

    print('numberOfColours: ${currentWave.numberOfColours}');
    print('opacity: ${currentWave.opacity}');
    print('paletteType: ${currentWave.paletteType}');
    print('randomColours: ${currentWave.randomColours}');

    int colourOrder = 0;

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
      currentWave.backgroundColour,
      currentWave.randomColours.value,
      currentWave.numberOfColours.value,
      currentWave.paletteType.value,
      currentWave.opacity.value,
      currentWave.palette,
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
      Color currentBackgroundColour,
      bool currentRandomColours,
      int currentNumberOfColours,
      String currentPaletteType,
      double currentOpacity,
      List currentPalette,
      ) {

    int colourOrder = 0;


    // colour in the canvas
    //a rectangle
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight * 2),
        Paint()
          ..color = currentBackgroundColour
          ..style = PaintingStyle.fill);



    double offset = 1;
    double start = 0 - currentAmplitude;
    double end = imageWidth + currentStepX + currentAmplitude;

    for (double i = start; i < end; i+= currentStepX ) {

      Color waveColor;
      if (currentRandomColours){
        waveColor = currentPalette[rnd.nextInt(currentNumberOfColours)];
      }
      else
      {
        colourOrder++;
        waveColor = currentPalette[colourOrder%currentNumberOfColours];
      }

      // var paint1 = Paint()
      //   ..color = waveColor
      //   ..style = PaintingStyle.fill;
      // canvas.drawRect(Offset(borderX + i, borderY) & Size(stepX, imageHeight), paint1);

      Path wave = Path();

      double j;
      for (j = 0; j < imageHeight + currentStepY; j+=currentStepY) {
        var delta = currentAmplitude * sin(pi * 2 * (j / imageHeight * currentFrequency + offset * i / imageWidth));
        if (j==0){
          wave.moveTo(borderX + i + delta, borderY + j);
        }
        else{
          wave.lineTo(borderX + i + delta, borderY + j);
        }
      }
      for (double k = j; k >= -currentStepY; k-=currentStepY) {
        var delta = currentAmplitude * sin(pi * 2 * (k / imageHeight * currentFrequency + offset * (i+currentStepX) / imageWidth));
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

  @override
  bool shouldRepaint(OpArtWavePainter oldDelegate) => false;
}
