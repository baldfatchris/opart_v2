import 'dart:core';

import 'package:flutter/material.dart';

class SettingsModel{
  String name;
  enum Type {
  doubleSlider,
  intSlider,
  boolean,
  dropDownList

};
  Type type;
String label;
  String tooltip;
  Icon icon;
  double min;
  double max;
  var defaultValue;
  SettingsModel(this.name, this.type, this.label, this.tooltip,
this.icon, this.min, this.max, this.defaultValue)
}