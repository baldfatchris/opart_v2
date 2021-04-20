import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:opart_v2/opart/opart_life.dart';
import 'package:opart_v2/opart/opart_triangles.dart';
import 'package:screenshot/screenshot.dart';

import 'canvas.dart';
import 'database_helper.dart';
import 'main.dart';
import 'model_palette.dart';
import 'model_settings.dart';
import 'opart/opart_diagonal.dart';
import 'opart/opart_eye.dart';
import 'opart/opart_fibonacci.dart';
import 'opart/opart_flow.dart';
import 'opart/opart_hexagons.dart';
import 'opart/opart_maze.dart';
import 'opart/opart_neighbour.dart';
import 'opart/opart_plasma.dart';
import 'opart/opart_quads.dart';
import 'opart/opart_rhombus.dart';
import 'opart/opart_riley.dart';
import 'opart/opart_shapes.dart';
import 'opart/opart_squares.dart';
import 'opart/opart_string.dart';
import 'opart/opart_tree.dart';
import 'opart/opart_wallpaper.dart';
import 'opart/opart_wave.dart';

List<Map<String, dynamic>> savedOpArt = [];
ScreenshotController screenshotController = ScreenshotController();

final rebuildCache = ValueNotifier(0);
final rebuildMain = ValueNotifier(0);
final rebuildCanvas = ValueNotifier(0);
final rebuildOpArtPage = ValueNotifier(0);
final rebuildTab = ValueNotifier(0);
final rebuildGallery = ValueNotifier(0);
final rebuildDialog = ValueNotifier(0);
final rebuildColorPicker = ValueNotifier(0);

bool enableButton = true;

ScrollController scrollController = ScrollController();

enum OpArtType {
  Diagonal,
  Eye,
  Flow,
  Fibonacci,
  Hexagons,
  Life,
  Maze,
  Neighbour,
  Plasma,
  Quads,
  Rhombus,
  Riley,
  Shapes,
  Squares,
  String,
  Tree,
  Triangles,
  Wallpaper,
  Wave,
}

class OpArtTypes {
  String name;
  OpArtType opArtType;
  String image;
  OpArtTypes(this.name, this.opArtType, this.image);
}

class OpArt {
  OpArtType opArtType;
  List<SettingsModel> attributes = [];
  List<Map<String, dynamic>> cache = [];
  // Random rnd = Random();
  OpArtPalette palette;
  String name;
  bool animation = true;

  // Initialise
  OpArt({this.opArtType}) {
    switch (opArtType) {
      case OpArtType.Diagonal:
        attributes = initializeDiagonalAttributes();
        palette = OpArtPalette();
        name = 'Diagonal';
        animation = false;

        break;

      case OpArtType.Eye:
        attributes = initializeEyeAttributes();
        palette = OpArtPalette();
        name = 'Eye';
        animation = false;

        break;

      case OpArtType.Fibonacci:
        attributes = initializeFibonacciAttributes();
        palette = OpArtPalette();
        name = 'Spirals';

        break;

      case OpArtType.Hexagons:
        attributes = initializeHexagonsAttributes();
        palette = OpArtPalette();
        name = 'Hexagons';
        animation = false;

        break;

      case OpArtType.Life:
        attributes = initializeLifeAttributes();
        palette = OpArtPalette();
        name = 'Life';
        animation = true;

        break;

      case OpArtType.Maze:
        attributes = initializeMazeAttributes();
        palette = OpArtPalette();
        name = 'Maze';
        animation = false;

        break;

      case OpArtType.Neighbour:
        attributes = initializeNeighbourAttributes();
        palette = OpArtPalette();
        name = 'Neighbours';
        animation = false;

        break;

      case OpArtType.Plasma:
        attributes = initializePlasmaAttributes();
        palette = OpArtPalette();
        name = 'Plasma';
        animation = true;

        break;

      case OpArtType.Quads:
        attributes = initializeQuadsAttributes();
        palette = OpArtPalette();
        name = 'Quads';
        animation = false;

        break;

      case OpArtType.Rhombus:
        attributes = initializeRhombusAttributes();
        palette = OpArtPalette();
        name = 'Rhombus';
        animation = false;

        break;

      case OpArtType.Riley:
        attributes = initializeRileyAttributes();
        palette = OpArtPalette();
        name = 'Riley';
        animation = false;

        break;

      case OpArtType.Flow:
        attributes = initializeFlowAttributes();
        palette = OpArtPalette();
        name = 'Flow ';
        animation = true;

        break;

      case OpArtType.Shapes:
        attributes = initializeShapesAttributes();
        palette = OpArtPalette();
        name = 'Shapes';
        animation = false;

        break;

      case OpArtType.Squares:
        attributes = initializeSquaresAttributes();
        palette = OpArtPalette();
        name = 'Squares';
        animation = false;

        break;

      case OpArtType.String:
        attributes = initializeStringAttributes();
        palette = OpArtPalette();
        name = 'String';
        animation = false;

        break;

      case OpArtType.Tree:
        attributes = initializeTreeAttributes();
        palette = OpArtPalette();
        name = 'Tree';
        animation = true;

        break;

      case OpArtType.Triangles:
        attributes = initializeTrianglesAttributes();
        palette = OpArtPalette();
        name = 'Triangles';
        animation = false;

        break;

      case OpArtType.Wallpaper:
        attributes = initializeWallpaperAttributes();
        palette = OpArtPalette();
        name = 'Wallpaper';
        animation = false;

        break;

      case OpArtType.Wave:
        attributes = initializeWaveAttributes();
        palette = OpArtPalette();
        name = 'Wave';

        break;
    }

    setDefault();
  }

  Future<int> saveToLocalDB(bool paid) async {
    await screenshotController
        .capture(
      delay: const Duration(milliseconds: 100),
    )
        .then((File image) async {
      final List<int> imageBytes = image.readAsBytesSync();
      final String base64Image = base64Encode(imageBytes);
      Map<String, dynamic> map = {};
      for (int i = 0; i < attributes.length; i++) {
        map.addAll({attributes[i].label: attributes[i].value});
      }
      map.addAll({
        'seed': seed,
        'colors': palette.colorList,
        'image': base64Image,
        'paletteName': palette.paletteName,
        'type': opArtType,
        'paid': paid,
        'animationControllerValue': animation ? animationController.value : 1.0,
      });

      Map<String, dynamic> sqlMap = {};

      for (int i = 0; i < attributes.length; i++) {
        if (attributes[i].settingType == SettingType.color) {
          sqlMap.addAll({attributes[i].label: attributes[i].value.toString()});
        } else {
          sqlMap.addAll({attributes[i].label: attributes[i].value});
        }
      }
      sqlMap.addAll({
        'seed': seed,
        'colors': palette.colorList.toString(),
        'image': base64Image,
        'paletteName': palette.paletteName,
        'type': opArtType.toString(),
        'paid': paid,
        'animationControllerValue': animation ? animationController.value : 1.0
      });

      DatabaseHelper helper = DatabaseHelper.instance;
      await helper.insert(sqlMap).then((id) {
        map.addAll({'id': id});
        savedOpArt.add(map);
        rebuildMain.value++;
        rebuildGallery.value++;
      });
    });
    return savedOpArt.length;
  }

  void saveToCache() {
    WidgetsBinding.instance.addPostFrameCallback((_) => screenshotController
            .capture(delay: const Duration(milliseconds: 100), pixelRatio: 0.2)
            .then((File image) async {
          Map<String, dynamic> map = {};
          for (int i = 0; i < attributes.length; i++) {
            map.addAll({attributes[i].label: attributes[i].value});
          }
          map.addAll({
            'seed': seed,
            'image': image,
            'paletteName': palette.paletteName,
            'colors': palette.colorList,
            'numberOfColors': numberOfColors.value,
            'animationControllerValue':
                animation ? animationController.value : 1.0
          });

          cache.add(map);

          rebuildCache.value++;
          if (scrollController.hasClients) {
            await scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn);
          }
          enableButton = true;
        }));
  }

  void revertToCache(int index) {
    seed = cache[index]['seed'] as int;
    if (animation) {
      animationController.forward(
          from: cache[index]['animationControllerValue'] as double);
    }
    for (int i = 0; i < attributes.length; i++) {
      attributes[i].value = cache[index][attributes[i].label];
    }
    numberOfColors.value = cache[index]['numberOfColors'];
    palette.paletteName = cache[index]['paletteName'] as String;
    palette.colorList = cache[index]['colors'] as List<Color>;

    rebuildCanvas.value++;
    rebuildTab.value++;
  }

  void clearCache() {
    cache.clear();
  }

  int cacheListLength() {
    return cache.length;
  }

  void paint(Canvas canvas, Size size, int seed, double animationVariable) {
    switch (opArtType) {
      case OpArtType.Diagonal:
        paintDiagonal(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Eye:
        paintEye(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Fibonacci:
        paintFibonacci(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Flow:
        paintFlow(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Hexagons:
        paintHexagons(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Life:
        paintLife(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Maze:
        paintMaze(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Neighbour:
        paintNeighbour(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Plasma:
        paintPlasma(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Quads:
        paintQuads(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Rhombus:
        paintRhombus(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Riley:
        paintRiley(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Shapes:
        paintShapes(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Squares:
        paintSquares(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.String:
        paintString(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Tree:
        paintTree(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Triangles:
        paintTriangles(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Wallpaper:
        paintWallpaper(canvas, size, seed, animationVariable, this);
        break;
      case OpArtType.Wave:
        paintWave(canvas, size, seed, animationVariable, this);
        break;
    }
  }

  // randomise the non-palette settings
  void randomizeSettings() {
    seed = DateTime.now().millisecond;
    final Random rnd = Random(seed);

    for (int i = 0; i < attributes.length; i++) {
      if (attributes[i].settingCategory == SettingCategory.tool) {
        attributes[i].randomize(rnd);
      }
    }
  }

  // select a palette from the list
  void selectPalette(String paletteName) {
    final List newPalette =
        defaultPalettes.firstWhere((palette) => palette[0] == paletteName);
    palette.colorList = [];
    for (int z = 0; z < (newPalette[3].length as num); z++) {
      palette.colorList.add(Color(int.parse(newPalette[3][z] as String)));
    }
    attributes.firstWhere((element) => element.name == 'numberOfColors').value =
        newPalette[1].toInt();
    backgroundColor?.value = Color(int.parse(newPalette[2] as String));
  }

  // randomise the palette
  void randomizePalette() {
    seed = DateTime.now().millisecond;
    Random rnd = Random(seed);

    for (int i = 0; i < attributes.length; i++) {
      if (attributes[i].settingCategory == SettingCategory.palette) {
        attributes[i].randomize(rnd);
      }
    }

    palette.randomize(
      attributes.firstWhere((element) => element.name == 'paletteType').value
          as String,
      attributes
          .firstWhere((element) => element.name == 'numberOfColors')
          .value
          .toInt() as int,
    );

    attributes.firstWhere((element) => element.name == 'paletteList').value =
        'Default';
  }

  // reset to defaults
  void setDefault() {
    for (int i = 0; i < attributes.length; i++) {
      attributes[i].setDefault();
    }

    List newPalette =
        defaultPalettes.firstWhere((palette) => palette[0] == 'Default');

    backgroundColor?.value = Color(int.parse(newPalette[2] as String));
    palette.colorList = [];
    for (int z = 0; z < (newPalette[3].length as num); z++) {
      palette.colorList.add(Color(int.parse(newPalette[3][z] as String)));
    }
  }

  // Map<String, dynamic> toMap() {
  //   Map<String, dynamic> currentMap = {
  //     'opArtType': this.opArtType,
  //     'palette': this.palette,
  //   };
  //   return currentMap;
  // }
  //
  // void fromMap(Map<String, dynamic> map) {
  //   this.opArtType = map['opArtType'];
  //   this.palette = map['palette'];
  // }
}
