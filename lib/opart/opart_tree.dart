import 'package:flutter/material.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';
import '../main.dart';


List<String> list = List();

SettingsModel reDraw = SettingsModel(
  name: 'reDraw',
  settingType: SettingType.button,
  label: 'Redraw',
  tooltip: 'Re-draw the picture with a different random seed',
  defaultValue: false,
  icon: Icon(Icons.refresh),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  onChange: (){seed = DateTime.now().millisecond;},
  silent: true,
);

SettingsModel zoomOpArt = SettingsModel(
    name: 'zoomOpArt',
    settingType: SettingType.double,
    label: 'Zoom',
    tooltip: 'Zoom in and out',
    min: 0.2,
    max: 2.0,
    zoom: 100,
    defaultValue: 1.0,
    icon: Icon(Icons.zoom_in),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

  SettingsModel centerX = SettingsModel(
    name: 'centerX',
    settingType: SettingType.double,
    label: 'Horizontal offset',
    tooltip: 'The offset from the bottom of the sceen',
    min: -200.0,
    max: 200.0,
    randomMax: 0.0,
    randomMin: 0.0,
    zoom: 100,
    defaultValue: 0.0,
    icon: Icon(Icons.swap_horiz),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel centerY = SettingsModel(
  name: 'centerY',
  settingType: SettingType.double,
  label: 'Vertical Offset',
  tooltip: 'The horizontal offset from the center of the sceen',
  min: -200.0,
  max: 300.0,
  randomMax: -120.0,
  randomMin: -120.0,
  zoom: 100,
  defaultValue: -120.0,
  icon: Icon(Icons.swap_vert),
  settingCategory: SettingCategory.tool,
  proFeature: false,
);


SettingsModel trunkWidth = SettingsModel(
    name: 'trunkWidth',
    settingType: SettingType.double,
    label: 'Trunk Width',
    tooltip: 'The width of the base of the trunk',
    min: 0.0,
    max: 50.0,
    zoom: 100,
    defaultValue: 18.0,
    icon: Icon(Icons.track_changes),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
  SettingsModel widthDecay = SettingsModel(
    name: 'widthDecay',
    settingType: SettingType.double,
    label: 'Trunk Decay',
    tooltip: 'The rate at which the trunk width decays',
    min: 0.7,
    max: 1.0,
    randomMin: 0.7,
    randomMax: 0.9,
    zoom: 100,
    defaultValue: 0.8,
    icon: Icon(Icons.swap_horiz),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
  SettingsModel segmentLength = SettingsModel(
    name: 'segmentLength',
    settingType: SettingType.double,
    label: 'Segment Length',
    tooltip: 'The length of the first segment of the trunk',
    min: 10.0,
    max: 100.0,
    randomMin: 20.0,
    randomMax: 70.0,
    zoom: 100,
    defaultValue: 47.0,
    icon: Icon(Icons.swap_horizontal_circle),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

  SettingsModel segmentDecay = SettingsModel(
    name: 'segmentDecay',
    settingType: SettingType.double,
    label: 'Segment Decay',
    tooltip: 'The rate at which the length of each successive segment decays',
    min: 0.1,
    max: 1.0,
    randomMin: 0.8,
    randomMax: 0.95,
    zoom: 100,
    defaultValue: 0.92,
    icon: Icon(Icons.swap_vert),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

  SettingsModel branch = SettingsModel(
    name: 'branch',
    settingType: SettingType.double,
    label: 'Branch Ratio',
    tooltip: 'The proportion of segments that branch',
    min: 0.0,
    max: 1.0,
    randomMin: 0.4,
    randomMax: 0.8,
    zoom: 100,
    defaultValue: 0.7,
    icon: Icon(Icons.ac_unit),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel angle = SettingsModel(
    name: 'angle',
    settingType: SettingType.double,
    label: 'Branch Angle',
    tooltip: 'The angle of the branch',
    min: 0.1,
    max: 0.7,
    zoom: 100,
    defaultValue: 0.3,
    icon: Icon(Icons.rotate_right),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel ratio = SettingsModel(
    name: 'ratio',
    settingType: SettingType.double,
    label: 'Angle Ratio',
    tooltip: 'The ratio of the branch',
    min: 0.0,
    max: 1.0,
    zoom: 100,
    defaultValue: 0.5,
    icon: Icon(Icons.blur_circular),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel bulbousness = SettingsModel(
    name: 'bulbousness',
    settingType: SettingType.double,
    label: 'Bulbousness',
    tooltip: 'The bulbousness of each segment',
    min: 0.0,
    max: 5.0,
    randomMin: 0.0,
    randomMax: 3.0,
    zoom: 100,
    defaultValue: 1.5,
    icon: Icon(Icons.autorenew),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel maxDepth = SettingsModel(
    name: 'maxDepth',
    settingType: SettingType.int,
    label: 'Max Depth',
    tooltip: 'The number of segments',
    min: 5,
    max: 28,
    randomMin: 10,
    randomMax: 25,
    defaultValue: 18,
    icon: Icon(Icons.fiber_smart_record),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel leavesAfter = SettingsModel(
    name: 'leavesAfter',
    settingType: SettingType.int,
    label: 'Leaves After',
    tooltip: 'The number of segments before leaves start to sprout',
    min: 0,
    max: 28,
    defaultValue: 5,
    icon: Icon(Icons.blur_circular),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel leafAngle = SettingsModel(
    name: 'leafAngle',
    settingType: SettingType.double,
    label: 'Leaf Angle',
    tooltip: 'The angle of the leaf',
    min: 0.2,
    max: 0.8,
    zoom: 100,
    defaultValue: 0.5,
    icon: Icon(Icons.rotate_right),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel leafRadius = SettingsModel(
    name: 'leafRadius',
    settingType: SettingType.double,
    label: 'Leaf Size',
    tooltip: 'The fixed length of each leaf',
    min: 0.0,
    max: 20.0,
    zoom: 100,
    defaultValue: 12.0,
    icon: Icon(Icons.rotate_right),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel randomLeafLength = SettingsModel(
    name: 'randomLeafLength',
    settingType: SettingType.double,
    label: 'Random Length',
    tooltip: 'The random length of each leaf',
    min: 0.0,
    max: 20.0,
    zoom: 100,
    defaultValue: 3.0,
    icon: Icon(Icons.rotate_right),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel leafSquareness = SettingsModel(
    name: 'leafSquareness',
    settingType: SettingType.double,
    label: 'Squareness',
    tooltip: 'The squareness leaf',
    min: 0.0,
    max: 3.0,
    zoom: 100,
    defaultValue: 1.0,
    icon: Icon(Icons.child_care),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel leafAsymmetry = SettingsModel(
    name: 'leafAsymmetry',
    settingType: SettingType.double,
    label: 'Asymmetry',
    tooltip: 'The assymetry of the leaf',
    min: -3.0,
    max: 3.0,
    zoom: 100,
    defaultValue: 0.7,
    icon: Icon(Icons.clear_all),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel leafDecay = SettingsModel(
    name: 'leafDecay',
    settingType: SettingType.double,
    label: 'Leaf Decay',
    tooltip: 'The rate at which the leaves decay along the branch',
    min: 0.9,
    max: 1.0,
    zoom: 100,
    defaultValue: 0.95,
    icon: Icon(Icons.graphic_eq),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );
SettingsModel leafShape = SettingsModel(
    name: 'leafShape',
    settingType: SettingType.list,
    label: "Leaf Type",
    tooltip: "The shape of the leaf",
    defaultValue: "petal",
    icon: Icon(Icons.local_florist),
    options: <String>['petal', 'circle', 'triangle', 'square', 'diamond'],
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel trunkFillColor = SettingsModel(settingType: SettingType.color,
    name: 'trunkFillColor',
    label: "Trunk Color",
    tooltip: "The fill colour of the trunk",
    defaultValue: Colors.grey,
    icon: Icon(Icons.settings_overscan),
    settingCategory: SettingCategory.palette,
    proFeature: false,
  );
SettingsModel trunkOutlineColor = SettingsModel(settingType: SettingType.color,
    name: 'trunkOutlineColor',
    label: "Trunk Outline Color",
    tooltip: "The outline colour of the trunk",
    defaultValue: Colors.grey,
    icon: Icon(Icons.settings_overscan),
    settingCategory: SettingCategory.palette,
    proFeature: false,
  );
SettingsModel trunkStrokeWidth = SettingsModel(
    name: 'trunkStrokeWidth',
    settingType: SettingType.double,
    label: 'Outline Width',
    tooltip: 'The width of the trunk outline',
    min: 0.0,
    max: 1.0,
    zoom: 100,
    defaultValue: 0.0,
    icon: Icon(Icons.line_weight),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

SettingsModel paletteType = SettingsModel(
    name: 'paletteType',
    settingType: SettingType.list,
    label: "Palette Type",
    tooltip: "The nature of the palette",
    defaultValue: "random",
    icon: Icon(Icons.colorize),
    options: <String>[
    'random',
    'blended random',
    'linear random',
    'linear complementary'
    ],
    settingCategory: SettingCategory.palette,
    onChange: (){generatePalette();},
    proFeature: false,
  );
SettingsModel paletteList = SettingsModel(
    name: 'paletteList',
    settingType: SettingType.list,
    label: "Palette",
    tooltip: "Choose from a list of palettes",
    defaultValue: "Default",
    icon: Icon(Icons.palette),
    options: defaultPalleteNames(),
    settingCategory: SettingCategory.palette,
    proFeature: false,
  );
SettingsModel opacity = SettingsModel(
    name: 'opacity',
    settingType: SettingType.double,
    label: 'Opactity',
    tooltip: 'The opacity of the petal',
    min: 0.2,
    max: 1.0,
    zoom: 100,
    defaultValue: 1.0,
    icon: Icon(Icons.remove_red_eye),
    settingCategory: SettingCategory.palette,
    proFeature: false,
  );
SettingsModel resetDefaults = SettingsModel(
  name: 'resetDefaults',
  settingType: SettingType.button,
  label: 'Reset Defaults',
  tooltip: 'Reset all settings to defaults',
  defaultValue: false,
  icon: Icon(Icons.low_priority),
  settingCategory: SettingCategory.tool,
  proFeature: false,
  onChange: (){resetAllDefaults();},
  silent: true,
);


List<SettingsModel> initializeTreeAttributes() {
  return [
    reDraw,
    zoomOpArt,
    centerX,
    centerY,
    trunkWidth,
    widthDecay,
    segmentLength,
    segmentDecay,
    branch,
    angle,
    ratio,
    bulbousness,
    maxDepth,
    leafShape,
    leafRadius,
    leafDecay,
    leavesAfter,
    leafAngle,
    randomLeafLength,
    leafSquareness,
    leafAsymmetry,
    backgroundColor,
    numberOfColors,
    trunkFillColor,
    trunkOutlineColor,
    trunkStrokeWidth,
    paletteType,
    paletteList,
    opacity,
    resetDefaults,
  ];
}

void paintTree(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  // reseed the random number generator
  rnd = Random(seed);

  // sort out the image size
  double borderX = 0;
  double borderY = 0;
  double imageWidth = size.width;
  double imageHeight = size.height;

  // if (size.width / size.height < aspectRatio) {
  //   borderY = (size.height - size.width / aspectRatio) / 2;
  //   imageHeight = imageWidth / aspectRatio;
  // } else {
  //   borderX = (size.width - size.height * aspectRatio) / 2;
  //   imageWidth = imageHeight * aspectRatio;
  // }




  // colour in the canvas
  canvas.drawRect(
      Offset(borderX, borderY) & Size(imageWidth, imageHeight),
      Paint()
        ..color = backgroundColor.value
        ..style = PaintingStyle.fill);

  // Starting point of the tree
  double direction = pi / 2;
  List treeBaseA = [
    borderX + (imageWidth - trunkWidth.value * zoomOpArt.value) / 2 + centerX.value,
    borderY + imageHeight + centerY.value
  ];
  List treeBaseB = [
    borderX + (imageWidth + trunkWidth.value * zoomOpArt.value) / 2 + centerX.value,
    borderY + imageHeight + centerY.value
  ];

  drawSegment(
    canvas,
    rnd,
    treeBaseA,
    treeBaseB,
    trunkWidth.value * zoomOpArt.value,
    segmentLength.value * zoomOpArt.value,
    direction,
    ratio.value,
    0,
    trunkStrokeWidth.value * zoomOpArt.value,
    leafRadius.value * zoomOpArt.value,
    randomLeafLength.value,
    leafShape.value,
    false,
    animationVariable,
    branch.value,
    angle.value,
    widthDecay.value,
    segmentDecay.value,
    bulbousness.value,
    leavesAfter.value,
    maxDepth.value,
    leafAngle.value,
    leafDecay.value,
    leafSquareness.value,
    leafAsymmetry.value,
    trunkFillColor.value,
    opacity.value,
    numberOfColors.value.toInt(),
    trunkStrokeWidth.value,
    trunkOutlineColor.value,
    opArt.palette.colorList,
  );

  //
  // // colour in the borders
  // if (borderX>0){
  //   canvas.drawRect(
  //       Offset(0, 0) & Size(borderX, size.height),
  //       Paint()
  //         ..color = Colors.black
  //         ..style = PaintingStyle.fill);
  //   canvas.drawRect(
  //       Offset(size.width-borderX , 0) & Size(size.width, size.height),
  //       Paint()
  //         ..color = Colors.black
  //         ..style = PaintingStyle.fill);
  // }
  // if (borderY>0){
  //   canvas.drawRect(
  //       Offset(0, 0) & Size(size.width, borderY),
  //       Paint()
  //         ..color = Colors.black
  //         ..style = PaintingStyle.fill);
  //   canvas.drawRect(
  //       Offset(0, size.height-borderY) & Size(size.width, size.height),
  //       Paint()
  //         ..color = Colors.black
  //         ..style = PaintingStyle.fill);
  // }


}

drawSegment(
    Canvas canvas,
    Random rnd,
    List rootA,
    List rootB,
    double width,
    double segmentLength,
    double direction,
    double ratio,
    int currentDepth,
    double lineWidth,
    double leafRadius,
    double randomLeafLength,
    String leafShape,
    bool justBranched,
    double animationVariable,
    double branch,
    double angle,
    double widthDecay,
    double segmentDecay,
    double bulbousness,
    int leavesAfter,
    int maxDepth,
    double leafAngle,
    double leafDecay,
    double leafSquareness,
    double leafAsymmetry,
    Color trunkFillColor,
    double opacity,
    numberOfColors,
    double trunkStrokeWidth,
    Color trunkOutlineColor,
    List palette,
    )
{
  List segmentBaseCentre = [
    (rootA[0] + rootB[0]) / 2,
    (rootA[1] + rootB[1]) / 2
  ];

  //branch
  if (!justBranched && rnd.nextDouble() < branch) {
    List rootX = [
      segmentBaseCentre[0] + width * cos(direction),
      segmentBaseCentre[1] - width * sin(direction)
    ];

    // draw the triangle
    drawTheTriangle(canvas, rnd, rootA, rootB, rootX,
      trunkFillColor, opacity,trunkStrokeWidth, trunkOutlineColor,
    );


    // the ratio is the skewness of the branch.
    // if ratio = 0, both branches go off at the same angle
    // if ratio = 1, one branch goes straight on, the other goes off at the angle
    // the ratio is partially randomized to make things interesting

    // the angle of the branch is the angle from the previous direction.
    // if angle = 0 the tree goes straight up
    // if angle = 1 the tree is basically a ball

    // the animation increases and decreases the ratio
    double branchRatio = (1 - rnd.nextDouble()/5) * ratio * (1 - rnd.nextDouble() * cos(animationVariable*10000) * 0.50);

    // maxBranch is the max branching angle
    double maxBranch = pi/8;

    // direction A is off to the left
    double directionA;

    // direction B is off to the left
    double directionB;
    if (rnd.nextBool()){
      directionA = direction - maxBranch * (angle + 2*angle*branchRatio);
      directionB = direction + maxBranch * (angle + 2*angle*(1-branchRatio));
    }
    else {
      directionA = direction - maxBranch * (angle + 2*angle*(1-branchRatio));
      directionB = direction + maxBranch * (angle + 2*angle*branchRatio);
    }

    drawSegment( canvas, rnd, rootA, rootX, width * widthDecay, segmentLength * segmentDecay, directionB, ratio, currentDepth + 1, lineWidth, leafRadius, randomLeafLength, leafShape, true, animationVariable, branch, angle, widthDecay, segmentDecay, bulbousness, leavesAfter, maxDepth, leafAngle, leafDecay, leafSquareness, leafAsymmetry, trunkFillColor, opacity, numberOfColors, trunkStrokeWidth, trunkOutlineColor, palette, );
    drawSegment( canvas, rnd, rootX, rootB, width * widthDecay, segmentLength * segmentDecay, directionA, ratio, currentDepth + 1, lineWidth, leafRadius, randomLeafLength, leafShape, true, animationVariable, branch, angle, widthDecay, segmentDecay, bulbousness, leavesAfter, maxDepth, leafAngle, leafDecay, leafSquareness, leafAsymmetry, trunkFillColor, opacity, numberOfColors, trunkStrokeWidth, trunkOutlineColor, palette, );


  } else {
    //grow
    List pD = [
      segmentBaseCentre[0] + segmentLength * cos(direction),
      segmentBaseCentre[1] - segmentLength * sin(direction)
    ];
    List p2 = [
      pD[0] + 0.5 * width * widthDecay * sin(direction),
      pD[1] + 0.5 * width * widthDecay * cos(direction)
    ];
    List p3 = [
      pD[0] - 0.5 * width * widthDecay * sin(direction),
      pD[1] - 0.5 * width * widthDecay * cos(direction)
    ];

    // draw the trunk
    drawTheTrunk(canvas, rnd, rootB, p2, p3, rootA,
        bulbousness, trunkFillColor, opacity, trunkStrokeWidth, trunkOutlineColor);

    // Draw the leaves
    if (currentDepth > leavesAfter) {
      drawTheLeaf(
        canvas,
        rnd,
        p2,
        lineWidth,
        direction - leafAngle,
        leafRadius,
        leafShape,
        ratio,
        randomLeafLength,
        leafSquareness,
        leafAsymmetry,
        animationVariable,
        opacity,
        numberOfColors,
        palette,
      );
      drawTheLeaf(
        canvas,
        rnd,
        p3,
        lineWidth,
        direction + leafAngle,
        leafRadius,
        leafShape,
        ratio,
        randomLeafLength,
        leafSquareness,
        leafAsymmetry,
        animationVariable,
        opacity,
        numberOfColors,
        palette,
      );
    }

    // next
    if (currentDepth < maxDepth) {
      drawSegment(
        canvas,
        rnd,
        p3,
        p2,
        width * widthDecay,
        segmentLength * segmentDecay,
        direction,
        ratio,
        currentDepth + 1,
        lineWidth,
        leafRadius * leafDecay,
        randomLeafLength,
        leafShape,
        false,
        animationVariable,
        branch,
        angle,
        widthDecay,
        segmentDecay,
        bulbousness,
        leavesAfter,
        maxDepth,
        leafAngle,
        leafDecay,
        leafSquareness,
        leafAsymmetry,
        trunkFillColor,
        opacity,
        numberOfColors,
        trunkStrokeWidth,
        trunkOutlineColor,
        palette,
      );
    }
  }
}


drawTheTrunk(
    Canvas canvas,
    Random rnd,
    List p1,
    List p2,
    List p3,
    List p4,
    double bulbousness,
    Color trunkFillColor,
    double opacity,
    double trunkStrokeWidth,
    Color trunkOutlineColor,
    ) {
  List pC = [
    (p1[0] + p2[0] + p3[0] + p4[0]) / 4,
    (p1[1] + p2[1] + p3[1] + p4[1]) / 4
  ];
  List p12 = [(p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2];
  List pX = [
    pC[0] * (1 - bulbousness) + p12[0] * bulbousness,
    pC[1] * (1 - bulbousness) + p12[1] * bulbousness
  ];
  List p34 = [(p3[0] + p4[0]) / 2, (p3[1] + p4[1]) / 2];
  List pY = [
    pC[0] * (1 - bulbousness) + p34[0] * bulbousness,
    pC[1] * (1 - bulbousness) + p34[1] * bulbousness
  ];

  Path trunk = Path();
  trunk.moveTo(p1[0], p1[1]);
  trunk.quadraticBezierTo(
      pX[0], pX[1], p2[0], p2[1]);
  trunk.lineTo(p3[0], p3[1]);
  trunk.quadraticBezierTo(
      pY[0], pY[1], p4[0], p4[1]);
  trunk.close();

  canvas.drawPath(
      trunk,
      Paint()
        ..style = PaintingStyle.fill
        ..color = trunkFillColor
            .withOpacity(opacity));

  canvas.drawPath(
      trunk,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = trunkStrokeWidth
        ..color = trunkOutlineColor
            .withOpacity(opacity));
}

drawTheTriangle(
    Canvas canvas,
    Random rnd,
    List p1,
    List p2,
    List p3,
    Color trunkFillColor,
    double opacity,
    double trunkStrokeWidth,
    Color trunkOutlineColor,
    ) {
  Path trunk = Path();
  trunk.moveTo(p1[0], p1[1]);
  trunk.lineTo(p2[0], p2[1]);
  trunk.lineTo(p3[0], p3[1]);
  trunk.close();

  canvas.drawPath(
      trunk,
      Paint()
        ..style = PaintingStyle.fill
        ..color = trunkFillColor
            .withOpacity(opacity));

  canvas.drawPath(
      trunk,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = trunkStrokeWidth
        ..color = trunkOutlineColor
            .withOpacity(opacity));
}

drawTheLeaf(
    Canvas canvas,
    Random rnd,
    List leafPosition,
    double lineWidth,
    double leafAngle,
    double leafRadius,
    String leafShape,
    double ratio,
    double randomLeafLength,
    double leafSquareness,
    double leafAsymmetry,
    double animationVariable,
    double opacity,
    int numberOfColors,
    List palette,
    ) {


  // pick a random color
  Color leafColor = palette[rnd.nextInt(numberOfColors)].withOpacity(opacity);

  leafRadius = leafRadius + rnd.nextDouble() * randomLeafLength;

  // have each leaf oscillate on a different cycle

  double randomizedLeafAngle = leafAngle +  cos(rnd.nextDouble()*pi*2 + animationVariable*((1-rnd.nextDouble()*0.5) * 20000));

  // find the centre of the leaf
  List pC = [
    leafPosition[0] + leafRadius * cos(randomizedLeafAngle),
    leafPosition[1] - leafRadius * sin(randomizedLeafAngle)
  ];

  switch (leafShape) {

    case "petal":


      leafRadius = leafRadius * 2;

      canvas.drawArc(Rect.fromCenter(
          center: Offset(leafPosition[0]+cos(randomizedLeafAngle-pi/4)*leafRadius/sqrt(2),
              leafPosition[1]-sin(randomizedLeafAngle-pi/4)*leafRadius/sqrt(2)),
          height: leafRadius*sqrt(2),
          width: leafRadius*sqrt(2)),
          pi*1.25-randomizedLeafAngle, pi / 2, false, Paint()
            ..strokeWidth = 0.0
            ..style = PaintingStyle.fill
            ..color = leafColor.withOpacity(opacity));



      canvas.drawArc(Rect.fromCenter(
          center: Offset(leafPosition[0]+cos(randomizedLeafAngle+pi/4)*leafRadius/sqrt(2),
              leafPosition[1]-sin(randomizedLeafAngle+pi/4)*leafRadius/sqrt(2)),
          height: leafRadius*sqrt(2),
          width: leafRadius*sqrt(2)),
          pi*0.25-randomizedLeafAngle, pi / 2, false, Paint()
            ..strokeWidth = 0.0
            ..style = PaintingStyle.fill
            ..color = leafColor.withOpacity(opacity));

      

      break;


    case "circle":

      canvas.drawCircle(
          Offset(pC[0], pC[1]),
          leafRadius,
          Paint()
            ..style = PaintingStyle.fill
            ..color =
            leafColor.withOpacity(opacity));

      break;

    case "triangle":

    // find the tips of the leaf
      List pA = [
        pC[0] - leafRadius * cos(randomizedLeafAngle + pi * 0),
        pC[1] + leafRadius * sin(randomizedLeafAngle + pi * 0)
      ];

      List pB1 = [
        pC[0] - leafRadius * cos(randomizedLeafAngle + pi * (0.5-leafSquareness)),
        pC[1] + leafRadius * sin(randomizedLeafAngle + pi * (0.5-leafSquareness))
      ];

      List pB2 = [
        pC[0] - leafRadius * cos(randomizedLeafAngle - pi * (0.5-leafSquareness)),
        pC[1] + leafRadius * sin(randomizedLeafAngle - pi * (0.5-leafSquareness))
      ];

      Path leaf = Path();
      leaf.moveTo(pA[0], pA[1]);
      leaf.lineTo(pB1[0], pB1[1]);
      leaf.lineTo(pB2[0], pB2[1]);
      leaf.close();

      canvas.drawPath(
          leaf,
          Paint()
            ..style = PaintingStyle.fill
            ..color = leafColor.withOpacity(opacity));

      break;

    case "square":

    // find the tips of the leaf
      List pA = [
        pC[0] - leafRadius * cos(randomizedLeafAngle + pi * 0),
        pC[1] + leafRadius * sin(randomizedLeafAngle + pi * 0)
      ];

      List pB1 = [
        pC[0] - leafRadius * cos(randomizedLeafAngle + pi * (0.5-leafSquareness)),
        pC[1] + leafRadius * sin(randomizedLeafAngle + pi * (0.5-leafSquareness))
      ];

      List pB2 = [
        pC[0] - leafRadius * cos(randomizedLeafAngle - pi * 1),
        pC[1] + leafRadius * sin(randomizedLeafAngle - pi * 1)
      ];

      List pB3 = [
        pC[0] - leafRadius * cos(randomizedLeafAngle - pi * (0.5-leafSquareness)),
        pC[1] + leafRadius * sin(randomizedLeafAngle - pi * (0.5-leafSquareness))
      ];

      Path leaf = Path();
      leaf.moveTo(pA[0], pA[1]);
      leaf.lineTo(pB1[0], pB1[1]);
      leaf.lineTo(pB2[0], pB2[1]);
      leaf.lineTo(pB3[0], pB3[1]);
      leaf.close();

      canvas.drawPath(
          leaf,
          Paint()
            ..style = PaintingStyle.fill
            ..color = leafColor.withOpacity(opacity));



      break;   case "diamond":
  // find the tip of the leaf
    List pS = [
      pC[0] - leafRadius * cos(randomizedLeafAngle + pi),
      pC[1] + leafRadius * sin(randomizedLeafAngle + pi)
    ];

    // find the offset centre of the leaf
    List pOC = [
      pC[0] + leafAsymmetry * leafRadius * cos(randomizedLeafAngle + pi),
      pC[1] - leafAsymmetry * leafRadius * sin(randomizedLeafAngle + pi)
    ];

    List pE = [
      pOC[0] -
          leafSquareness *
              leafRadius *
              cos(randomizedLeafAngle + pi * 0.5),
      pOC[1] +
          leafSquareness *
              leafRadius *
              sin(randomizedLeafAngle + pi * 0.5)
    ];
    List pW = [
      pOC[0] -
          leafSquareness *
              leafRadius *
              cos(randomizedLeafAngle + pi * 1.5),
      pOC[1] +
          leafSquareness *
              leafRadius *
              sin(randomizedLeafAngle + pi * 1.5)
    ];

    Path leaf = Path();
    leaf.moveTo(leafPosition[0], leafPosition[1]);
    leaf.lineTo(pE[0], pE[1]);
    leaf.lineTo(pS[0], pS[1]);
    leaf.lineTo(pW[0], pW[1]);
    leaf.close();

    canvas.drawPath(
        leaf,
        Paint()
          ..style = PaintingStyle.fill
          ..color = leafColor.withOpacity(opacity));



    break;

    case "quadratic":

    // find the tip of the leaf
      List pS = [
        pC[0] - leafRadius * cos(randomizedLeafAngle + pi),
        pC[1] + leafRadius * sin(randomizedLeafAngle + pi)
      ];

      // find the offset centre of the leaf
      List pOC = [
        pC[0] + leafAsymmetry * leafRadius * cos(randomizedLeafAngle + pi),
        pC[1] - leafAsymmetry * leafRadius * sin(randomizedLeafAngle + pi)
      ];

      List pE = [
        pOC[0] -
            leafSquareness *
                leafRadius *
                cos(randomizedLeafAngle + pi * 0.5),
        pOC[1] +
            leafSquareness *
                leafRadius *
                sin(randomizedLeafAngle + pi * 0.5)
      ];
      List pW = [
        pOC[0] -
            leafSquareness *
                leafRadius *
                cos(randomizedLeafAngle + pi * 1.5),
        pOC[1] +
            leafSquareness *
                leafRadius *
                sin(randomizedLeafAngle + pi * 1.5)
      ];

      Path leaf = Path();
      leaf.moveTo(leafPosition[0], leafPosition[1]);
      leaf.quadraticBezierTo(pE[0], pE[1],
          pS[0], pS[1]);
      leaf.quadraticBezierTo(pW[0], pW[1],
          leafPosition[0], leafPosition[1]);
      leaf.close();

      canvas.drawPath(
          leaf,
          Paint()
            ..style = PaintingStyle.fill
            ..color = leafColor.withOpacity(opacity));

      break;
  }
}

void drawPetal(
    Canvas canvas,
    List leafPosition,
    double leafAngle,
    double leafRadius,
    ){

  // leafPosition = [200.0, 500.0];
  // leafAngle = 1.2*pi/2;
  // leafRadius = 100.0;

  // leaf node
  // canvas.drawCircle(Offset(leafPosition[0], leafPosition[1]), 2.0, Paint()
  //   ..strokeWidth = 0.0
  //   ..style = PaintingStyle.fill
  //   ..color = Colors.black);

  // leaf spine
  // canvas.drawLine(Offset(leafPosition[0], leafPosition[1]),
  //     Offset(leafPosition[0]+cos(leafAngle)*leafRadius,
  //         leafPosition[1]-sin(leafAngle)*leafRadius),
  //     Paint()
  //       ..strokeWidth = 1.0
  //       ..style = PaintingStyle.stroke
  //       ..color = Colors.black);


  List petalCentre1 = [
    leafPosition[0]+cos(leafAngle-pi/4)*leafRadius/sqrt(2),
    leafPosition[1]-sin(leafAngle-pi/4)*leafRadius/sqrt(2)];

  // canvas.drawCircle(Offset(petalCentre1[0], petalCentre1[1]), 2, Paint()
  //   ..strokeWidth = 0
  //   ..style = PaintingStyle.fill
  //   ..color = Colors.black);
  
  canvas.drawArc(Rect.fromCenter(
      center: Offset(petalCentre1[0],petalCentre1[1]),
      height: leafRadius*sqrt(2),
      width: leafRadius*sqrt(2)),
      pi*1.25-leafAngle, pi / 2, false, Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.green);

  List petalCentre2 = [
    leafPosition[0]+cos(leafAngle+pi/4)*leafRadius/sqrt(2),
    leafPosition[1]-sin(leafAngle+pi/4)*leafRadius/sqrt(2)];

  // canvas.drawCircle(Offset(petalCentre2[0], petalCentre2[1]), 2, Paint()
  //   ..strokeWidth = 0
  //   ..style = PaintingStyle.fill
  //   ..color = Colors.black);


  canvas.drawArc(Rect.fromCenter(
      center: Offset(petalCentre2[0],petalCentre2[1]),
      height: leafRadius*sqrt(2),
      width: leafRadius*sqrt(2)),
      pi*0.25-leafAngle, pi / 2, false, Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.green);


}



