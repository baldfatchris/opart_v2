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

  int paletteLength = opArt.palette.colorList.length;

  Widget _numberOfColors() {
    return Row(children: [
      IconButton(
        icon: Icon(
          Icons.remove,
        ),
        onPressed: () {
          numberOfColors.value--;
          if (numberOfColors.value > paletteLength) {
            opArt.palette
                .randomize(paletteType.value.toString(), numberOfColors.value);
          }
          rebuildPalette.value++;
          rebuildCanvas.value++;
        },
      ),
      Text('Number of colors'),
      IconButton(
        icon: Icon(
          Icons.add,
        ),
        onPressed: () {
          numberOfColors.value++;
          opArt.attributes
              .firstWhere((element) => element.name == 'numberOfColors')
              .value = numberOfColors.value;
          if (numberOfColors.value > paletteLength) {
            String paletteType = opArt.attributes
                .firstWhere((element) => element.name == 'paletteType')
                .value
                .toString();
            opArt.palette.randomize(paletteType, numberOfColors.value);
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
                // Container(height: 150, child: ChoosePalette()),
                  Row(
                    children: [
                      Expanded(
                        child: ColorPicker(
                          displayThumbColor: true,
                          pickerAreaHeightPercent: 0.2,
                          //pickerAreaBorderRadius: BorderRadius.circular(10.0),
                          pickerColor: opArt.palette.colorList[currentColor],
                          onColorChanged: (color) {
                            opArt.palette.colorList[currentColor] = color;
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
                    height: 80,
                    child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 12,),

                        scrollDirection: Axis.vertical,
                        itemCount: numberOfColors.value,
                        reverse: false,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              currentColor = index;
                              rebuildPalette.value++;
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                color: opArt.palette.colorList[index]),
                          );
                        }),
                  ),
                 opacity.value!=null? Container(decoration: new BoxDecoration(
                   borderRadius: new BorderRadius.all(
                     Radius.circular(5),
                   ),
                   gradient: new LinearGradient(
                       colors: [
                         const Color(0xFFffffff).withOpacity(0.2),
                         const Color(0xFF303030),
                       ],
                       begin: const FractionalOffset(0.0, 0.0),
                       end: const FractionalOffset(1.0, 1.00),
                       stops: [0.0, 1.0],
                       tileMode: TileMode.clamp),
                 ),
                   child: Slider(
                      value: opacity.value,
                      min: 0.2,
                      max: 1.0,
                      onChanged: (value) {
                        opacity.value = value;
                        rebuildPalette.value++;
                      },
                    ),
                 ): Container(),
                  _numberOfColors(),
                ],
              ));
            });
      }).then((value) {
    opArt.saveToCache();
  });
}
