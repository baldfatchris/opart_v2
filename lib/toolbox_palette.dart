import 'package:flutter/material.dart';
import 'settings_dialog.dart';
import 'model_opart.dart';
import 'model_settings.dart';

void PaletteToolBox(
  BuildContext context,
  OpArt opArt,
) {

  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        List<SettingsModel> tools = opArt.attributes
            .where((element) => element.settingCategory == SettingCategory.palette)
            .toList();

        return Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      childAspectRatio: 1.3),
                  itemCount: tools.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (tools[index].proFeature && !proVersion)
                        ? Stack(
                            children: [
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    settingsDialog(
                                        context, tools[index], opArt);
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              ),
                              Container(color: Colors.white.withOpacity(0.5)),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: (Icon(Icons.lock,
                                        color: Colors.cyan[200]
                                            .withOpacity(0.8)))),
                              )
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              if (tools[index].silent != null &&
                                  tools[index].silent) {
                                print('silent');
                                tools[index].onChange();
                                opArt.saveToCache();
                                rebuildCanvas.value++;
                              } else {
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
            ));
      });
}
