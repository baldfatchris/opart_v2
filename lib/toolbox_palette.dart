import 'package:flutter/material.dart';
import 'package:opart_v2/setting_radiobutton.dart';
import 'model_palette.dart';
import 'settings_dialog.dart';
import 'model_opart.dart';
import 'model_settings.dart';
import 'bottom_sheet_palette.dart';
import 'bottom_sheet_choose_palette.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void PaletteToolBox(
  BuildContext context,
  OpArt opArt,
) {
  List<Color> _colorList = [
    Color(0xFF34a1af),
    Color(0xFFa570a8),
    Color(0xFFd6aa27),
    Color(0xFF5f9d50),
    Color(0xFF789dd1),
    Color(0xFFc25666),
    Color(0xFF2b7b1),
    Color(0xFFd63aa),
    Color(0xFF1f4ed),
    Color(0xFF383c47)
  ];

  randomColors.value = false;
  List<Map<String, dynamic>> toolboxObjects = [
    {
      'name': 'Random',
      'icon': MdiIcons.shuffleVariant,
      'onTapped': () {
        opArt.randomizePalette();
        opArt.saveToCache();
      },
    },
    {
      'name': 'Linear',
      'icon': MdiIcons.shuffleVariant,
      'onTapped': () {
        if(enableButton) {
          enableButton = false;
          for (int i = 0; i < opArt.attributes.length; i++) {
            if (opArt.attributes[i].settingCategory ==
                SettingCategory.palette) {
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
        }}
    },
    {
      'name': 'Complementary',
      'icon': MdiIcons.shuffleVariant,
      'onTapped': () {
        for (int i = 0; i < opArt.attributes.length; i++) {
          if (opArt.attributes[i].settingCategory == SettingCategory.palette) {
            opArt.attributes[i].randomize(rnd);
          }
        }

        opArt.palette.randomize(
          'linear complementary',
          opArt.attributes
              .firstWhere((element) => element.name == 'numberOfColors')
              .value
              .toInt(),
        );

      }
    },
    {
      'name': 'Blended',
      'icon': MdiIcons.shuffleVariant,
      'onTapped': () {
        for (int i = 0; i < opArt.attributes.length; i++) {
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
        opArt.saveToCache();
      }
    },
    {
      'name': 'Order',
      'icon': Icons.shuffle,
      'onTapped': () {
        randomColors.value !=randomColors.value;
                                 rebuildPalette.value++;
                                 rebuildCanvas.value++;
      },
    },
    {
      'name': 'Fine Tune ',
      'icon': Icons.tune,
      'onTapped': () {
        Navigator.pop(context);
        BottomSheetPalette(context);
      }
    },
    {
      'name': 'Choose',
      'icon': Icons.portrait_outlined,
      'onTapped': () {
        Navigator.pop(context);
        BottomSheetChoosePalette(context);
      }
    },
  ];
  showModalBottomSheet(
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.3),
                    itemCount: toolboxObjects.length,
                    itemBuilder: (BuildContext context, int index) {
                      Color color =
                          Color(int.parse(defaultPalettes[0][3][index]));

                      return Column(
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(int.parse(defaultPalettes[0][3][index])),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    toolboxObjects[index]['onTapped']();
                                  },
                                  icon: Icon(toolboxObjects[index]['icon'])),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(toolboxObjects[index]['name'])
                        ],
                      );
                    }),
              )),
        );
      });
}
