import 'package:flutter/material.dart';

import 'model.dart';
import 'setting_button.dart';
import 'setting_colorpicker.dart';
import 'setting_dropdown.dart';
import 'setting_intslider.dart';
import 'setting_radiobutton.dart';
import 'setting_slider.dart';

void settingsDialog(
  context,
  int index,
  settingsList,
  Function cache,
) {
  showDialog(
      //  backgroundColor: Colors.white.withOpacity(0.8),
      barrierColor: Colors.white.withOpacity(0.1),
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (BuildContext context, setLocalState) {
          return Stack(
            children: [
              Dialog(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: Container(height: MediaQuery.of(context).size.height*0.5,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(settingsList[index].label,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            (settingsList[index].type == 'Double')
                                ? settingsSlider(
                                    settingsList[index].label,
                                    settingsList[index].tooltip,
                                    settingsList[index].value,
                                    settingsList[index].min,
                                    settingsList[index].max,
                                    settingsList[index].locked,
                                    settingsList[index].zoom,
                                    (value) {
                                      settingsList[index].value = value;
                                      rebuildCanvas.value++;
                                      setLocalState(() {});
                                    },
                                    (value) {
                                      settingsList[index].locked = value;
                                      rebuildCanvas.value++;
                                      setLocalState(() {});
                                    },
                                    () {},
                                  )
                                : (settingsList[index].type == 'Int')
                                    ? settingsIntSlider(
                                        settingsList[index].label,
                                        settingsList[index].tooltip,
                                        settingsList[index].value,
                                        settingsList[index].min,
                                        settingsList[index].max,
                                        settingsList[index].locked,
                                        (value) {
                                          settingsList[index].value =
                                              value.toInt();
                                          rebuildCanvas.value++;
                                          setLocalState(() {});
                                        },
                                        (value) {
                                          settingsList[index].locked = value;
                                          rebuildCanvas.value++;
                                          setLocalState(() {});
                                        },
                                        () {},
                                      )
                                    : (settingsList[index].type == 'List')
                                        ? settingsDropdown(
                                            settingsList[index].label,
                                            settingsList[index].tooltip,
                                            settingsList[index].value,
                                            settingsList[index].options,
                                            settingsList[index].locked,
                                            (value) {
                                              settingsList[index].value = value;
                                              rebuildCanvas.value++;
                                              setLocalState(() {});
                                            },
                                            (value) {
                                              settingsList[index].locked =
                                                  !settingsList[index].locked;
                                              rebuildCanvas.value++;
                                            },
                                          )
                                        : (settingsList[index].type == 'Color')
                                            ? settingsColorPicker(
                                                settingsList[index].label,
                                                settingsList[index].tooltip,
                                                settingsList[index].value,
                                                settingsList[index].locked,
                                                (value) {
                                                  settingsList[index].value =
                                                      value;
                                                  rebuildCanvas.value++;
                                                  setLocalState(() {});
                                                },
                                                (value) {
                                                  settingsList[index].locked =
                                                      value;
                                                  rebuildCanvas.value++;
                                                  setLocalState(() {});
                                                },
                                              )
                                            : (settingsList[index].type == 'Bool')
                                                ? settingsRadioButton(
                                                    settingsList[index].label,
                                                    settingsList[index].tooltip,
                                                    settingsList[index].value,
                                                    settingsList[index].locked,
                                                    (value) {
                                                      settingsList[index].value =
                                                          value;
                                                      rebuildCanvas.value++;
                                                      setLocalState(() {});
                                                    },
                                                    (value) {
                                                      settingsList[index].locked =
                                                          value;
                                                      rebuildCanvas.value++;
                                                      setLocalState(() {});
                                                    },
                                                  )
                                                : settingsButton(
                                                    settingsList[index].label,
                                                    settingsList[index].tooltip,
                                                    settingsList[index].value,
                                                    () {
                                                      settingsList[index].value =
                                                          true;

                                                      setLocalState(() {});
                                                    },
                                                  ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(icon: Icon(Icons.close), onPressed: (){Navigator.pop(context);},))
                    ],
                  ),
                ),
              ),
            ],
          );
        });
      }).then((value) {
    cache();
    print('should rebuild cache');
    rebuildCache.value++;
  });
}
