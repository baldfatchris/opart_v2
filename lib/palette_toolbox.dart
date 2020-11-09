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
    List<SettingsModel> tools = opArt.attributes.where((element) => element.settingCategory==SettingCategory.palette).toList();

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 500
                    ? 4
                    : MediaQuery.of(context).size.width < 600
                    ? 5
                    : MediaQuery.of(context).size.width < 700
                    ? 6
                    : MediaQuery.of(context).size.width < 800
                    ? 7
                    : 8,
                childAspectRatio: 1.3),
            itemCount: tools.length,
            itemBuilder: (BuildContext context, int index) {
              return (tools[index].proFeature && !proVersion)
                  ?Stack(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        settingsDialog(context, opArt.attributes[index], opArt);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          tools[index].icon,
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                                height: 40,
                                child: Text(
                                  tools[index].name,
                                  textAlign: TextAlign.center,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),Container(color: Colors.white.withOpacity(0.5)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(alignment: Alignment.topRight,child:(Icon(Icons.lock, color: Colors.cyan[200].withOpacity(0.8)))),
                  )
                ],
              )

                  :GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  if (tools[index].silent != null && tools[index].silent){
                    print('silent');
                    tools[index].onChange();
                    opArt.saveToCache();
                    rebuildCanvas.value++;
                  }
                  else {
                    settingsDialog(context, tools[index], opArt);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tools[index].icon,
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                          height: 40,
                          child: Text(
                            tools[index].label,
                            textAlign: TextAlign.center,
                          )),
                    )
                  ],
                ),
              );
            }),

        Row(children: [
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
        ]),
      ],
    );
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
                          enableAlpha: false,
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
