import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:opart_v2/opart_page.dart';
import 'model_opart.dart';

// bool proVersion = true;

enum SettingType {
  double,
  int,
  bool,
  button,
  color,
  list
}
enum SettingCategory {
  palette,
  tool,
  other
}

class SettingsModel {
  SettingType settingType;
  String name;
  String label;
  String tooltip;
  Icon icon;
  SettingCategory settingCategory;
  bool proFeature;
  var options;
  Function onChange;
  bool silent;

  var min;
  var max;
  var randomMin;
  var randomMax;
  double randomTrue;
  double zoom;
  var defaultValue;

  bool locked = false;
  var value;

  SettingsModel({this.settingType,
    this.name,
    this.label,
    this.tooltip,
    this.icon,
    this.settingCategory,
    this.proFeature,
    this.min,
    this.max,
    this.randomMin,
    this.randomMax,
    this.randomTrue,
    this.zoom,
    this.defaultValue,
    this.options,
    this.onChange,
    this.silent,
  });



  void randomize(Random rnd) {
    if (!this.locked && (proVersion || !proVersion && !this.proFeature)) {
      // print('Name: ${this.name}: ${this.settingType}');

      switch (this.settingType) {
        case SettingType.double:
        // print(this.settingType);
        // print(this.value);
          double min = (this.randomMin != null) ? this.randomMin : this.min;
          double max = (this.randomMax != null) ? this.randomMax : this.max;

          // half the time use the default
          this.value = (rnd.nextBool() == true)
              ? rnd.nextDouble() * (max - min) + min
              : this.defaultValue;

          break;

        case SettingType.int:
          int min = (this.randomMin != null)
              ? this.randomMin.toInt()
              : this.min.toInt();
          int max = (this.randomMax != null)
              ? this.randomMax.toInt()
              : this.max.toInt();

          // half the time use the default
          this.value = (rnd.nextBool() == true)
              ? rnd.nextInt(max - min) + min
              : this.defaultValue;

          break;

        case SettingType.bool:
          this.value = (this.randomTrue != null)
              ? (rnd.nextDouble()<this.randomTrue)
                ? true
                : false
              : rnd.nextBool();

          break;

        case SettingType.color:
          this.value =
              Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);

          break;

        case SettingType.button:
          this.value = false;

          break;
        case SettingType.list:
          this.value = (rnd.nextBool() == true)
              ? this.options[rnd.nextInt(this.options.length)]
              : this.defaultValue;
      }
    }
  }


  void setDefault() {
    this.value = this.defaultValue;
    this.locked = false;
  }
}


void resetAllDefaults(){
  opArt.setDefault();
}

void generatePalette(){
  int numberOfColours = opArt.attributes.firstWhere((element) => element.name == 'numberOfColors').value.toInt();
  String paletteType = opArt.attributes.firstWhere((element) => element.name == 'paletteType').value.toString();
  opArt.palette.randomize(paletteType, numberOfColours);

}

void checkNumberOfColors(){
  int numberOfColours = opArt.attributes.firstWhere((element) => element.name == 'numberOfColors').value.toInt();
  int paletteLength = opArt.palette.colorList.length;
  if ( numberOfColours > paletteLength) {
    String paletteType = opArt.attributes.firstWhere((element) => element.name == 'paletteType').value.toString();
    opArt.palette.randomize(paletteType, numberOfColours);
  }
}
