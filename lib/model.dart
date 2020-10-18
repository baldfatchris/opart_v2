import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

class SettingsModelDouble {
  double value;
  bool locked = false;
  String label;
  String tooltip;
  Icon icon;
  double min;
  double max;
  double defaultValue;

  SettingsModelDouble({this.value, this.locked, this.label, this.tooltip,
      this.icon, this.min, this.max, this.defaultValue});

  void randomise(Random rnd){
    if (this.locked) {
      this.value =  rnd.nextDouble() * (this.max - this.min) + this.min;
    }
  }
}





