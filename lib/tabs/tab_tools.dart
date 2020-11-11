import 'package:flutter/material.dart';
import '../model_opart.dart';
import '../model_settings.dart';
import '../opart_page.dart';
import '../settings_dialog.dart';


Widget ToolBoxTab(

    ) {

  List<SettingsModel> tools = opArt.attributes
      .where((element) => element.settingCategory == SettingCategory.tool)
      .toList();
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
                height: 200,
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
                                      border: Border.all(color: Colors.black)),
                                  child: IconButton(
                                      icon: tools[index].icon,
                                      onPressed: () {
                                        setState(() {
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
                                          } else {
                                            Navigator.pop(context);
                                            settingsDialog(
                                                context, tools[index], opArt);
                                          }});
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(tools[index].label,
                                textAlign: TextAlign.center)
                          ],
                        );

                        // (tools[index].proFeature && !proVersion)
                        //   ? Stack(
                        //       children: [
                        //         Center(
                        //           child: GestureDetector(
                        //             onTap: () {
                        //               Navigator.pop(context);
                        //               settingsDialog(
                        //                   context, tools[index], opArt);
                        //             },
                        //             child: Column(
                        //               mainAxisSize: MainAxisSize.min,
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.center,
                        //               mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 tools[index].icon,
                        //                 Padding(
                        //                   padding: const EdgeInsets.all(4.0),
                        //                   child: Container(
                        //                       height: 40,
                        //                       child: Text(
                        //                         tools[index].name,
                        //                         textAlign: TextAlign.center,
                        //                       )),
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Container(color: Colors.white.withOpacity(0.5)),
                        //         Padding(
                        //           padding: const EdgeInsets.only(top: 8.0),
                        //           child: Align(
                        //               alignment: Alignment.topRight,
                        //               child: (Icon(Icons.lock,
                        //                   color: Colors.cyan[200]
                        //                       .withOpacity(0.8)))),
                        //         )
                        //       ],
                        //     )
                        //   :

                        // GestureDetector(
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //         if (tools[index].silent != null &&
                        //             tools[index].silent) {
                        //           print('silent');
                        //           tools[index].onChange();
                        //           opArt.saveToCache();
                        //           rebuildCanvas.value++;
                        //         } else {
                        //           settingsDialog(context, tools[index], opArt);
                        //         }
                        //       },
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           tools[index].icon,
                        //           Padding(
                        //             padding: const EdgeInsets.all(1.0),
                        //             child: Container(
                        //                 height: 40,
                        //                 child: Text(
                        //                   tools[index].label,
                        //                   textAlign: TextAlign.center,
                        //                 )),
                        //           )
                        //         ],
                        //       ),
                        //     );
                        //
                      }),
                )),
          );
        });

}
