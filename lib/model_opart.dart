import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'package:opart_v2/opart/opart_life.dart';
import 'package:opart_v2/opart/opart_triangles.dart';

import 'canvas.dart';
import 'database_helper.dart';
import 'main.dart';
import 'opart/opart_diagonal.dart';
import 'opart/opart_eye.dart';
import 'opart/opart_fibonacci.dart';
import 'opart/opart_hexagons.dart';
import 'opart/opart_maze.dart';
import 'opart/opart_neighbour.dart';
import 'opart/opart_plasma.dart';
import 'opart/opart_quads.dart';
import 'opart/opart_rhombus.dart';
import 'opart/opart_riley.dart';
import 'opart/opart_shapes.dart';
import 'opart/opart_squares.dart';
import 'opart/opart_tree.dart';
import 'opart/opart_wallpaper.dart';
import 'opart/opart_wave.dart';

import 'model_palette.dart';
import 'model_settings.dart';

import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

List<Map<String, dynamic>> savedOpArt = List();
ScreenshotController screenshotController = ScreenshotController();

final rebuildCache = new ValueNotifier(0);
final rebuildMain = new ValueNotifier(0);
final rebuildCanvas = new ValueNotifier(0);
final rebuildOpArtPage = ValueNotifier(0);
final rebuildTab = ValueNotifier(0);
final rebuildGallery = new ValueNotifier(0);
final rebuildDialog = new ValueNotifier(0);
final rebuildColorPicker = new ValueNotifier(0);

bool enableButton = true;

ScrollController scrollController = new ScrollController();

enum OpArtType {
  Diagonal,
  Eye,
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
  List<SettingsModel> attributes = List<SettingsModel>();
  List<Map<String, dynamic>> cache = List();
  // Random rnd = Random();
  OpArtPalette palette;
  String name;
  bool animation = true;

  // Initialise
  OpArt({this.opArtType}) {
    switch (opArtType) {
      case OpArtType.Diagonal:
        this.attributes = initializeDiagonalAttributes();
        this.palette = OpArtPalette();
        this.name = 'Diagonal';
        this.animation = false;

        break;

      case OpArtType.Eye:
        this.attributes = initializeEyeAttributes();
        this.palette = OpArtPalette();
        this.name = 'Eye';
        this.animation = false;

        break;

      case OpArtType.Fibonacci:
        this.attributes = initializeFibonacciAttributes();
        this.palette = OpArtPalette();
        this.name = 'Spirals';

        break;

      case OpArtType.Hexagons:
        this.attributes = initializeHexagonsAttributes();
        this.palette = OpArtPalette();
        this.name = 'Hexagons';
        this.animation = false;

        break;

      case OpArtType.Life:
        this.attributes = initializeLifeAttributes();
        this.palette = OpArtPalette();
        this.name = 'Life';
        this.animation = true;

        break;

      case OpArtType.Maze:
        this.attributes = initializeMazeAttributes();
        this.palette = OpArtPalette();
        this.name = 'Maze';
        this.animation = false;

        break;

      case OpArtType.Neighbour:
        this.attributes = initializeNeighbourAttributes();
        this.palette = OpArtPalette();
        this.name = 'Neighbours';
        this.animation = false;

        break;

      case OpArtType.Plasma:
        this.attributes = initializePlasmaAttributes();
        this.palette = OpArtPalette();
        this.name = 'Plasma';
        this.animation = true;

        break;

      case OpArtType.Quads:
        this.attributes = initializeQuadsAttributes();
        this.palette = OpArtPalette();
        this.name = 'Quads';
        this.animation = false;

        break;

      case OpArtType.Rhombus:
        this.attributes = initializeRhombusAttributes();
        this.palette = OpArtPalette();
        this.name = 'Rhombus';
        this.animation = false;

        break;

      case OpArtType.Riley:
        this.attributes = initializeRileyAttributes();
        this.palette = OpArtPalette();
        this.name = 'Riley';
        this.animation = false;

        break;

      case OpArtType.Shapes:
        this.attributes = initializeShapesAttributes();
        this.palette = OpArtPalette();
        this.name = 'Shapes';
        this.animation = false;

        break;

      case OpArtType.Squares:
        this.attributes = initializeSquaresAttributes();
        this.palette = OpArtPalette();
        this.name = 'Squares';
        this.animation = false;

        break;

      case OpArtType.Tree:
        this.attributes = initializeTreeAttributes();
        this.palette = OpArtPalette();
        this.name = 'Tree';
        this.animation = true;

        break;

      case OpArtType.Triangles:
        this.attributes = initializeTrianglesAttributes();
        this.palette = OpArtPalette();
        this.name = 'Triangles';
        this.animation = false;

        break;

      case OpArtType.Wallpaper:
        this.attributes = initializeWallpaperAttributes();
        this.palette = OpArtPalette();
        this.name = 'Wallpaper';
        this.animation = false;

        break;

      case OpArtType.Wave:
        this.attributes = initializeWaveAttributes();
        this.palette = OpArtPalette();
        this.name = 'Wave';

        break;
    }

    this.setDefault();
  }

  Future<int> saveToLocalDB(bool paid) async {
    screenshotController
            .capture(delay: Duration(milliseconds: 100), pixelRatio: 1)
            .then((File image) async {
          List<int> imageBytes = image.readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          Map<String, dynamic> map = Map();
          for (int i = 0; i < attributes.length; i++) {
            map.addAll({attributes[i].label: attributes[i].value});
          }
          map.addAll({
            'seed': seed,
            'colors': palette.colorList,
            'image': base64Image,
            'paletteName': palette.paletteName,
            'type': this.opArtType,
            'paid': paid,
            'animationControllerValue': this.animation ? animationController.value : 1.0,
          });

          Map<String, dynamic> sqlMap = Map();

          for (int i = 0; i < attributes.length; i++) {
            if (attributes[i].settingType == SettingType.color) {
              sqlMap.addAll(
                  {attributes[i].label: attributes[i].value.toString()});
            } else {
              sqlMap.addAll({attributes[i].label: attributes[i].value});
            }
          }
          sqlMap.addAll({
            'seed': seed,
            'colors': palette.colorList.toString(),
            'image': base64Image,
            'paletteName': palette.paletteName,
            'type': this.opArtType.toString(),
            'paid': paid,
            'animationControllerValue': this.animation ? animationController.value : 1
          });

          DatabaseHelper helper = DatabaseHelper.instance;
          helper.insert(sqlMap).then((id) {
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
            .capture(delay: Duration(milliseconds: 100), pixelRatio: 0.2)
            .then((File image) async {
          Map<String, dynamic> map = Map();
          for (int i = 0; i < attributes.length; i++) {
            map.addAll({attributes[i].label: attributes[i].value});
          }
          map.addAll({
            'seed': seed,
            'image': image,
            'paletteName': palette.paletteName,
            'colors': palette.colorList,
            'numberOfColors': numberOfColors.value,
            'animationControllerValue': this.animation ? animationController.value : 1.0
          });


          this.cache.add(map);
          print(map);
          rebuildCache.value++;
          if (scrollController.hasClients) {
            scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn);
          }
          enableButton = true;
        }));
  }

  void revertToCache(int index) {
    seed = this.cache[index]['seed'];
    if(this.animation){ animationController.forward(from: this.cache[index]['animationControllerValue']);}
    for (int i = 0; i < attributes.length; i++) {
      attributes[i].value = this.cache[index][attributes[i].label];
    }
    numberOfColors.value = this.cache[index]['numberOfColors'];
    palette.paletteName = this.cache[index]['paletteName'];
    palette.colorList = this.cache[index]['colors'];

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
    Random rnd = Random(seed);

    for (int i = 0; i < attributes.length; i++) {
      if (attributes[i].settingCategory == SettingCategory.tool) {
        attributes[i].randomize(rnd);
      }
    }
  }

  // select a palette from the list
  void selectPalette(String paletteName) {
    List newPalette =
        defaultPalettes.firstWhere((palette) => palette[0] == paletteName);
    palette.colorList = [];
    for (int z = 0; z < newPalette[3].length; z++) {
      palette.colorList.add(Color(int.parse(newPalette[3][z])));
    }
    attributes.firstWhere((element) => element.name == 'numberOfColors').value =
        newPalette[1].toInt();
    backgroundColor?.value = Color(int.parse(newPalette[2]));
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
      attributes.firstWhere((element) => element.name == 'paletteType').value,
      attributes
          .firstWhere((element) => element.name == 'numberOfColors')
          .value
          .toInt(),
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
        defaultPalettes.firstWhere((palette) => palette[0] == "Default");

    backgroundColor?.value = Color(int.parse(newPalette[2]));
    palette.colorList = [];
    for (int z = 0; z < newPalette[3].length; z++) {
      palette.colorList.add(Color(int.parse(newPalette[3][z])));
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
