import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:opart_v2/opart_page.dart';
import 'main.dart';

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
    if (!locked && (proVersion || !proVersion && !proFeature)) {
      // print('Name: ${name}: ${settingType}');

      switch (settingType) {
        case SettingType.double:
        // print(settingType);
        // print(value);
          double min = (randomMin != null) ? randomMin : this.min;
          double max = (randomMax != null) ? randomMax : this.max;

          // half the time use the default
          value = (rnd.nextBool() == true)
              ? rnd.nextDouble() * (max - min) + min
              : defaultValue;

          break;

        case SettingType.int:
          int min = (randomMin != null)
              ? randomMin.toInt()
              : this.min.toInt();
          int max = (randomMax != null)
              ? randomMax.toInt()
              : this.max.toInt();

          // half the time use the default
          value = (rnd.nextBool() == true)
              ? rnd.nextInt(max - min) + min
              : defaultValue;

          break;

        case SettingType.bool:
          value = (randomTrue != null)
              ? (rnd.nextDouble()<randomTrue)
                ? true
                : false
              : rnd.nextBool();

          break;

        case SettingType.color:
          value =
              Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);

          break;

        case SettingType.button:
          value = false;

          break;
        case SettingType.list:
          value = (rnd.nextBool() == true)
              ? options[rnd.nextInt(options.length)]
              : defaultValue;
      }
    }
  }


  void setDefault() {
    value = defaultValue;
    locked = false;
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
