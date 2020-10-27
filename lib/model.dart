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
List<Map<String, dynamic>> cachedList = List<Map<String, dynamic>>();

final rebuildCache = new ValueNotifier(0);
final rebuildCanvas = new ValueNotifier(0);
bool enableButton = true;

bool proVersion = false;

ScrollController scrollController = new ScrollController();

enum OpArtType { Fibonacci, Trees, Waves, Wallpaper }

class OpArt {
  OpArtType opArtType;

  List<SettingsModel> attributes = List<SettingsModel>();
  File image;
  List<Map<String, dynamic>> cache = List();
  Random rnd = Random();
  OpArtPalette palette;
  String name;
  void paint(Canvas canvas, Size size, int seed, Random rnd, double angle) {
    switch(opArtType){
      case OpArtType.Fibonacci:
        paintFibonacci( canvas,  size,  rnd,  angle, this.attributes, palette);
    }

  }

  OpArt({this.opArtType}) {
    switch (opArtType) {
      case OpArtType.Fibonacci:
        this.attributes = initializeFibonacciAttributes();
        this.palette = OpArtPalette(rnd);
        this.name = 'Fibonacci';
    }
    this.setDefault();
  }

  void saveToCache() {
    Map<String, dynamic> map = Map();
    for (int i = 0; i < attributes.length; i++) {
      map.addAll({attributes[i].label: attributes[i].value});
    }
    cachedList.add(map);
  }

  void revertToCache(int index) {
    for (int i = 0; i < attributes.length; i++) {
      attributes[i].value = cachedList[index][attributes[i].label];
    }
  }

  void clearCache() {
    cache.clear();
  }

  int cacheListLength() {
    return cache.length;
  }

  void randomize() {
    for (int i = 0; i < attributes.length; i++) {
      print(attributes[i].name);
      attributes[i].randomize(rnd);
    }
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
