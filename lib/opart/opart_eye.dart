import 'package:flutter/material.dart';
import '../main.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import '../model_settings.dart';
import 'dart:math';
import 'dart:core';

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

  SettingsModel baseHeight = SettingsModel(
    name: 'baseHeight',
    settingType: SettingType.double,
    label: 'Base Height',
    tooltip: 'The offset from the bottom of the sceen',
    min: 0.0,
    max: 100.0,
    randomMax: 10.0,
    randomMin: 30.0,
    zoom: 100,
    defaultValue: 20.0,
    icon: Icon(Icons.vertical_align_bottom),
    settingCategory: SettingCategory.tool,
    proFeature: false,
  );

  SettingsModel trunkWidth = SettingsModel(
    name: 'trunkWidth',
    settingType: SettingType.double,
    label: 'Trunk Width',
    tooltip: 'The width of the base of the trunk',
    min: 0.0,
    max: 10.0,
    zoom: 100,
    defaultValue: 2.0,
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
    randomMin: 5.0,
    randomMax: 30.0,
    zoom: 100,
    defaultValue: 10.0,
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
    label: 'Leaf Length',
    tooltip: 'The fixed length of each leaf',
    min: 0.0,
    max: 20.0,
    zoom: 100,
    defaultValue: 5.0,
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
    defaultValue: 1.0,
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
    defaultValue: Colors.black,
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
    defaultValue: 0.1,
    icon: Icon(Icons.line_weight),
    settingCategory: SettingCategory.palette,
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


List<SettingsModel> initializeEyeAttributes() {
  return [
    reDraw,
    zoomOpArt,
    baseHeight,
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
    leavesAfter,
    leafAngle,
    leafRadius,
    randomLeafLength,
    leafSquareness,
    leafAsymmetry,
    leafDecay,
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

void paintEye(Canvas canvas, Size size, int seed, double animationVariable, OpArt opArt) {

  rnd = Random(seed);

  if (paletteList.value != opArt.palette.paletteName){
    opArt.selectPalette(paletteList.value);
  }

  // colour in the canvas
  canvas.drawRect(
      Offset(0, 0) & Size(size.width, size.height),
      Paint()
        ..color = backgroundColor.value
        ..style = PaintingStyle.fill);



  int numberOfTrees=20;
  double irisRadius = 20;

  canvas.drawCircle(Offset(size.width, size.height), irisRadius,       Paint()
    ..style = PaintingStyle.fill
    ..color = trunkFillColor.value.withOpacity(opacity.value));
print('irisRadius: $irisRadius');

  for (int t = 0; t<numberOfTrees; t++){
    double treeAngle = 2 * pi * t / numberOfTrees;
    List treeBaseA = [ size.width/2 + irisRadius * cos(treeAngle), size.height/2 - irisRadius * sin(treeAngle)];
    List treeBaseB = [ size.width/2 + irisRadius * cos(treeAngle), size.height/2 - irisRadius * sin(treeAngle)];

    drawSegment(
      canvas,
      rnd,
      0,
      0,
      treeBaseA,
      treeBaseB,
      trunkWidth.value * zoomOpArt.value,
      segmentLength.value * zoomOpArt.value,
      treeAngle,
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


  }

}

drawSegment(
    Canvas canvas,
    Random rnd,
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
    drawTheTriangle(canvas, rnd, borderX, borderY, rootA, rootB, rootX,
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

    drawSegment( canvas, rnd, borderX, borderY, rootA, rootX, width * widthDecay, segmentLength * segmentDecay, directionB, ratio, currentDepth + 1, lineWidth, leafRadius, randomLeafLength, leafShape, true, animationVariable, branch, angle, widthDecay, segmentDecay, bulbousness, leavesAfter, maxDepth, leafAngle, leafDecay, leafSquareness, leafAsymmetry, trunkFillColor, opacity, numberOfColors, trunkStrokeWidth, trunkOutlineColor, palette, );
    drawSegment( canvas, rnd, borderX, borderY, rootX, rootB, width * widthDecay, segmentLength * segmentDecay, directionA, ratio, currentDepth + 1, lineWidth, leafRadius, randomLeafLength, leafShape, true, animationVariable, branch, angle, widthDecay, segmentDecay, bulbousness, leavesAfter, maxDepth, leafAngle, leafDecay, leafSquareness, leafAsymmetry, trunkFillColor, opacity, numberOfColors, trunkStrokeWidth, trunkOutlineColor, palette, );


  } else {
    //grow
    List PD = [
      segmentBaseCentre[0] + segmentLength * cos(direction),
      segmentBaseCentre[1] - segmentLength * sin(direction)
    ];
    List P2 = [
      PD[0] + 0.5 * width * widthDecay * sin(direction),
      PD[1] + 0.5 * width * widthDecay * cos(direction)
    ];
    List P3 = [
      PD[0] - 0.5 * width * widthDecay * sin(direction),
      PD[1] - 0.5 * width * widthDecay * cos(direction)
    ];

    // draw the trunk
    drawTheTrunk(canvas, rnd, borderX, borderY, rootB, P2, P3, rootA,
        bulbousness, trunkFillColor, opacity, trunkStrokeWidth, trunkOutlineColor);

    // // Draw the leaves
    // if (currentDepth > leavesAfter) {
    //   drawTheLeaf(
    //     canvas,
    //     rnd,
    //     borderX,
    //     borderY,
    //     P2,
    //     lineWidth,
    //     direction - leafAngle,
    //     leafRadius,
    //     leafShape,
    //     ratio,
    //     randomLeafLength,
    //     leafSquareness,
    //     leafAsymmetry,
    //     animationVariable,
    //     opacity,
    //     numberOfColors,
    //     palette,
    //   );
    //   drawTheLeaf(
    //     canvas,
    //     rnd,
    //     borderX,
    //     borderY,
    //     P3,
    //     lineWidth,
    //     direction + leafAngle,
    //     leafRadius,
    //     leafShape,
    //     ratio,
    //     randomLeafLength,
    //     leafSquareness,
    //     leafAsymmetry,
    //     animationVariable,
    //     opacity,
    //     numberOfColors,
    //     palette,
    //   );
    // }

    // next
    if (currentDepth < maxDepth) {
      drawSegment(
        canvas,
        rnd,
        borderX,
        borderY,
        P3,
        P2,
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
    double borderX,
    double borderY,
    List P1,
    List P2,
    List P3,
    List P4,
    double bulbousness,
    Color trunkFillColor,
    double opacity,
    double trunkStrokeWidth,
    Color trunkOutlineColor,
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
    double borderX,
    double borderY,
    List P1,
    List P2,
    List P3,
    Color trunkFillColor,
    double opacity,
    double trunkStrokeWidth,
    Color trunkOutlineColor,
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
    double borderX,
    double borderY,
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

  double randomizedLeafAngle = leafAngle +  cos(animationVariable*20000);

  // find the centre of the leaf
  List PC = [
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
          Offset(PC[0], PC[1]),
          leafRadius,
          Paint()
            ..style = PaintingStyle.fill
            ..color =
            leafColor.withOpacity(opacity));

      break;

    case "triangle":

    // find the tips of the leaf
      List PA = [
        PC[0] - leafRadius * cos(randomizedLeafAngle + pi * 0),
        PC[1] + leafRadius * sin(randomizedLeafAngle + pi * 0)
      ];

      List PB1 = [
        PC[0] - leafRadius * cos(randomizedLeafAngle + pi * (0.5-leafSquareness)),
        PC[1] + leafRadius * sin(randomizedLeafAngle + pi * (0.5-leafSquareness))
      ];

      List PB2 = [
        PC[0] - leafRadius * cos(randomizedLeafAngle - pi * (0.5-leafSquareness)),
        PC[1] + leafRadius * sin(randomizedLeafAngle - pi * (0.5-leafSquareness))
      ];

      Path leaf = Path();
      leaf.moveTo(borderX + PA[0], -borderY + PA[1]);
      leaf.lineTo(borderX + PB1[0], -borderY + PB1[1]);
      leaf.lineTo(borderX + PB2[0], -borderY + PB2[1]);
      leaf.close();

      canvas.drawPath(
          leaf,
          Paint()
            ..style = PaintingStyle.fill
            ..color = leafColor.withOpacity(opacity));

      break;

    case "square":

    // find the tips of the leaf
      List PA = [
        PC[0] - leafRadius * cos(randomizedLeafAngle + pi * 0),
        PC[1] + leafRadius * sin(randomizedLeafAngle + pi * 0)
      ];

      List PB1 = [
        PC[0] - leafRadius * cos(randomizedLeafAngle + pi * (0.5-leafSquareness)),
        PC[1] + leafRadius * sin(randomizedLeafAngle + pi * (0.5-leafSquareness))
      ];

      List PB2 = [
        PC[0] - leafRadius * cos(randomizedLeafAngle - pi * 1),
        PC[1] + leafRadius * sin(randomizedLeafAngle - pi * 1)
      ];

      List PB3 = [
        PC[0] - leafRadius * cos(randomizedLeafAngle - pi * (0.5-leafSquareness)),
        PC[1] + leafRadius * sin(randomizedLeafAngle - pi * (0.5-leafSquareness))
      ];

      Path leaf = Path();
      leaf.moveTo(borderX + PA[0], -borderY + PA[1]);
      leaf.lineTo(borderX + PB1[0], -borderY + PB1[1]);
      leaf.lineTo(borderX + PB2[0], -borderY + PB2[1]);
      leaf.lineTo(borderX + PB3[0], -borderY + PB3[1]);
      leaf.close();

      canvas.drawPath(
          leaf,
          Paint()
            ..style = PaintingStyle.fill
            ..color = leafColor.withOpacity(opacity));



      break;   case "diamond":
  // find the tip of the leaf
    List PS = [
      PC[0] - leafRadius * cos(randomizedLeafAngle + pi),
      PC[1] + leafRadius * sin(randomizedLeafAngle + pi)
    ];

    // find the offset centre of the leaf
    List POC = [
      PC[0] + leafAsymmetry * leafRadius * cos(randomizedLeafAngle + pi),
      PC[1] - leafAsymmetry * leafRadius * sin(randomizedLeafAngle + pi)
    ];

    List PE = [
      POC[0] -
          leafSquareness *
              leafRadius *
              cos(randomizedLeafAngle + pi * 0.5),
      POC[1] +
          leafSquareness *
              leafRadius *
              sin(randomizedLeafAngle + pi * 0.5)
    ];
    List PW = [
      POC[0] -
          leafSquareness *
              leafRadius *
              cos(randomizedLeafAngle + pi * 1.5),
      POC[1] +
          leafSquareness *
              leafRadius *
              sin(randomizedLeafAngle + pi * 1.5)
    ];

    Path leaf = Path();
    leaf.moveTo(borderX + leafPosition[0], -borderY + leafPosition[1]);
    leaf.lineTo(borderX + PE[0], -borderY + PE[1]);
    leaf.lineTo(borderX + PS[0], -borderY + PS[1]);
    leaf.lineTo(borderX + PW[0], -borderY + PW[1]);
    leaf.close();

    canvas.drawPath(
        leaf,
        Paint()
          ..style = PaintingStyle.fill
          ..color = leafColor.withOpacity(opacity));



    break;

    case "quadratic":

    // find the tip of the leaf
      List PS = [
        PC[0] - leafRadius * cos(randomizedLeafAngle + pi),
        PC[1] + leafRadius * sin(randomizedLeafAngle + pi)
      ];

      // find the offset centre of the leaf
      List POC = [
        PC[0] + leafAsymmetry * leafRadius * cos(randomizedLeafAngle + pi),
        PC[1] - leafAsymmetry * leafRadius * sin(randomizedLeafAngle + pi)
      ];

      List PE = [
        POC[0] -
            leafSquareness *
                leafRadius *
                cos(randomizedLeafAngle + pi * 0.5),
        POC[1] +
            leafSquareness *
                leafRadius *
                sin(randomizedLeafAngle + pi * 0.5)
      ];
      List PW = [
        POC[0] -
            leafSquareness *
                leafRadius *
                cos(randomizedLeafAngle + pi * 1.5),
        POC[1] +
            leafSquareness *
                leafRadius *
                sin(randomizedLeafAngle + pi * 1.5)
      ];

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



