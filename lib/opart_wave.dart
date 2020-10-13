import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';

import 'package:screenshot/screenshot.dart';

//void main() {
//  runApp(OpArtWave());
//}

Random rnd;
List palette;
Color backgroundColor = Colors.grey;

double stepX = 10;
double stepY = 0.1;
double amplitude = 100;
double frequency = 1;
bool randomColours = false;
int numberOfColours = 12;
int paletteType = 2;
double opacity = 1;

void changeColor(int index, Color color) {
  palette.replaceRange(index, index + 1, [color]);
}

randomisePalette(int numberOfColours, int paletteType){
  print('numberOfColours: $numberOfColours paletteType: $paletteType');
  rnd = Random(DateTime.now().millisecond);


  List palette = [];
  switch(paletteType){

  // blended random
    case 1:{
      double blendColour = rnd.nextDouble() * 0xFFFFFF;
      for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++){
        palette.add(Color(((blendColour + rnd.nextDouble() * 0xFFFFFF)/2).toInt()).withOpacity(opacity));
      }
    }
    break;

  // linear random
    case 2:{
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
    case 3:{
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
  return palette;
}






class OpArtWaveStudio extends StatefulWidget {

  int seed;
  bool showSettings;
  ScreenshotController screenshotController;

  OpArtWaveStudio(this.seed, this.showSettings, {this.screenshotController});

  @override
  _OpArtWaveStudioState createState() => _OpArtWaveStudioState();
}

class _OpArtWaveStudioState extends State<OpArtWaveStudio> {
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

        Text('Step X - $stepX'),
        Slider(
          value: stepX,
          min: 1,
          max: 30,
          onChanged: (value) {
            setState(() {
              stepX = value;
            });
          },
          label: '$stepX',
        ),
        Text('Step Y- $stepY'),
        Slider(
          value: stepY,
          min: 0.01,
          max: 100,
          onChanged: (value) {
            setState(() {
              stepY = value;
            });
          },
          label: '$stepY',
        ),
        Text('Amplitude - $amplitude'),
        Slider(
          value: amplitude,
          min: 0,
          max: 100,
          onChanged: (value) {
            setState(() {
              amplitude = value;
            });
          },
          label: '$amplitude',
        ),
        Text('Frequency - $frequency'),
        Slider(
          value: frequency ,
          min: 0,
          max: 3,
          onChanged: (value) {
            setState(() {
              frequency  = value;
            });
          },
          label: '$frequency ',
        ),
        Text('Number of Colours - $numberOfColours'),
        Slider(
          value: numberOfColours.toDouble(),
          min: 2,
          max: 36,
          onChanged: (value) {
            setState(() {
              if (numberOfColours<value){
                palette = randomisePalette(value.toInt(), paletteType);

              }
              numberOfColours  = value.toInt();
            });
          },
          label: '$numberOfColours ',
        ),
        Text('Random Colours - $randomColours'),
        Switch(
          value: randomColours,
          onChanged: (value) {
            setState(() {
              randomColours  = value;
            });
          },
        ),
        Text('Palette Type - $paletteType'),
        DropdownButton(
          value: paletteType,
          items: [
            DropdownMenuItem(
              child: Text("Random"),
              value: 0,
            ),
            DropdownMenuItem(
              child: Text("Blended Random"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Linear Random"),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text("Linear Complementary"),
              value: 3,
            ),
          ],
          onChanged:(value) {
            setState(() {
              paletteType = value;
              palette = randomisePalette(numberOfColours, value);

            });
          },
        ),

        FloatingActionButton.extended(
          label: Text('Randomise Palette'),
          icon: Icon(Icons.donut_large),
          //backgroundColor: Colors.pink,

          onPressed:() {
            setState(() {

              print('FloatingActionButton Pressed');
              palette = randomisePalette(numberOfColours, paletteType);
              print('line 208  palette: $palette');

            });
          },
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
                child: CustomPaint(painter: OpArtWavePainter(widget.seed, rnd)),
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
                  child: CustomPaint(painter: OpArtWavePainter(widget.seed, rnd)),
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
}

class OpArtWavePainter extends CustomPainter {
  int seed;//
  Random rnd;

  OpArtWavePainter( this.seed, this.rnd);

  @override
  void paint(Canvas canvas, Size size) {
    // define the paint object


    rnd = Random(seed);
    print('seed: $seed');

    double canvasWidth = size.width;
    double canvasHeight = size.height;
    double borderX = 0;
    double borderY = 0;
    double imageWidth = canvasWidth;
    double imageHeight = canvasHeight;

    // aspectRation from 0.5 to 2 - or 33% of time fit to screen, 33% of time make it 1
    double aspectRatio = canvasWidth/canvasHeight;
    // if (rnd.nextBool()){
    //   aspectRatio = 1;
    // }

    if (canvasWidth / canvasHeight < aspectRatio) {
      borderY = (canvasHeight - canvasWidth / aspectRatio) / 2;
      imageHeight = imageWidth /aspectRatio;
    }
    else {
      borderX = (canvasWidth - canvasHeight * aspectRatio) / 2;
      imageWidth = imageHeight * aspectRatio;
    }

    print('width: ${canvasWidth}');
    print('height: ${canvasHeight}');
    print('canvasWidth / canvasHeight = ${canvasWidth / canvasHeight}');
    print('aspectRatio = $aspectRatio');
    print('borderX = $borderX');
    print('borderY = $borderY');
    print('imageWidth = $imageWidth');
    print('imageHeight = $imageHeight');

    // numberOfColours from 1 to 24
    // int numberOfColours = rnd.nextInt(24)+1;
    print('numberOfColours: $numberOfColours');

    // opacity - from 0 to 1 - 50% of time =1
    // double opacity = rnd.nextDouble();
    // if (rnd.nextInt(2)==0){
    //   opacity = 1;
    // }
    print('opacity: $opacity');

    // paletteType - 0=random; 1=blended random; 2=linear random; 3=linear complimentary;
    // int paletteType = rnd.nextInt(4);
    print('paletteType: $paletteType');

    // randomise the palette
    if (palette == null) {
      print('randomisePalette: $numberOfColours, $paletteType');
      palette = randomisePalette(numberOfColours, paletteType);
    }


    // // randomColours - true or false
    // bool randomColours = rnd.nextBool();
    // randomColours = false;
    // print('randomColours: $randomColours');

    int colourOrder = 0;
    Color backgroundColor = Colors.grey[200];


    // Now make some art

    // // stepX - from 1 to 30
    // double stepX = rnd.nextDouble()*29+1;
    // print('stepX: $stepX');
    //
    //
    // // stepY = from 10 to 100 - 50% of time = 0.1
    // double stepY = rnd.nextDouble()*90+10;
    // if (rnd.nextInt(2)==0){
    //   stepY = 0.1;
    // }
    //
    // // amplitude = from 0 to width/5
    // double amplitude = rnd.nextDouble()*imageWidth/5;
    // print('amplitude: $amplitude');
    //
    // // frequency = from 0 to 3
    // double frequency = rnd.nextDouble()*3;
    // print('frequency: $frequency');


    double offset = 1;
    double start = 0 - amplitude;
    double end = imageWidth + stepX + amplitude;

    for (double i = start; i < end; i+= stepX ) {

      Color waveColor;
      if (randomColours){
        waveColor = palette[rnd.nextInt(numberOfColours)];
      }
      else
      {
        colourOrder++;
        waveColor = palette[colourOrder%numberOfColours];
      }

      // var paint1 = Paint()
      //   ..color = waveColor
      //   ..style = PaintingStyle.fill;
      // canvas.drawRect(Offset(borderX + i, borderY) & Size(stepX, imageHeight), paint1);

      Path wave = Path();

      double j;
      for (j = 0; j < imageHeight + stepY; j+=stepY) {
        var delta = amplitude * sin(pi * 2 * (j / imageHeight * frequency + offset * i / imageWidth));
        if (j==0){
          wave.moveTo(borderX + i + delta, borderY + j);
        }
        else{
          wave.lineTo(borderX + i + delta, borderY + j);
        }
      }
      for (double k = j; k >= -stepY; k-=stepY) {
        var delta = amplitude * sin(pi * 2 * (k / imageHeight * frequency + offset * (i+stepX) / imageWidth));
        wave.lineTo(borderX + i + stepX + delta, borderY + k);
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
    canvas.drawRect(Offset(0, 0) & Size(borderX, canvasHeight+stepY), paint1);
    canvas.drawRect(Offset(canvasWidth-borderX, 0) & Size(borderX, canvasHeight+stepY), paint1);

    canvas.drawRect(Offset(0, 0) & Size(canvasWidth, borderY ), paint1);
    canvas.drawRect(Offset(0, canvasHeight-borderY, ) & Size(canvasWidth, borderY+2*stepY), paint1);




  }


  @override
  bool shouldRepaint(OpArtWavePainter oldDelegate) => false;
}
