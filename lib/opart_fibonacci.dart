import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'package:screenshot/screenshot.dart';
import 'package:shake/shake.dart';
import 'package:opart_v2/setting_slider.dart';
import 'package:opart_v2/setting_dropdown.dart';


Random rnd;

// Settings
Fibonacci currentFibonacci;



class Fibonacci {

  // image settings
  double angleIncrement;
  double flowerFill;
  double petalToRadius;
  double ratio;
  double randomiseAngle;
  double petalPointiness;
  double petalRotation;
  double petalRotationRatio;
  String petalType;
  int maxPetals;
  double radialOscAmplitude;
  double radialOscPeriod;
  bool direction;

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
  bool angleIncrementLOCK = false;
  bool flowerFillLOCK = false;
  bool petalToRadiusLOCK = false;
  bool ratioLOCK = false;
  bool randomiseAngleLOCK = false;
  bool petalPointinessLOCK = false;
  bool petalRotationLOCK = false;
  bool petalRotationRatioLOCK = false;
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
        this.angleIncrement,
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
        this.aspectRatio = pi/2,
        this.image,

        this.angleIncrementLOCK = false,
        this.flowerFillLOCK = false,
        this.petalToRadiusLOCK = false,
        this.ratioLOCK = false,
        this.randomiseAngleLOCK = false,
        this.petalPointinessLOCK = false,
        this.petalRotationLOCK = false,
        this.petalRotationRatioLOCK = false,
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



  void randomize(){

    // angleIncrement 0 - pi
    if (this.angleIncrementLOCK == false) {
      this.angleIncrement = random.nextDouble()*pi;
    }

    // flowerFill 0.7 - 1.3
    if (this.flowerFillLOCK == false) {
      this.flowerFill = random.nextDouble() * 0.6 + 0.7;
    }

    // petalToRadius - 0 01 to 0.1
    if (this.petalToRadiusLOCK == false) {
      this.petalToRadius = random.nextDouble() * 0.09 + 0.01;
    }

    // ratio 0.995 - 0.99999
    if (this.ratioLOCK == false) {
      this.ratio = random.nextDouble() * 0.00499 + 0.995;
    }

    // randomiseAngle 0 to 0.2
    if (this.randomiseAngleLOCK == false){
      this.randomiseAngle = 0;
      if (random.nextDouble() > 0.8) {
        this.randomiseAngle = random.nextDouble() * 0.2;
      }
    }

    // petalPointiness: 0 to pi
    if (this.petalPointinessLOCK == false) {
      this.petalPointiness = random.nextDouble() * pi;
    }

    // petalRotation: 0 to pi
    if (this.petalRotationLOCK == false) {
      this.petalRotation = random.nextDouble() * pi;
    }

    // petalRotationRatio 0 to 4
    if (this.petalRotationRatioLOCK == false) {
      this.petalRotationRatio = random.nextDouble() * 4;
      if (random.nextDouble() > 0.3) {
        this.petalRotationRatio = random.nextInt(4).toDouble();
      }
    }

    // petalType = 0/1/2/3  circle/triangle/square/petal
    if (this.petalTypeLOCK == false) {
      this.petalType = ['circle','triangle','square','petal'][random.nextInt(3)];
    }


    // maxPetals = 5000 to 10000;
    if (this.maxPetalsLOCK == false) {
      this.maxPetals = random.nextInt(5000)+5000;
    }


    // radialOscAmplitude 0 to 5
    if (this.radialOscAmplitudeLOCK == false) {
      this.radialOscAmplitude = 0;
      if (random.nextDouble()>0.7){
        this.radialOscAmplitude = random.nextDouble() * 5;
      }
    }

    // radialOscPeriod 0 to 2
    if (this.radialOscPeriodLOCK == false) {
      this.radialOscPeriod = random.nextDouble() * 2;
    }

    // direction
    if (this.directionLOCK == false){
      this.direction = random.nextBool();
    }


    if (this.aspectRatioLOCK == false) {
      // this.aspectRatio = random.nextDouble() + 0.5;
      // if (random.nextBool()){
        this.aspectRatio=pi/2;
      // }
    }

  }

  void randomizePalette() {

    rnd = Random(DateTime.now().millisecond);


    // numberOfColours 2 to 36
    if (this.numberOfColoursLOCK == false) {
      this.numberOfColours = rnd.nextInt(34) + 2;
    }

    // randomColours
    if (this.randomColoursLOCK == false) {
      this.randomColours = rnd.nextBool();
    }

    // lineWidth 0 to 3
    if (this.lineWidthLOCK == false) {
      this.lineWidth = rnd.nextDouble() * 3;
    }

    // opacity 0.6 to 1
    if (this.opacityLOCK == false) {
      this.opacity = rnd.nextDouble() * 0.4 + 0.6;
    }

    // backgroundColour
    if (this.backgroundColourLOCK == false) {
      this.backgroundColour = Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity);
    }

    // lineColour
    if (this.lineColourLOCK == false) {
      this.lineColour = Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity);
    }

    List palette = [];
    switch(this.paletteType){

    // blended random
      case 'blended random':{
        double blendColour = rnd.nextDouble() * 0xFFFFFF;
        for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++){
          palette.add(Color(((blendColour + rnd.nextDouble() * 0xFFFFFF)/2).toInt()).withOpacity(opacity));
        }
      }
      break;

    // linear random
      case 'linear random':{
        List startColour = [rnd.nextInt(255),rnd.nextInt(255),rnd.nextInt(255)];
        List endColour = [rnd.nextInt(255),rnd.nextInt(255),rnd.nextInt(255)];
        for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++){
          palette.add(Color.fromRGBO(
              ((startColour[0]*colourIndex + endColour[0]*(numberOfColours-colourIndex))/numberOfColours).round(),
              ((startColour[1]*colourIndex + endColour[1]*(numberOfColours-colourIndex))/numberOfColours).round(),
              ((startColour[2]*colourIndex + endColour[2]*(numberOfColours-colourIndex))/numberOfColours).round(),
              opacity));
        }
      }
      break;

    // linear complementary
      case 'linear complementary':{
        List startColour = [rnd.nextInt(255),rnd.nextInt(255),rnd.nextInt(255)];
        List endColour = [255-startColour[0],255-startColour[1],255-startColour[2]];
        for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++){
          palette.add(Color.fromRGBO(
              ((startColour[0]*colourIndex + endColour[0]*(numberOfColours-colourIndex))/numberOfColours).round(),
              ((startColour[1]*colourIndex + endColour[1]*(numberOfColours-colourIndex))/numberOfColours).round(),
              ((startColour[2]*colourIndex + endColour[2]*(numberOfColours-colourIndex))/numberOfColours).round(),
              opacity));
        }
      }
      break;

    // random
      default: {
        for (int colorIndex = 0; colorIndex < numberOfColours; colorIndex++){
          palette.add(Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity));
        }
      }
      break;

    }

    this.palette = palette;
  }
}



class OpArtFibonacciStudio extends StatefulWidget {

  int seed;
  bool showSettings;
  ScreenshotController screenshotController;

  OpArtFibonacciStudio(this.seed, this.showSettings, {this.screenshotController});

  @override
  _OpArtFibonacciStudioState createState() => _OpArtFibonacciStudioState();


}

class _OpArtFibonacciStudioState extends State<OpArtFibonacciStudio> {
  int _counter = 0;
  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  int _currentColor = 0;
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

                onPressed:() {
                  setState(() {

                    print('Randomise Palette');
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

                onPressed:() {
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
        settingsSlider('angleIncrement', currentFibonacci.angleIncrement, 0, 2*pi, currentFibonacci.angleIncrementLOCK,
              (value) {setState(() {currentFibonacci.angleIncrement = value;
              print('currentFibonacci.angleIncrement: ${currentFibonacci.angleIncrement}');
              });},
              () {setState(() {currentFibonacci.angleIncrementLOCK = !currentFibonacci.angleIncrementLOCK;});},
        ),


        // flowerFill
        settingsSlider('flowerFill', currentFibonacci.flowerFill, 0.5, 2, currentFibonacci.flowerFillLOCK,
              (value) {setState(() {currentFibonacci.flowerFill = value;});},
              () {setState(() {currentFibonacci.flowerFillLOCK = !currentFibonacci.flowerFillLOCK;});},
        ),

        // ratio
        settingsSlider('ratio', currentFibonacci.ratio, 0.99, 0.99999, currentFibonacci.ratioLOCK,
              (value) {setState(() {currentFibonacci.ratio = value;});},
              () {setState(() {currentFibonacci.ratioLOCK = !currentFibonacci.ratioLOCK;});},
        ),

        // randomiseAngle
        settingsSlider('randomiseAngle', currentFibonacci.randomiseAngle, 0, 0.2, currentFibonacci.randomiseAngleLOCK,
              (value) {setState(() {currentFibonacci.randomiseAngle = value;});},
              () {setState(() {currentFibonacci.randomiseAngleLOCK = !currentFibonacci.randomiseAngleLOCK;});},
        ),

        // petalToRadius
        settingsSlider('petalToRadius', currentFibonacci.petalToRadius, 0.001, 0.5, currentFibonacci.petalToRadiusLOCK,
              (value) {setState(() {currentFibonacci.petalToRadius = value;});},
              () {setState(() {currentFibonacci.petalToRadiusLOCK = !currentFibonacci.petalToRadiusLOCK;});},
        ),

        // petalType
        settingsDropdown('petalType', currentFibonacci.petalType, ['circle','triangle','square','petal'], currentFibonacci.petalTypeLOCK,
              (value) {setState(() {currentFibonacci.petalType = value;});},
              () {setState(() {currentFibonacci.petalToRadiusLOCK = !currentFibonacci.petalTypeLOCK;});},
        ),

        // petalPointiness
        settingsSlider('petalPointiness', currentFibonacci.petalPointiness, 0, pi, currentFibonacci.petalPointinessLOCK,
              (value) {setState(() {currentFibonacci.petalPointiness = value;});},
              () {setState(() {currentFibonacci.petalPointinessLOCK = !currentFibonacci.petalPointinessLOCK;});},
        ),

       // petalRotation 0 to pi
        settingsSlider('petalRotation', currentFibonacci.petalRotation, 0, pi, currentFibonacci.petalRotationLOCK,
              (value) {setState(() {currentFibonacci.petalRotation = value;});},
              () {setState(() {currentFibonacci.petalRotationLOCK = !currentFibonacci.petalRotationLOCK;});},
        ),

      // petalRotationRatioRatio 0 to 4
        settingsSlider('petalRotationRatio', currentFibonacci.petalRotationRatio, 0, 4, currentFibonacci.petalRotationRatioLOCK,
              (value) {setState(() {currentFibonacci.petalRotationRatio = value;});},
              () {setState(() {currentFibonacci.petalRotationRatioLOCK = !currentFibonacci.petalRotationRatioLOCK;});},
        ),

        // radialOscAmplitude
        settingsSlider('radialOscAmplitude', currentFibonacci.radialOscAmplitude, 0, 5, currentFibonacci.radialOscAmplitudeLOCK,
              (value) {setState(() {currentFibonacci.radialOscAmplitude = value;});},
              () {setState(() {currentFibonacci.radialOscAmplitudeLOCK = !currentFibonacci.radialOscAmplitudeLOCK;});},
        ),

        // radialOscPeriod
        settingsSlider('radialOscPeriod', currentFibonacci.radialOscPeriod, 0, 2, currentFibonacci.radialOscPeriodLOCK,
              (value) {setState(() {currentFibonacci.radialOscPeriod = value;});},
              () {setState(() {currentFibonacci.radialOscPeriodLOCK = !currentFibonacci.radialOscPeriodLOCK;});},
        ),

        // maxPetals 1000 to 10000
        settingsSlider('maxPetals', currentFibonacci.maxPetals.toDouble(), 1, 10000, currentFibonacci.maxPetalsLOCK,
              (value) {setState(() {currentFibonacci.maxPetals = value.toInt();});},
              () {setState(() {currentFibonacci.maxPetalsLOCK = !currentFibonacci.maxPetalsLOCK;});},
        ),

        // lineWidth 0-3
        settingsSlider('lineWidth', currentFibonacci.lineWidth, 0, 3, currentFibonacci.lineWidthLOCK,
              (value) {setState(() {currentFibonacci.lineWidth = value;});},
              () {setState(() {currentFibonacci.lineWidthLOCK = !currentFibonacci.lineWidthLOCK;});},
        ),


        // numberOfColours
        settingsSlider('numberOfColours', currentFibonacci.numberOfColours.toDouble(), 1, 36, currentFibonacci.numberOfColoursLOCK,
              (value) {setState(() {
                  if (currentFibonacci.numberOfColours < value.toInt())
                    {
                      currentFibonacci.numberOfColours = value.toInt();
                      currentFibonacci.randomizePalette();
                    }
                  else
                    {
                      currentFibonacci.numberOfColours = value.toInt();
                    }
              });},
              () {setState(() {currentFibonacci.numberOfColoursLOCK = !currentFibonacci.numberOfColoursLOCK;});},
        ),


        // randomColours
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex:1,
              child: GestureDetector(
                  onLongPress: (){
                    setState(() {
                      // toggle lock
                      if (currentFibonacci.randomColoursLOCK){
                        currentFibonacci.randomColoursLOCK=false;
                        print('randomColours UNLOCK');
                      } else {
                        currentFibonacci.randomColoursLOCK=true;
                        print('randomColours LOCK');
                      }
                    });
                  },
                  child: Row(
                    children:[
                      Text(
                        'randomColours:',
                        style: currentFibonacci.randomColoursLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        currentFibonacci.randomColoursLOCK ? Icons.lock : Icons.lock_open,
                        size: 20,
                        color: currentFibonacci.randomColoursLOCK ? Colors.grey : Colors.black,
                      ),
                    ],
                  )
              ),
            ),
            Flexible(
              flex:2,
              child: Switch(
                value: currentFibonacci.randomColours,
                onChanged: currentFibonacci.randomColoursLOCK ? null : (value) {
                  setState(() {
                    currentFibonacci.randomColours  = value;
                  });
                },
              ),
            ),

          ],
        ),


        // paletteType
        settingsDropdown('paletteType', currentFibonacci.paletteType, ['random','blended random','linear random','linear complementary'], currentFibonacci.paletteTypeLOCK,
              (value) {setState(() {print('new paletteType: $value');currentFibonacci.paletteType = value;currentFibonacci.randomizePalette();});},
              () {setState(() {currentFibonacci.petalToRadiusLOCK = !currentFibonacci.paletteTypeLOCK;});},
        ),

        // aspectRatio
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        // toggle lock
                        if (currentFibonacci.aspectRatioLOCK){
                          currentFibonacci.aspectRatioLOCK=false;
                        } else {
                          currentFibonacci.aspectRatioLOCK=true;
                        }
                      });
                    },
                    child: Row(
                      children:[
                        Text(
                          'aspectRatio:',
                          style: currentFibonacci.aspectRatioLOCK ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          currentFibonacci.aspectRatioLOCK ? Icons.lock : Icons.lock_open,
                          size: 20,
                          color: currentFibonacci.aspectRatioLOCK ? Colors.grey : Colors.black,
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 2,
              child: Slider(
                value: currentFibonacci.aspectRatio,
                min: 0.5,
                max: 2,
                onChanged: currentFibonacci.aspectRatioLOCK ? null : (value) {
                  setState(() {
                    currentFibonacci.aspectRatio  = value;
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
                child: CustomPaint(painter: OpArtFibonacciPainter(widget.seed, rnd)),
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
                  child: CustomPaint(painter: OpArtFibonacciPainter(widget.seed, rnd)),
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
      print('---------------------------------------------------------------------------');
      print('SHAKE');
      print('---------------------------------------------------------------------------');
      setState(() {
        currentFibonacci.randomize();
        currentFibonacci.randomizePalette();
        //randomiseSettings();
      });
    });
    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

}

class OpArtFibonacciPainter extends CustomPainter {
  int seed;
  Random rnd;

  OpArtFibonacciPainter( this.seed, this.rnd);

  @override
  void paint(Canvas canvas, Size size) {

    rnd = Random(seed);
    print('seed: $seed');


    print('----------------------------------------------------------------');
    print('Fibonacci');
    print('----------------------------------------------------------------');

    if (currentFibonacci == null){
      currentFibonacci = new Fibonacci(random: rnd);
      currentFibonacci.randomize();
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
      currentFibonacci.aspectRatio = canvasWidth/canvasHeight;
    // }

    if (canvasWidth / canvasHeight < currentFibonacci.aspectRatio) {
      borderY = (canvasHeight - canvasWidth / currentFibonacci.aspectRatio) / 2;
      imageHeight = imageWidth / currentFibonacci.aspectRatio;
    }
    else {
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
    // set the initial palette


    print('randomColours: ${currentFibonacci.randomColours}');


    int colourOrder = 0;



    // Now make some art


    // colour in the canvas
    //a rectangle
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight*2), Paint()
      ..color = currentFibonacci.backgroundColour
      ..style = PaintingStyle.fill);



    generateFlower(
        canvas,
        imageWidth,
        imageHeight,
        borderX,
        borderY,
        flowerCentreX,
        flowerCentreY
    );






    // colour in the outer canvas
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(0, 0) & Size(borderX, canvasHeight), paint1);
    canvas.drawRect(Offset(canvasWidth-borderX, 0) & Size(borderX, canvasHeight), paint1);

    canvas.drawRect(Offset(0, 0) & Size(canvasWidth, borderY ), paint1);
    canvas.drawRect(Offset(0, canvasHeight-borderY, ) & Size(canvasWidth, borderY+canvasHeight*2), paint1);




  }


  generateFlower(
      Canvas canvas,
      double width,
      double height,
      double borderX,
      double borderY,
      flowerCentreX,
      flowerCentreY) {

    int maxPetalCount = currentFibonacci.maxPetals;

    // start the colour order
    int colourOrder=0;
    Color nextColour;

    // clear the canvas
    //ctx.clearRect(0, 0, canvas.width, canvas.height);
    //canvas.clearRect(0, 0, canvas.width, canvas.height);


    List P0 = [flowerCentreX + borderX, flowerCentreY + borderY];

    double maxRadius = (width<height) ? currentFibonacci.flowerFill * width / 2 : currentFibonacci.flowerFill * height / 2;
    double minRadius = 2;
    double angle = 0;

    // if direction = inward
    if (currentFibonacci.direction) {

      double radius = maxRadius;
      do {

        // Choose the next colour
        colourOrder++;
        nextColour = currentFibonacci.palette[colourOrder%currentFibonacci.numberOfColours];
        if (currentFibonacci.randomColours) {
          nextColour = currentFibonacci.palette[rnd.nextInt(currentFibonacci.numberOfColours)];
        }

        print('P0: $P0');
        drawPetal(canvas, P0, angle, radius, nextColour);

        angle = angle + currentFibonacci.angleIncrement;
        if (angle > 2 * pi) {
          angle = angle - 2 * pi;
        }

        radius = radius * currentFibonacci.ratio;

        maxPetalCount = maxPetalCount - 1;
      }
      while (radius > minRadius && radius < maxRadius && maxPetalCount > 0);
    }
    else {

      double radius = minRadius;
      do {

        // Choose the next colour
        colourOrder++;
        nextColour = currentFibonacci.palette[colourOrder%currentFibonacci.numberOfColours];
        if (currentFibonacci.randomColours) {
          nextColour = currentFibonacci.palette[rnd.nextInt(currentFibonacci.numberOfColours)];
        }

        drawPetal(canvas, P0, angle, radius, nextColour);

        angle = angle + currentFibonacci.angleIncrement;
        if (angle > 2 * pi) {
          angle = angle - 2 * pi;
        }

        radius = radius / currentFibonacci.ratio;

        maxPetalCount = maxPetalCount - 1;
      }
      while (radius > minRadius && radius < maxRadius && maxPetalCount > 0);

    }



  }


  drawPetal(canvas, P0, angle, radius, colour) {

    angle = angle + (rnd.nextDouble() - 0.5) * currentFibonacci.randomiseAngle;

    radius = radius + radius * (sin(currentFibonacci.radialOscPeriod * angle)+1)*currentFibonacci.radialOscAmplitude;

    switch (currentFibonacci.petalType) {
      case 'circle': //"circle":


        List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
        var petalRadius = radius * currentFibonacci.petalToRadius;

        canvas.drawCircle(Offset(P1[0], P1[1]), petalRadius, Paint() ..style = PaintingStyle.fill ..color = colour);
        canvas.drawCircle(Offset(P1[0], P1[1]), petalRadius, Paint() ..style = PaintingStyle.stroke ..strokeWidth = currentFibonacci.lineWidth ..color = currentFibonacci.lineColour);

        break;


      case 'triangle': //"triangle":

        List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
        double petalRadius = radius * currentFibonacci.petalToRadius;

        List PA = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio)];
        List PB = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * currentFibonacci.petalPointiness), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * currentFibonacci.petalPointiness)];
        List PC = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio - pi * currentFibonacci.petalPointiness), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio - pi * currentFibonacci.petalPointiness)];

        Path triangle = Path();
        triangle.moveTo(PA[0], PA[1]);
        triangle.lineTo(PB[0], PB[1]);
        triangle.lineTo(PC[0], PC[1]);
        triangle.close();

        canvas.drawPath(
            triangle,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = currentFibonacci.lineWidth
              ..color = currentFibonacci.lineColour);
        canvas.drawPath(
            triangle,
            Paint()
              ..style = PaintingStyle.fill
              ..color = colour);

        break;

      case 'square': // "square":

        List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
        double petalRadius = radius * currentFibonacci.petalToRadius;

        List PA = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 0.0 + currentFibonacci.petalPointiness), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 0.0 + currentFibonacci.petalPointiness)];
        List PB = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 0.5 - currentFibonacci.petalPointiness), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 0.5 - currentFibonacci.petalPointiness)];
        List PC = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 1.0 + currentFibonacci.petalPointiness), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 1.0 + currentFibonacci.petalPointiness)];
        List PD = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 1.5 - currentFibonacci.petalPointiness), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 1.5 - currentFibonacci.petalPointiness)];

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
              ..strokeWidth = currentFibonacci.lineWidth
              ..color = currentFibonacci.lineColour);
        canvas.drawPath(
            square,
            Paint()
              ..style = PaintingStyle.fill
              ..color = colour);

        break;

      case 'petal': //"petal":

      List P1 = [P0[0] + radius * cos(angle), P0[1] + radius * sin(angle)];
      double petalRadius = radius * currentFibonacci.petalToRadius;

      List PA = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 0.0), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 0.0)];
      List PB = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 0.5), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 0.5)];
      List PC = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 1.0), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 1.0)];
      List PD = [P1[0] + petalRadius * cos(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 1.5), P1[1] + petalRadius * sin(angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * 1.5)];

      canvas.drawArc(
          Offset(PB[0]-petalRadius*2, PB[1]-petalRadius*2) & Size(petalRadius*4, petalRadius*4),
          angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * (0.5 + 2/3),
          pi * 2/3,
          false,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = currentFibonacci.lineWidth
            ..color = currentFibonacci.lineColour);

      canvas.drawArc(
          Offset(PB[0]-petalRadius*2, PB[1]-petalRadius*2) & Size(petalRadius*4, petalRadius*4),
          angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * (0.5 + 2/3),
          pi * 2/3,
          false,
          Paint()
            ..style = PaintingStyle.fill
            ..color = colour);

      canvas.drawArc(
          Offset(PD[0]-petalRadius*2, PD[1]-petalRadius*2) & Size(petalRadius*4, petalRadius*4),
          angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * (1.5 + 2/3),
          pi * 2/3,
          false,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = currentFibonacci.lineWidth
            ..color = currentFibonacci.lineColour);

      canvas.drawArc(
          Offset(PD[0]-petalRadius*2, PD[1]-petalRadius*2) & Size(petalRadius*4, petalRadius*4),
          angle + currentFibonacci.petalRotation + angle*currentFibonacci.petalRotationRatio + pi * (1.5 + 2/3),
          pi * 2/3,
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
