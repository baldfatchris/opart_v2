import 'package:flutter/material.dart';
import 'model_opart.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'palette_tab.dart';
import 'opart_page.dart';
class ColorPickerWidget extends StatefulWidget {
  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
   return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:80.0,vertical: 10 ),
        child: Container(
            decoration: BoxDecoration(color:
            Colors.white.withOpacity(0.8),borderRadius: BorderRadius.circular(10)),

           child:  ValueListenableBuilder<int>(
                  valueListenable: rebuildColorPicker,
                  builder: (context, value, child) {
                    return Column(mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ColorPicker(
                            pickerAreaHeightPercent:
                            0.2,
                            displayThumbColor:
                            true,
                            showLabel: false,
                            enableAlpha: false,
                            pickerColor: opArt
                                .palette
                                .colorList[
                            currentColor],
                            onColorChanged:
                                (color) {
                              opArt.palette
                                  .colorList[
                              currentColor] = color;
                              rebuildPalette
                                  .value++;
                              rebuildCanvas
                                  .value++;
                              rebuildColorPicker.value++;
                            },
                          ),
                        ),
                      ],
                    );
                  })),
      );

    }

}
