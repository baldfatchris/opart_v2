import 'package:flutter/material.dart';
import 'settings_dialog.dart';
import 'model_opart.dart';
import 'model_palette.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'model_settings.dart';

import 'choose_palette.dart';

void paletteToolBox(
  BuildContext context,
  OpArt opArt,
) {
  int currentColor = 0;

  OpArtPalette palette = opArt.palette;
  Widget _numberOfColors() {

    int numberOfColours = opArt.attributes.firstWhere((element) => element.name == 'numberOfColors').value.toInt();


    return Row(children: [
      IconButton(
        icon: Icon(
          Icons.remove,
        ),
        onPressed: (numberOfColours==1) ? null : () {
          int numberOfColours = opArt.attributes.firstWhere((element) => element.name == 'numberOfColors').value.toInt();
          int paletteLength = opArt.palette.colorList.length;
          numberOfColours--;
          opArt.attributes.firstWhere((element) => element.name == 'numberOfColors').value = numberOfColours;
          if ( numberOfColours > paletteLength) {
            String paletteType = opArt.attributes.firstWhere((element) => element.name == 'paletteType').value.toString();
            opArt.palette.randomize(paletteType, numberOfColours);

          }
          rebuildPalette.value++;
          rebuildCanvas.value++;
        },
      ),
      Text('Number of colors ($numberOfColours)'),
      IconButton(
        icon: Icon(
          Icons.add,
        ),
        onPressed: (numberOfColours==36) ? null : () {
          int numberOfColours = opArt.attributes.firstWhere((element) => element.name == 'numberOfColors').value.toInt();
          int paletteLength = opArt.palette.colorList.length;
          numberOfColours++;
          opArt.attributes.firstWhere((element) => element.name == 'numberOfColors').value = numberOfColours;
          if ( numberOfColours > paletteLength) {
            String paletteType = opArt.attributes.firstWhere((element) => element.name == 'paletteType').value.toString();
            opArt.palette.randomize(paletteType, numberOfColours);

          }
          rebuildPalette.value++;
          rebuildCanvas.value++;
        },
      ),
    ]);
  }

  showModalBottomSheet(
      backgroundColor: Colors.white.withOpacity(0.8),
      context: context,
      builder: (BuildContext bc) {
        return ValueListenableBuilder<int>(
            valueListenable: rebuildPalette,
            builder: (context, value, child) {
              return Container(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   //Container(height: 100, child: ChoosePalette()),
                  Row(
                    children: [
                      Expanded(
                        child: ColorPicker(
                          displayThumbColor: true,
                          pickerAreaHeightPercent: 0.2,
                          //pickerAreaBorderRadius: BorderRadius.circular(10.0),
                          pickerColor: palette.colorList[currentColor],
                          onColorChanged: (color) {
                            palette.colorList[currentColor] = color;
                            rebuildCanvas.value++;
                            rebuildPalette.value++;
                          },
                          showLabel: false,
                        ),
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                              child: Icon(Icons.refresh),
                              onPressed: () {
                                opArt.randomizePalette();
                                rebuildPalette.value++;
                                rebuildCanvas.value++;
                                opArt.saveToCache();
                              }),
                        ],
                      )
                    ],
                  ),
                  Container(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: opArt.attributes.firstWhere((element) => element.name == 'numberOfColors').value.toInt(),
                        reverse: false,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              currentColor = index;
                              rebuildPalette.value++;
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                color: palette.colorList[index]),
                          );
                        }),
                  ),
                  _numberOfColors(),
                ],
              ));
            });
      }).then((value) {
    opArt.saveToCache();
  });
}
