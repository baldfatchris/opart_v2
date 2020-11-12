import 'package:flutter/material.dart';

import 'model_opart.dart';
import 'setting_button.dart';
import 'setting_colorpicker.dart';
import 'setting_dropdown.dart';
import 'tabs/setting_intslider.dart';
import 'setting_radiobutton.dart';
import 'setting_slider.dart';
import 'model_settings.dart';

void settingsDialog(context, SettingsModel attribute, OpArt opArt ) {



  showDialog(
    //  backgroundColor: Colors.white.withOpacity(0.8),
      barrierColor: Colors.white.withOpacity(0.1),
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
            builder: (BuildContext context, setLocalState) {

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: AlertDialog(
                    backgroundColor: Colors.white.withOpacity(0.7),
                    title: Text(attribute.label),
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
                        (attribute.settingType == SettingType.double )
                            ? settingsSlider(
                          attribute.label,
                          attribute.tooltip,
                          attribute.value,
                          attribute.min,
                          attribute.max,
                          attribute.locked,
                          attribute.zoom,
                              (value) {

                                attribute.value = value;
                           rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                              (value) {

                                attribute.locked = value;
                              rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                              () {

                          },
                        )
                            : (attribute.settingType == SettingType.int)
                            ? settingsIntSlider(
                          attribute.label,
                          attribute.tooltip,
                          attribute.value,
                          attribute.min,
                          attribute.max,
                          attribute.locked,
                              (value) {

                                attribute.value = value.toInt();
                                if (attribute.onChange != null) {
                                  attribute.onChange();
                                }
                                rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                              (value) {

                                attribute.locked = value;
                              rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                              () {

                          },
                        )
                            : (attribute.settingType == SettingType.list)
                            ? settingsDropdown(
                          attribute.label,
                          attribute.tooltip,
                          attribute.value,
                          attribute.options,
                          attribute.locked,
                              (value) {attribute.value = value;
                              if (attribute.onChange != null) {
                                attribute.onChange();
                                print('onchange');
                              }
                              rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                              (value) {

                                attribute.locked =
                              !attribute.locked;
                              rebuildCanvas.value++;
                          },
                          attribute,
                        )
                            : (attribute.settingType == SettingType.color)
                            ? settingsColorPicker(
                          attribute.label,
                          attribute.tooltip,
                          attribute.value,
                          attribute.locked,
                              (value) {

                                attribute.value = value;
                              rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                              (value) {

                                attribute.locked =
                                  value;
                              rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                        )
                            : (attribute.settingType == SettingType.bool)
                            ? settingsRadioButton(
                          attribute.label,
                          attribute.tooltip,
                          attribute.value,
                          attribute.locked,
                              (value) {

                                attribute.value =
                                  value;
                              rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                              (value) {

                                attribute.locked =
                                  value;
                              rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                        )
                            : settingsButton(
                          attribute.label,
                          attribute.tooltip,
                          attribute.value,
                              () {
                                attribute.onChange();
                                attribute.value = true;
                            rebuildCanvas.value++;
                            setLocalState(() {});
                          },
                        ),
                      ],
                    ),
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