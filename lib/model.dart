import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

class SettingsModelDouble {
  double value;
  bool locked;
  final String label;
  final String tooltip;
  final Icon icon;
  final double min;
  final double max;
  final double defaultValue;

  SettingsModelDouble({this.label, this.tooltip, this.icon, this.min, this.max, this.defaultValue, this.value, this.locked = false});



  void randomise(Random rnd){
    if (this.locked == false) {
      this.value =  rnd.nextDouble() * (this.max - this.min) + this.min;
    }
  }
}





