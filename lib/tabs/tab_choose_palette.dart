import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:opart_v2/opart_page.dart';
import 'package:opart_v2/settings_dialog.dart';

import 'package:opart_v2/model_opart.dart';
import 'package:opart_v2/model_palette.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:opart_v2/model_settings.dart';
import 'dart:math';
import 'package:opart_v2/choose_palette.dart';

int currentColor = 0;

Widget ChoosePaletteTab(){
  Animation<double> _animation;

    List<Widget> _circularPalette(int index) {
      int _sizeOfPalette = defaultPalettes[index][3].length;

      List<Widget> _list = [];
      if (_sizeOfPalette < 11) {
        for (int i = 0; i < _sizeOfPalette; i++) {
          _list.add(Transform.rotate(
              angle: i * 2 * pi / _sizeOfPalette,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.6),
                    shape: BoxShape.circle,
                    color: Color(int.parse(defaultPalettes[index][3][i])),
                  ),
                  height: 15,
                  width: 15,
                ),
              )));
        }
      } else {
        for (int i = 0; i < _sizeOfPalette; i++) {
          if (i < 10) {
            _list.add(Transform.rotate(
                angle: i * 2 * pi / 10,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.6),
                      shape: BoxShape.circle,
                      color: Color(int.parse(defaultPalettes[index][3][i])),
                    ),
                    height: 15,
                    width: 15,
                  ),
                )));
          } else {
            _list.add(Transform.rotate(
                angle: i * 2 * pi / (_sizeOfPalette - 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.6),
                        shape: BoxShape.circle,
                        color: Color(int.parse(defaultPalettes[index][3][i])),
                      ),
                      height: 15,
                      width: 15,
                    ),
                  ),
                )));
          }
        }
      }
      return _list;
    }

    return ListView.builder(
        itemCount: defaultPalettes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              List newPalette = defaultPalettes[index][3];
              opArt.palette.colorList.clear();
              for (int i = 0; i < newPalette.length; i++) {
                opArt.palette.colorList
                    .add(Color(int.parse(newPalette[i])));
              }
              numberOfColors.value = newPalette.length;
              rebuildPalette.value++;
              rebuildCanvas.value++;
            },
            child: Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Stack(
                          children: _circularPalette(index),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  defaultPalettes[index][0],
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        });

}
