import 'package:flutter/material.dart';
import 'settings_dialog.dart';
import 'opart_fibonacci.dart';

void ToolBox(BuildContext context, List settingsList, Function cache) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1.3),
                  itemCount: settingsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        settingsDialog(context, index, settingsList, cache);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          settingsList[index].icon,
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                                height: 40,
                                child: Text(
                                  settingsList[index].label,
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
