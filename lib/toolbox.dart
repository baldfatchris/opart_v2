import 'package:flutter/material.dart';
import 'settings_dialog.dart';
import 'model.dart';
import 'opart_fibonacci.dart';

void ToolBox(BuildContext context, int opArtNumber, Function cache) {
  print(MediaQuery.of(context).size.width);
  List settingsList;
  switch(opArtNumber){
    case 0: settingsList = fibonacciSettingsList;
  }

  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
            height: 350,
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
                  itemCount: settingsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (settingsList[index].proFeature|| proVersion)?
                    Stack(
                      children: [
                        Center(
                          child: GestureDetector(
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
                          ),
                        ),Container(color: Colors.white.withOpacity(0.5)),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(alignment: Alignment.topRight,child:(Icon(Icons.lock, color: Colors.cyan[200].withOpacity(0.8)))),
                        )
                      ],
                    )

                    :GestureDetector(
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
