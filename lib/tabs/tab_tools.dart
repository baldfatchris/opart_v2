import 'package:flutter/material.dart';
import '../model_opart.dart';
import '../model_settings.dart';
import '../opart_page.dart';
import '../settings_dialog.dart';
import 'package:opart_v2/opart_page.dart';
import 'tab_widget.dart';

int slider = 100;

Widget ToolBoxTab() {
  List<SettingsModel> tools = opArt.attributes
      .where((element) => element.settingCategory == SettingCategory.tool)
      .toList();

  void animateToShowSlider() {
    toolsAnimation = Tween<double>(begin: 0, end: -120).animate(toolsAnimationController)
      ..addListener(() {
        rebuildTab.value++;
      });
    toolsAnimationController.forward(from: 80);
  }

  void animateToHideSlider() {
    toolsAnimation = Tween<double>(begin: -120, end: -80).animate(toolsAnimationController)
      ..addListener(() {
        rebuildTab.value++;
      });
    slider = 100;
    toolsAnimationController.forward(from: 0);
  }

  return StatefulBuilder(builder: (context, setState) {
    Widget sliderWidget(int slider) {
      if (slider == 100) {
        return Container(color: Colors.orange);
      } else {
        SettingsModel attribute = tools[slider];
        return RotatedBox(
          quarterTurns: 1,
          child: Container(
            height: 40,
            child: attribute.settingType == SettingType.double
                ? Slider(
                    activeColor: Colors.cyan,
                    value: attribute.value,
                    min: attribute.min,
                    max: attribute.max,
                    onChanged: (value) {
                      setState(() {
                        attribute.value = value;
                        rebuildTab.value++;
                        rebuildCanvas.value++;
                      });
                    },
                    onChangeEnd: (value) {
                      opArt.saveToCache();
                    },
                  )
                : Slider(
                    activeColor: Colors.cyan,
                    onChangeEnd: (value) {
                      opArt.saveToCache();
                    },
                    value: attribute.value.toDouble(),
                    min: attribute.min.toDouble(),
                    max: attribute.max.toDouble(),
                    divisions: attribute.max - attribute.min,
                  ),
          ),
        );
      }
    }

    return Row(
      children: [
        Container(
            width: 80,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: ListView.builder(
                  itemCount: tools.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: (tools[index].settingType !=
                                          SettingType.bool)
                                      ? Colors.grey[100] // if it's not a bool
                                      : (tools[index].value == true)
                                          ? Colors.grey[
                                              400] // if it is bool and == true
                                          : Colors.white,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: index==slider? Colors.black:Colors.cyan, width: 4)),
                              child: IconButton(
                                  icon: tools[index].icon,
                                  color: index==slider? Colors.black:Colors.cyan,
                                  onPressed: () {
                                    setState(() {
                                      if(tools[index].settingType !=
                                          SettingType.double &&
                                          tools[index].settingType !=
                                              SettingType.int){animateToHideSlider();}
                                      if (tools[index].silent != null &&
                                          tools[index].silent) {


                                        print('silent');

                                        if (tools[index].settingType ==
                                            SettingType.bool) {
                                          tools[index].value =
                                              !tools[index].value;
                                        }

                                        if (tools[index].onChange != null) {
                                          tools[index].onChange();
                                        }

                                        opArt.saveToCache();
                                        rebuildCanvas.value++;
                                      } else if (tools[index].settingType ==
                                              SettingType.double ||
                                          tools[index].settingType ==
                                              SettingType.int) {
                                        animateToShowSlider();
                                        slider = index;
                                      } else {
                                        settingsDialog(
                                            context, tools[index], opArt);
                                      }
                                    });
                                  }),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(tools[index].label, textAlign: TextAlign.center)
                      ],
                    );
                  }),
            )),
        sliderWidget(slider)
      ],
    );
  });
}
