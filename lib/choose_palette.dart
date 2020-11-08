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

import 'choose_palette.dart';

class ChoosePalette extends StatefulWidget {
  @override
  _ChoosePaletteState createState() => _ChoosePaletteState();
}

class _ChoosePaletteState extends State<ChoosePalette> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 700,
        child: ListView.builder(
            itemCount: defaultPalettes.length,
            itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: (){
                      List newPalette = defaultPalettes[index][3];
                      print(newPalette[0]);
                      opArt.palette.colorList.clear();
                      for (int i = 0; i < newPalette.length; i++) {
                        opArt.palette.colorList.add(Color(int.parse(newPalette[i])));
                      }
                      numberOfColors.value = newPalette.length;
                      rebuildPalette.value++;
                      rebuildCanvas.value++;
                    },
                    child: Row(
                      children: [
                    Container(
                        width: 100, child: Text(defaultPalettes[index][0])),
                    Container(height: 30,
                      width: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: defaultPalettes[index][3].length,
                          itemBuilder: (context, _index) {
                            return Container(
                              height: 20,
                              width: 20,
                              color: Color(int.parse(defaultPalettes[index][3][_index])),
                            );
                          }),
                    )
                      ],
                    ),
                  ),
                );

            }));
  }

  void _changePalette() {

  }
}
