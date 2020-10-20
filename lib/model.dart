import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

class SettingsModelDouble {
  double value;
  bool locked = false;
  final String label;
  final String tooltip;
  final Icon icon;
  final double min;
  final double max;
  final double defaultValue;
  final String type = 'Double';

  SettingsModelDouble({this.label, this.tooltip, this.icon, this.min, this.max, this.defaultValue, this.value});

  void randomise(Random rnd){
    if (this.locked == false) {
      this.value =  rnd.nextDouble() * (this.max - this.min) + this.min;
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
  final int defaultValue;
  final String type = 'Int';

  SettingsModelInt({this.label, this.tooltip, this.icon, this.min, this.max, this.defaultValue, this.value});

  void randomise(Random rnd){
    if (this.locked == false) {
      this.value =  rnd.nextInt(this.max - this.min) + this.min;
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


  SettingsModelBool({this.label, this.tooltip, this.icon, this.falseLabel, this.trueLabel, this.defaultValue, this.value});

  void randomise(Random rnd){
    if (this.locked == false) {
      this.value =  rnd.nextBool();
    }
  }
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


  SettingsModelList({this.options, this.label, this.tooltip, this.icon, this.defaultValue, this.value});

  void randomise(Random rnd){
    if (this.locked == false) {
      this.value =  this.options[rnd.nextInt(this.options.length)];
    }
  }
}

class SettingsModelColour {
  Color value;
  bool locked = false;
  final String label;
  final String tooltip;
  final Icon icon;
  final Color defaultValue;
  final String type = 'Colour';

  SettingsModelColour({this.label, this.tooltip, this.icon, this.defaultValue, this.value});

  void randomise(Random rnd){
    if (this.locked == false) {
      this.value =  Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
    }
  }
}






