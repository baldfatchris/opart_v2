import 'dart:core';
import 'dart:math';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

Random rnd = Random();
int seed = rnd.nextInt(1 << 32);

ScreenshotController screenshotController = ScreenshotController();
List<Map<String, dynamic>> cachedFibonacciList = List<Map<String, dynamic>>();
List<Map<String, dynamic>> cachedTreeList = List<Map<String, dynamic>>();
List<Map<String, dynamic>> cachedWallpaperList = List<Map<String, dynamic>>();
List<Map<String, dynamic>> cachedWaveList = List<Map<String, dynamic>>();

final rebuildCache = new ValueNotifier(0);
final rebuildCanvas = new ValueNotifier(0);
bool enableButton = true;

bool proVersion=false;



class SettingsModelDouble {
  double value;
  bool locked = false;
  final String label;
  final String tooltip;
  final Icon icon;
  final double min;
  final double max;
  final double randomMin;
  final double randomMax;
  final double zoom;
  final double defaultValue;
  final String type = 'Double';
  final bool proFeature;

  SettingsModelDouble({this.label, this.tooltip, this.icon, this.min, this.max, this.randomMin, this.randomMax, this.zoom, this.defaultValue, this.value, this.proFeature});

  void randomise(Random rnd){

    if (!this.locked && (proVersion || !proVersion && !this.proFeature)) {

      double min = (this.randomMin != null) ? this.randomMin : this.min;
      double max = (this.randomMax != null) ? this.randomMax : this.max;

      // half the time use the default
      this.value =  (rnd.nextBool() == true) ? rnd.nextDouble() * (max - min) + min : this.defaultValue;
    }
  }
}

class SettingsModelInt {
  int value;
  bool locked = false;
  final String label;
  final String tooltip;
  final Icon icon;
  final int min;
  final int max;
  final int randomMin;
  final int randomMax;
  final int defaultValue;
  final String type = 'Int';
  final bool proFeature;

  SettingsModelInt({this.label, this.tooltip, this.icon, this.min, this.max, this.randomMin, this.randomMax, this.defaultValue, this.value, this.proFeature});

  void randomise(Random rnd){
    if (!this.locked && (proVersion || !proVersion && !this.proFeature)) {
      int min = (this.randomMin != null) ? this.randomMin : this.min;
      int max = (this.randomMax != null) ? this.randomMax : this.max;


      // half the time use the default
      this.value =  (rnd.nextBool() == true) ? rnd.nextInt(max - min) + min : this.defaultValue;
    }
  }
}

class SettingsModelBool {
  bool value;
  bool locked = false;
  final String label;
  final String tooltip;
  final Icon icon;
  final String falseLabel;
  final String trueLabel;
  final bool defaultValue;
  final String type = 'Bool';
  final bool proFeature;


  SettingsModelBool({this.label, this.tooltip, this.icon, this.falseLabel, this.trueLabel, this.defaultValue, this.value, this.proFeature});

  void randomise(Random rnd){
    if (!this.locked && (proVersion || !proVersion && !this.proFeature)) {
      this.value =  rnd.nextBool();
    }
  }
}

class SettingsModelButton {
  bool value;
  final String label;
  final String tooltip;
  final Icon icon;
  final bool defaultValue;
  final String type = 'Button';
  final bool proFeature;

  SettingsModelButton({this.label, this.tooltip, this.icon, this.defaultValue, this.value, this.proFeature});

}

class SettingsModelList {
  String value;
  List<String> options;
  bool locked = false;
  final String label;
  final String tooltip;
  final Icon icon;
  final String defaultValue;
  final String type = 'List';
  final bool proFeature;


  SettingsModelList({this.options, this.label, this.tooltip, this.icon, this.defaultValue, this.value, this.proFeature});

  void randomise(Random rnd){
    if (!this.locked && (proVersion || !proVersion && !this.proFeature)) {
      // half the time use the default
      this.value =  (rnd.nextBool() == true) ? this.options[rnd.nextInt(this.options.length)] : this.defaultValue;
    }
  }
}

class SettingsModelColor {
  Color value;
  bool locked = false;
  final String label;
  final String tooltip;
  final Icon icon;
  final Color defaultValue;
  final String type = 'Color';
  final bool proFeature;

  SettingsModelColor({this.label, this.tooltip, this.icon, this.defaultValue, this.value, this.proFeature});

  void randomise(Random rnd){
    if (!this.locked && (proVersion || !proVersion && !this.proFeature)) {
      this.value =  Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
    }
  }
}







