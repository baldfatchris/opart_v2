import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:opart_v2/color_picker_widget.dart';
import 'package:opart_v2/opart_page.dart';
import '../settings_dialog.dart';
import '../model_opart.dart';
import '../model_palette.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../model_settings.dart';
import 'dart:math';
import '../choose_palette.dart';

int currentColor = 0;

BottomSheetPalette(BuildContext context) {
  showSettings = false;
  rebuildOpArtPage.value++;
  double height = (numberOfColors.value.toDouble() + 2) * 30;
  bool showColorPicker = true;

  Widget _opacityWidget() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: new BoxDecoration(
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
          rebuildCanvas.value++;
        },
      ),
    );
  }

  int paletteLength = opArt.palette.colorList.length;

  showModalBottomSheet(barrierColor: Colors.white.withOpacity(0),
      backgroundColor: Colors.white.withOpacity(0.7),
      context: context,
      builder: (BuildContext bc) {
        return ValueListenableBuilder<int>(
            valueListenable: rebuildPalette,
            builder: (context, value, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  Container(height: 150,
                    child: ColorPicker(
                      pickerAreaHeightPercent: 0.2,
                      displayThumbColor: true,
                      showLabel: false,
                      enableAlpha: false,
                      pickerColor: opArt.palette.colorList[currentColor],
                      onColorChanged: (color) {
                        opArt.palette.colorList[currentColor] = color;
                        rebuildPalette.value++;
                        rebuildCanvas.value++;
                        rebuildColorPicker.value++;
                      },
                    ),
                  ),
                  _opacityWidget(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (numberOfColors.value > 2) {
                              numberOfColors.value--;
                              if (numberOfColors.value > paletteLength) {
                                opArt.palette.randomize(
                                    paletteType.value.toString(),
                                    numberOfColors.value);
                              }
                              height =
                                  (numberOfColors.value.toDouble() + 2) * 30;
                              if (height >
                                  MediaQuery.of(context).size.height * 0.7) {
                                height =
                                    MediaQuery.of(context).size.height * 0.7;
                              }
                              rebuildPalette.value++;
                              rebuildCanvas.value++;
                            }
                          }),
                      Container(
                        width: MediaQuery.of(context).size.width - 2 * 55,
                        height: 50,
                        child: ListView.builder(
                            padding: EdgeInsets.all(5),
                            scrollDirection: Axis.horizontal,
                            itemCount: numberOfColors.value,
                            reverse: false,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  currentColor = index;
                                  showCustomColorPicker = true;

                                  rebuildPalette.value++;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: opArt.palette.colorList[index],
                                      shape: BoxShape.circle),
                                  height: 50,
                                  width: 50,
                                ),
                              );
                            }),
                      ),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            numberOfColors.value++;
                            opArt.attributes
                                .firstWhere((element) =>
                                    element.name == 'numberOfColors')
                                .value = numberOfColors.value;
                            if (numberOfColors.value > paletteLength) {
                              String paletteType = opArt.attributes
                                  .firstWhere((element) =>
                                      element.name == 'paletteType')
                                  .value
                                  .toString();
                              opArt.palette
                                  .randomize(paletteType, numberOfColors.value);
                            }
                            height = (numberOfColors.value.toDouble() + 2) * 30;
                            if (height >
                                MediaQuery.of(context).size.height * 0.7) {
                              height = MediaQuery.of(context).size.height * 0.7;
                            }
                            rebuildPalette.value++;
                            rebuildCanvas.value++;
                          }),
                    ],
                  ),
                ],
              );
            });
      }).then((value){
        showSettings = true;
        rebuildOpArtPage.value++;
        opArt.saveToCache();
  });
}
