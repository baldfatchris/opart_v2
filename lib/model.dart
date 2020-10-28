import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'opart_fibonacci.dart';
import 'opart_wave.dart';
import 'opart_wallpaper.dart';
import 'opart_tree.dart';
import 'package:opart_v2/palette.dart';
import 'settings_model.dart';

import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';

Random rnd = Random();
int seed = rnd.nextInt(1 << 32);

ScreenshotController screenshotController = ScreenshotController();

final rebuildCache = new ValueNotifier(0);
final rebuildCanvas = new ValueNotifier(0);
bool enableButton = true;

bool proVersion = false;

ScrollController scrollController = new ScrollController();

enum OpArtType { Fibonacci, Tree, Wave, Wallpaper }

class OpArt {
  OpArtType opArtType;
  List<SettingsModel> attributes = List<SettingsModel>();
  List<Map<String, dynamic>> cache = List();
  Random rnd = Random();
  OpArtPalette palette;
  String name;

  // Initialise
  OpArt({this.opArtType}) {

    switch (opArtType) {
      case OpArtType.Fibonacci:
        this.attributes = initializeFibonacciAttributes();
        this.palette = OpArtPalette();
        this.name = 'Fibonacci';

        break;

      case OpArtType.Tree:
        this.attributes = initializeTreeAttributes();
        this.palette = OpArtPalette();
        this.name = 'Tree';

        break;

      case OpArtType.Wallpaper:
        // this.attributes = initializeWallpaperAttributes();
        // this.palette = OpArtPalette(rnd);
        // this.name = 'Wave';

        break;

      case OpArtType.Wave:
        this.attributes = initializeWaveAttributes();
        this.palette = OpArtPalette();
        this.name = 'Wave';

        break;
    }

    this.setDefault();
  }

  void saveToCache() {
    // print('saving to cache');
    screenshotController.capture(
        delay: Duration(milliseconds: 100),
        pixelRatio: 0.2
    ).then((File image) async {

      Map<String, dynamic> map = Map();
      for (int i = 0; i < attributes.length; i++) {
        map.addAll({attributes[i].label: attributes[i].value});
      }
      map.addAll({'image': image, 'paletteName': palette.paletteName, 'colors': palette.colorList});

      // print('Cache map: $map');
      // print('palette: ${map['palette']}');

      this.cache.add(map);
      rebuildCache.value++;
    }
    );

  }

  void revertToCache(int index) {
    for (int i = 0; i < attributes.length; i++) {
      attributes[i].value = this.cache[index][attributes[i].label];
    }
    palette.paletteName = this.cache[index]['paletteName'];
    palette.colorList = this.cache[index]['colors'];
  }

  void clearCache() {
    cache.clear();
  }

  int cacheListLength() {
    return cache.length;
  }

  void paint(Canvas canvas, Size size, int seed, Random rnd, double animationVariable) {
    switch(opArtType){
      case OpArtType.Fibonacci:
        paintFibonacci( canvas,  size,  rnd,  animationVariable, this.attributes, palette);
        break;
      case OpArtType.Tree:
        paintTree( canvas,  size,  rnd,  animationVariable, this.attributes, palette);
        break;
      case OpArtType.Wave:
        paintWave( canvas,  size,  rnd,  animationVariable, this.attributes, palette);
        break;
    }
  }


  // randomise the non-palette settings
  void randomizeSettings() {
    print('Randomizing Settings');
    for (int i = 0; i < attributes.length; i++) {
      if (attributes[i].settingCategory == SettingCategory.tool){
        attributes[i].randomize(rnd);
        print('${attributes[i].name}: ${attributes[i].value}');
      }
    }
    randomizePalette();
  }

  // randomise the palette
  void randomizePalette() {
    print('Randomizing Palette');
    for (int i = 0; i < attributes.length; i++) {
      if (attributes[i].settingCategory == SettingCategory.palette){
        attributes[i].randomize(rnd);
        print('${attributes[i].name}: ${attributes[i].value}');
      }
    }

    palette.randomize(
      attributes.firstWhere((element) => element.name == 'paletteType').value,
      attributes.firstWhere((element) => element.name == 'numberOfColors').value.toInt(),
    );
  }




  void setDefault() {
    for (int i = 0; i < attributes.length; i++) {
      attributes[i].setDefault();
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
