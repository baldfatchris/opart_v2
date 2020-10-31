import 'package:flutter/material.dart';

import 'model_opart.dart';
import 'setting_button.dart';
import 'setting_colorpicker.dart';
import 'setting_dropdown.dart';
import 'setting_intslider.dart';
import 'setting_radiobutton.dart';
import 'setting_slider.dart';
import 'opart_fibonacci.dart';
import 'opart_wave.dart';
import 'opart_wallpaper.dart';
import 'opart_tree.dart';
import 'model_settings.dart';

void settingsDialog(context, int index, OpArt opArt ) {



  showDialog(
    //  backgroundColor: Colors.white.withOpacity(0.8),
      barrierColor: Colors.white.withOpacity(0.1),
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
            builder: (BuildContext context, setLocalState) {

              return Center(
                child: AlertDialog(
                  backgroundColor: Colors.white.withOpacity(0.7),
                  title: Text(opArt.attributes[index].label),
                  actions: [
                    RaisedButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )

                  ],
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      (opArt.attributes[index].settingType == SettingType.double )
                          ? settingsSlider(
                        opArt.attributes[index].label,
                        opArt.attributes[index].tooltip,
                        opArt.attributes[index].value,
                        opArt.attributes[index].min,
                        opArt.attributes[index].max,
                        opArt.attributes[index].locked,
                        opArt.attributes[index].zoom,
                            (value) {

                              opArt.attributes[index].value = value;
                         rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                            (value) {

                              opArt.attributes[index].locked = value;
                            rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                            () {

                        },
                      )
                          : (opArt.attributes[index].settingType == SettingType.int)
                          ? settingsIntSlider(
                        opArt.attributes[index].label,
                        opArt.attributes[index].tooltip,
                        opArt.attributes[index].value,
                        opArt.attributes[index].min,
                        opArt.attributes[index].max,
                        opArt.attributes[index].locked,
                            (value) {

                              opArt.attributes[index].value = value.toInt();
                              if (opArt.attributes[index].onChange != null) {
                                opArt.attributes[index].onChange();
                              }
                              rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                            (value) {

                              opArt.attributes[index].locked = value;
                            rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                            () {

                        },
                      )
                          : (opArt.attributes[index].settingType == SettingType.list)
                          ? settingsDropdown(
                        opArt.attributes[index].label,
                        opArt.attributes[index].tooltip,
                        opArt.attributes[index].value,
                        opArt.attributes[index].options,
                        opArt.attributes[index].locked,
                            (value) {opArt.attributes[index].value = value;
                            rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                            (value) {

                              opArt.attributes[index].locked =
                            !opArt.attributes[index].locked;
                            rebuildCanvas.value++;
                        },
                      )
                          : (opArt.attributes[index].settingType == SettingType.color)
                          ? settingsColorPicker(
                        opArt.attributes[index].label,
                        opArt.attributes[index].tooltip,
                        opArt.attributes[index].value,
                        opArt.attributes[index].locked,
                            (value) {

                              opArt.attributes[index].value = value;
                            rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                            (value) {

                              opArt.attributes[index].locked =
                                value;
                            rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                      )
                          : (opArt.attributes[index].settingType == SettingType.bool)
                          ? settingsRadioButton(
                        opArt.attributes[index].label,
                        opArt.attributes[index].tooltip,
                        opArt.attributes[index].value,
                        opArt.attributes[index].locked,
                            (value) {

                              opArt.attributes[index].value =
                                value;
                            rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                            (value) {

                              opArt.attributes[index].locked =
                                value;
                            rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                      )
                          : settingsButton(
                        opArt.attributes[index].label,
                        opArt.attributes[index].tooltip,
                        opArt.attributes[index].value,
                            () {
                              opArt.attributes[index].onChange();
                              opArt.attributes[index].value = true;
                          rebuildCanvas.value++;
                          setLocalState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
      }).then((value) {
    opArt.saveToCache();
    // print('should rebuild cache');
    rebuildCache.value++;

  });
}