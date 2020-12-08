import 'package:flutter/material.dart';
import '../model_opart.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'palette_widget.dart';
import '../opart_page.dart';

class ColorPickerWidget extends StatefulWidget {
  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 80.0, bottom: 70, right: 10),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10)),
          child: ValueListenableBuilder<int>(
              valueListenable: rebuildColorPicker,
              builder: (context, value, child) {
                print(currentColor);
                return Container(
                  height: 190,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ColorPicker(
                                pickerAreaHeightPercent: 0.2,
                                displayThumbColor: true,
                                showLabel: false,
                                enableAlpha: false,
                                pickerColor: currentColor > 100
                                    ? opArt.attributes[currentColor - 100].value
                                    : opArt.palette.colorList[currentColor],
                                onColorChanged: (color) {
                                  if (currentColor > 100) {
                                    opArt.attributes[currentColor - 100].value =
                                        color;
                                  } else {
                                    opArt.palette.colorList[currentColor] =
                                        color;
                                  }
                                  rebuildTab.value++;
                                  rebuildCanvas.value++;
                                  rebuildColorPicker.value++;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            showCustomColorPicker = false;
                            opArt.saveToCache();
                            rebuildOpArtPage.value++;
                          },
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
