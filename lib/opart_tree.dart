import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:shake/shake.dart';
import 'model.dart';
import 'palettes.dart';

Random rnd;

// Settings
Tree currentTree;

// Load the palettes
List palettes = defaultPalettes();
String currentNamedPalette;

List<Map<String, dynamic>> treeCachedList = List<Map<String, dynamic>>();

class Tree {
  // image settings

  SettingsModelDouble trunkWidth = SettingsModelDouble(
    label: 'Trunk Width',
    tooltip: 'The width of the base of the trunk',
    min: 0,
    max: 50,
    zoom: 100,
    defaultValue: 20,
    icon: Icon(Icons.track_changes),
    proFeature: false,
  );
  SettingsModelDouble zoomTree = SettingsModelDouble(
    label: 'Zoom',
    tooltip: 'Zoom in and out',
    min: 0.1,
    max: 2,
    zoom: 100,
    defaultValue: 1,
    icon: Icon(Icons.zoom_in),
    proFeature: false,
  );
  SettingsModelDouble widthDecay = SettingsModelDouble(
    label: 'Trunk Decay ',
    tooltip: 'The rate at which the trunk width decays',
    min: 0.7,
    max: 1,
    zoom: 100,
    defaultValue: 0.8,
    icon: Icon(Icons.zoom_in),
    proFeature: false,
  );
  SettingsModelDouble segmentLength = SettingsModelDouble(
    label: 'Segment Length',
    tooltip: 'The length of the first segment of the trunk',
    min: 10,
    max: 100,
    zoom: 100,
    defaultValue: 50,
    icon: Icon(Icons.swap_horizontal_circle),
    proFeature: false,
  );
  SettingsModelDouble segmentDecay = SettingsModelDouble(
    label: 'Segment Decay',
    tooltip: 'The rate at which the length of each successive segment decays',
    min: 0.9,
    max: 1,
    zoom: 100,
    defaultValue: 0.92,
    icon: Icon(Icons.format_color_fill),
    proFeature: false,
  );
  SettingsModelDouble branch = SettingsModelDouble(
    label: 'Branch Ratio',
    tooltip: 'The proportion of segments that branch',
    min: 0.4,
    max: 1,
    zoom: 100,
    defaultValue: 0.7,
    icon: Icon(Icons.ac_unit),
    proFeature: false,
  );
  SettingsModelDouble angle = SettingsModelDouble(
    label: 'Branch Angle',
    tooltip: 'The angle of the branch',
    min: 0.1,
    max: 0.7,
    zoom: 100,
    defaultValue: 0.5,
    icon: Icon(Icons.rotate_right),
    proFeature: false,
  );
  SettingsModelDouble ratio = SettingsModelDouble(
    label: 'Angle Ratio',
    tooltip: 'The ratio of the branch',
    min: 0,
    max: 1,
    zoom: 100,
    defaultValue: 0.5,
    icon: Icon(Icons.rotate_right),
    proFeature: false,
  );
  SettingsModelDouble bulbousness = SettingsModelDouble(
    label: 'Bulbousness',
    tooltip: 'The bulbousness of each segment',
    min: 0,
    max: 2,
    zoom: 100,
    defaultValue: 1.5,
    icon: Icon(Icons.autorenew),
    proFeature: false,
  );
  SettingsModelInt maxDepth = SettingsModelInt(
    label: 'Max Depth',
    tooltip: 'The number of segments',
    min: 10,
    max: 28,
    defaultValue: 20,
    icon: Icon(Icons.fiber_smart_record),
    proFeature: false,
  );
  SettingsModelInt leavesAfter = SettingsModelInt(
    label: 'Leaves After',
    tooltip: 'The number of segments before leaves start to sprout',
    min: 0,
    max: 28,
    defaultValue: 5,
    icon: Icon(Icons.fiber_smart_record),
    proFeature: false,
  );
  SettingsModelDouble leafAngle = SettingsModelDouble(
    label: 'Branch Angle',
    tooltip: 'The angle of the leaf',
    min: 0.2,
    max: 0.8,
    zoom: 100,
    defaultValue: 0.5,
    icon: Icon(Icons.rotate_right),
    proFeature: false,
  );
  SettingsModelDouble leafLength = SettingsModelDouble(
    label: 'Leaf Length',
    tooltip: 'The fixed length of each leaf',
    min: 0,
    max: 20,
    zoom: 100,
    defaultValue: 8,
    icon: Icon(Icons.rotate_right),
    proFeature: false,
  );
  SettingsModelDouble randomLeafLength = SettingsModelDouble(
    label: 'Random Length',
    tooltip: 'The random length of each leaf',
    min: 0,
    max: 20,
    zoom: 100,
    defaultValue: 3,
    icon: Icon(Icons.rotate_right),
    proFeature: false,
  );
  SettingsModelDouble leafSquareness = SettingsModelDouble(
    label: 'Squareness',
    tooltip: 'The squareness leaf',
    min: 0,
    max: 3,
    zoom: 100,
    defaultValue: 1,
    icon: Icon(Icons.rotate_right),
    proFeature: false,
  );
  SettingsModelDouble leafDecay = SettingsModelDouble(
    label: 'Leaf Decay',
    tooltip: 'The rate at which the leaves decay along the branch',
    min: 0.9,
    max: 1,
    zoom: 100,
    defaultValue: 0.95,
    icon: Icon(Icons.rotate_right),
    proFeature: false,
  );

  SettingsModelList petalType = SettingsModelList(
    label: "Petal Type",
    tooltip: "The shape of the petal",
    defaultValue: "circle",
    icon: Icon(Icons.local_florist),
    options: <String>['circle', 'triangle', 'square', 'petal'],
    proFeature: false,
  );

  SettingsModelList direction = SettingsModelList(
    label: "Direction",
    tooltip:
        "Start from the outside and draw Inward, or start from the centre and draw Outward",
    defaultValue: "inward",
    icon: Icon(Icons.directions),
    options: <String>['inward', 'outward'],
    proFeature: false,
  );

// palette settings
  SettingsModelColor backgroundColor = SettingsModelColor(
    label: "Background Color",
    tooltip: "The background colour for the canvas",
    defaultValue: Colors.cyan[200],
    icon: Icon(Icons.settings_overscan),
    proFeature: false,
  );
  SettingsModelColor trunkFillColor = SettingsModelColor(
    label: "Trunk Color",
    tooltip: "The fill colour of the trunk",
    defaultValue: Colors.grey,
    icon: Icon(Icons.settings_overscan),
    proFeature: false,
  );
  SettingsModelColor trunkOutlineColor = SettingsModelColor(
    label: "Trunk Outline",
    tooltip: "The outline colour of the trunk",
    defaultValue: Colors.black,
    icon: Icon(Icons.settings_overscan),
    proFeature: false,
  );
  SettingsModelDouble trunkStrokeWidth = SettingsModelDouble(
    label: 'Outline Width',
    tooltip: 'The width of the trunk outline',
    min: 0,
    max: 1,
    zoom: 100,
    defaultValue: 0.1,
    icon: Icon(Icons.line_weight),
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
    options: <String>[
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

  //Random random;

  Tree({
    // palette settings
    this.palette,
    this.aspectRatio = pi / 2,
    this.image,
    this.paletteLOCK = false,
    this.aspectRatioLOCK = false,
    //this.random,
  });

  void defaultSettings() {
    // resets to default settings
    this.zoomTree.value = this.zoomTree.defaultValue;
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
    this.resetDefaults.value = this.resetDefaults.defaultValue;

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

void treeRandomizePalette() {
  print('-----------------------------------------------------');
  print('randomizePalette');
  print('-----------------------------------------------------');

  rnd = Random(DateTime.now().millisecond);

  currentTree.backgroundColor.randomize(rnd);
  currentTree.trunkFillColor.randomize(rnd);
  currentTree.trunkOutlineColor.randomize(rnd);
  currentTree.randomColors.randomize(rnd);
  currentTree.numberOfColors.randomize(rnd);
  currentTree.paletteType.randomize(rnd);
  currentTree.opacity.randomize(rnd);

  currentTree.palette = randomizedPalette(
      currentTree.paletteType.value, currentTree.numberOfColors.value, rnd);
}

void treeRandomize() {
  print('-----------------------------------------------------');
  print('randomize');
  print('-----------------------------------------------------');

  rnd = Random(DateTime.now().millisecond);

  currentTree.trunkWidth.randomize(rnd);
  currentTree.zoomTree.value = 1;
  currentTree.widthDecay.randomize(rnd);
  currentTree.segmentLength.randomize(rnd);
  currentTree.segmentDecay.randomize(rnd);
  currentTree.branch.randomize(rnd);
  currentTree.angle.randomize(rnd);
  currentTree.ratio.randomize(rnd);
  currentTree.bulbousness.randomize(rnd);
  currentTree.maxDepth.randomize(rnd);
  currentTree.leavesAfter.randomize(rnd);
  currentTree.leafAngle.randomize(rnd);
  currentTree.leafLength.randomize(rnd);
  currentTree.randomLeafLength.randomize(rnd);
  currentTree.leafSquareness.randomize(rnd);
  currentTree.leafDecay.randomize(rnd);
  currentTree.trunkStrokeWidth.randomize(rnd);

  //  this.paletteList.randomize(rnd);
}

List<dynamic> treeSettingsList = [
  currentTree.zoomTree,
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
  currentTree.resetDefaults,
];
treeAddToCache() async {
  WidgetsBinding.instance.addPostFrameCallback((_) => screenshotController
          .capture(delay: Duration(milliseconds: 100), pixelRatio: 0.2)
          .then((File image) async {
        currentTree.image = image;
        Map<String, dynamic> currentCache = {
          'aspectRatio': currentTree.aspectRatio,
          'trunkWidth': currentTree.trunkWidth.value,
          'zoomTree': currentTree.zoomTree.value,
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
          'palette': currentTree.palette,
          'opacity': currentTree.opacity.value,
          'image': currentTree.image,
        };
        treeCachedList.add(currentCache);
        rebuildCache.value++;
        await new Future.delayed(const Duration(milliseconds: 20));
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
        enableButton = true;
      }));
}


treeRevertToCache(index) {
  currentTree.trunkWidth.value = treeCachedList[index]['trunkWidth'];
  currentTree.zoomTree.value = treeCachedList[index]['zoomTree'];
  currentTree.widthDecay.value = treeCachedList[index]['widthDecay'];
  currentTree.segmentLength.value = treeCachedList[index]['segmentLength'];
  currentTree.segmentDecay.value = treeCachedList[index]['segmentDecay'];
  currentTree.branch.value = treeCachedList[index]['branch'];
  currentTree.angle.value = treeCachedList[index]['angle'];
  currentTree.ratio.value = treeCachedList[index]['ratio'];
  currentTree.bulbousness.value = treeCachedList[index]['bulbousness'];
  currentTree.image = treeCachedList[index]['image'];
  currentTree.maxDepth.value = treeCachedList[index]['maxDepth'];
  currentTree.leavesAfter.value = treeCachedList[index]['leavesAfter'];
  currentTree.leafAngle.value = treeCachedList[index]['leafAngle'];
  currentTree.leafLength.value = treeCachedList[index]['leafLength'];
  currentTree.randomLeafLength.value =
      treeCachedList[index]['randomLeafLength'];
  currentTree.leafSquareness.value = treeCachedList[index]['leafSquareness'];
  currentTree.leafDecay.value = treeCachedList[index]['leafDecay'];
  currentTree.backgroundColor.value = treeCachedList[index]['backgroundColor'];
  currentTree.trunkFillColor.value = treeCachedList[index]['trunkFillColor'];
  currentTree.trunkOutlineColor.value =
      treeCachedList[index]['trunkOutlineColor'];
  currentTree.randomColors.value = treeCachedList[index]['randomColors'];
  currentTree.numberOfColors.value = treeCachedList[index]['numberOfColors'];
  currentTree.paletteType.value = treeCachedList[index]['paletteType'];
  currentTree.palette = treeCachedList[index]['palette'];
  currentTree.opacity.value = treeCachedList[index]['opacity'];
}

Widget treeBodyWidget(Animation animation1) {
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
                    painter: OpArtTreePainter(
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


class OpArtTreePainter extends CustomPainter {
  int seed;
  Random rnd;
  double animationVariable;
  // double fill;

  OpArtTreePainter(
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
    print('Tree');
    print('----------------------------------------------------------------');

    // Initialise the palette
    if (currentTree == null) {
      currentTree = new Tree();
      //currentTree = new Tree(random: rnd);
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
      treeRandomizePalette();
    }

    // reset the defaults
    if (currentTree.resetDefaults.value == true) {
      currentTree.defaultSettings();
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

    double zoom = currentTree.zoomTree.value;
    print('zoom: $zoom');

    String leafStyle = 'quadratic';

    List treeBaseA = [
      (canvasWidth - currentTree.trunkWidth.value * zoom) / 2,
      canvasHeight
    ];
    List treeBaseB = [
      (canvasWidth + currentTree.trunkWidth.value * zoom) / 2,
      canvasHeight
    ];

    drawSegment(
      canvas,
      borderX,
      borderY,
      treeBaseA,
      treeBaseB,
      currentTree.trunkWidth.value * zoom,
      currentTree.segmentLength.value * zoom,
      direction,
      currentTree.ratio.value,
      0,
      lineWidth * zoom,
      currentTree.leafLength.value * zoom,
      leafStyle,
      false,
      animationVariable * 2500,
    );
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
    double ratio,
    int currentDepth,
    double lineWidth,
    double leafLength,
    String leafStyle,
    bool justBranched,
    double animationVariable,
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

      // the ratio is the skewness of the branch.
      // if ratio = 0, both branches go off at the same angle
      // if ratio = 1, one branch goes straight on, the other goes off at the angle
      // the ratio is partially randomized to make things interesting

      // the angle of the branch is the angle from the previous direction.
      // if angle = 0 the tree goes straight up
      // if angle = 1 the tree is basically a ball

      // the animation increases and decreases the ratio

      double branchRatio =
          ratio * (1 - rnd.nextDouble() * cos(animationVariable) * 0.10);

      // if (rnd.nextDouble() > 0.5) {
      directionA = direction + branchRatio * currentTree.angle.value;
      directionB = direction - (1 - branchRatio) * currentTree.angle.value;
      // } else {
      //   directionA =
      //       direction - branchRatio * currentTree.angle.value;
      //   directionB =
      //       direction + (1 - branchRatio) * currentTree.angle.value;
      // }

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
            ratio,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true,
            animationVariable);
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootX,
            rootB,
            width * currentTree.widthDecay.value,
            segmentLength * currentTree.segmentDecay.value,
            directionB,
            ratio,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true,
            animationVariable);
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
            ratio,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true,
            animationVariable);
        drawSegment(
            canvas,
            borderX,
            borderY,
            rootA,
            rootX,
            width * currentTree.widthDecay.value,
            segmentLength * currentTree.segmentDecay.value,
            directionA,
            ratio,
            currentDepth + 1,
            lineWidth,
            leafLength,
            leafStyle,
            true,
            animationVariable);
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
        drawTheLeaf(
            canvas,
            borderX,
            borderY,
            P2,
            lineWidth,
            direction - currentTree.leafAngle.value,
            leafLength,
            leafStyle,
            ratio,
            animationVariable);
        drawTheLeaf(
            canvas,
            borderX,
            borderY,
            P3,
            lineWidth,
            direction + currentTree.leafAngle.value,
            leafLength,
            leafStyle,
            ratio,
            animationVariable);
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
            ratio,
            currentDepth + 1,
            lineWidth,
            leafLength * currentTree.leafDecay.value,
            leafStyle,
            false,
            animationVariable);
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
    double ratio,
    double animationVariable,
  ) {
    double leafAssymetery = 0.75;

    // pick a random color
    print('drawTheLeaf: opacity: ${currentTree.opacity.value}');
    Color leafColor = currentTree
        .palette[rnd.nextInt(currentTree.palette.length)]
        .withOpacity(currentTree.opacity.value);

    var leafRadius =
        leafLength + rnd.nextDouble() * currentTree.randomLeafLength.value;

    double randomizedLeafAngle =
        leafAngle + (1 - rnd.nextDouble() / 2) * cos(animationVariable);

    // find the centre of the leaf
    List PC = [
      leafPosition[0] + leafRadius * cos(randomizedLeafAngle),
      leafPosition[1] - leafRadius * sin(randomizedLeafAngle)
    ];

//    List PN = [PC[0] - leafRadius * cos(leafAngle), PC[1] + leafRadius * sin(leafAngle)];

    // find the tip of the leaf
    List PS = [
      PC[0] - leafRadius * cos(randomizedLeafAngle + pi),
      PC[1] + leafRadius * sin(randomizedLeafAngle + pi)
    ];

    // find the offset centre of the leaf
    List POC = [
      PC[0] + leafAssymetery * leafRadius * cos(randomizedLeafAngle + pi),
      PC[1] - leafAssymetery * leafRadius * sin(randomizedLeafAngle + pi)
    ];

    List PE = [
      POC[0] -
          currentTree.leafSquareness.value *
              leafRadius *
              cos(randomizedLeafAngle + pi * 0.5),
      POC[1] +
          currentTree.leafSquareness.value *
              leafRadius *
              sin(randomizedLeafAngle + pi * 0.5)
    ];
    List PW = [
      POC[0] -
          currentTree.leafSquareness.value *
              leafRadius *
              cos(randomizedLeafAngle + pi * 1.5),
      POC[1] +
          currentTree.leafSquareness.value *
              leafRadius *
              sin(randomizedLeafAngle + pi * 1.5)
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
