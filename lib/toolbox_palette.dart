import 'package:flutter/material.dart';
import 'settings_dialog.dart';
import 'model_opart.dart';
import 'model_settings.dart';
import 'bottom_sheet_choose_palette.dart';

void PaletteToolBox(
  BuildContext context,
  OpArt opArt,
) {
  List<Map<String, dynamic>> toolboxObjects = [
    {
      'name': 'Randomize Colors',
      'icon': Icons.shuffle,
      'onTapped': () {
        opArt.randomizePalette();
        opArt.saveToCache();
      },
    },
    {
      'name': 'Linear Random',
      'icon': Icons.shuffle,
      'onTapped': () {
        for (int i = 0; i < opArt.attributes.length; i++) {
          if (opArt.attributes[i].settingCategory == SettingCategory.palette) {
            opArt.attributes[i].randomize(rnd);
          }
        }

        opArt.palette.randomize(
          'linear random',
          opArt.attributes
              .firstWhere((element) => element.name == 'numberOfColors')
              .value
              .toInt(),
        );

        rebuildCanvas.value++;
        opArt.saveToCache();
      }
    },
    {
      'name': 'Linear Complementary',
      'icon': Icons.shuffle,
      'onTapped': () {        for (int i = 0; i < opArt.attributes.length; i++) {
        if (opArt.attributes[i].settingCategory == SettingCategory.palette) {
          opArt.attributes[i].randomize(rnd);
          opArt.saveToCache();
        }
      }

      opArt.palette.randomize(
        'linear complementary',
        opArt.attributes
            .firstWhere((element) => element.name == 'numberOfColors')
            .value
            .toInt(),
      );

      rebuildCanvas.value++;
      opArt.saveToCache();}
    },
    {
      'name': 'Blended Random',
      'icon': Icons.shuffle,
      'onTapped': () {        for (int i = 0; i < opArt.attributes.length; i++) {
        if (opArt.attributes[i].settingCategory == SettingCategory.palette) {
          opArt.attributes[i].randomize(rnd);
        }
      }

      opArt.palette.randomize(
        'blended random',
        opArt.attributes
            .firstWhere((element) => element.name == 'numberOfColors')
            .value
            .toInt(),
      );

      rebuildCanvas.value++;
      opArt.saveToCache();}
    },
    {
      'name': 'Put colours in random Order',
      'icon': Icons.shuffle,
      'onTapped': () {}
    },
    {'name': 'Fine Tune Palette', 'icon': Icons.tune, 'onTapped': () {}},
    {
      'name': 'Choose Palette',
      'icon': Icons.portrait_outlined,
      'onTapped': () {
        Navigator.pop(context);
        BottomSheetChoosePalette(context);
      }
    },
  ];
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: GridView.builder(
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
                      childAspectRatio: 1),
                  itemCount: toolboxObjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          toolboxObjects[index]['onTapped']();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              toolboxObjects[index]['icon'],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                  child: Text(
                                toolboxObjects[index]['name'],
                                textAlign: TextAlign.center,
                              )),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ));
      });
}
