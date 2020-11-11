import 'model_palette.dart';
import 'model_opart.dart';
import 'package:flutter/material.dart';
import 'model_settings.dart';
import 'opart_page.dart';
import 'package:flutter/material.dart';
import 'settings_dialog.dart';
import 'model_opart.dart';
import 'model_palette.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'model_settings.dart';
import 'dart:math';

import 'choose_palette.dart';

class ChoosePalette extends StatefulWidget {
  @override
  _ChoosePaletteState createState() => _ChoosePaletteState();
}

class _ChoosePaletteState extends State<ChoosePalette> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _circularPalette(int index) {
      int _sizeOfPalette = defaultPalettes[index][3].length;
      List<Widget> _list = [];
      for (int i = 0; i < _sizeOfPalette; i++) {
        _list.add(Transform.rotate(
            angle: i * 2 * pi / _sizeOfPalette,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  shape: BoxShape.circle,
                  color: Color(int.parse(defaultPalettes[index][3][i])),
                ),
                height: 20,
                width: 20,
              ),
            )));
      }
      return _list;
    }

    return Container(
        height: 700,
        child: ListView.builder(
            itemCount: defaultPalettes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 2.0),
                child: GestureDetector(
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
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 80 ,
                                height: 80,
                                child: Center(
                                  child: Text(
                                    defaultPalettes[index][0],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(
                                children: _circularPalette(index),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
