import 'package:flutter/material.dart';
import 'package:opart_v2/opart_page.dart';
import '../model_opart.dart';
import '../model_palette.dart';

int currentColor = 0;

Widget PaletteTab(context) {
  double height = MediaQuery.of(context).size.height;
  Widget _opacityWidget() {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        height: 40,
        width: 150,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(
            Radius.circular(5),
          ),
          gradient: new LinearGradient(
              colors: [
                const Color(0xFFffffff).withOpacity(0.2),
                const Color(0xFF303030),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.00),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Slider(
          value: opacity.value,
          min: 0.2,
          max: 1.0,
          onChanged: (value) {
            opacity.value = value;
            rebuildTab.value++;
            rebuildCanvas.value++;
          },
        ),
      ),
    );
  }

  int paletteLength = opArt.palette.colorList.length;

  Widget _numberOfColors() {
    return Row(children: [
      IconButton(
        icon: Icon(
          Icons.remove,
        ),
        onPressed: () {
          numberOfColors.value--;
          if (numberOfColors.value > paletteLength) {
            opArt.palette
                .randomize(paletteType.value.toString(), numberOfColors.value);
          }
          rebuildTab.value++;
          rebuildCanvas.value++;
        },
      ),
      Text('Number of colors'),
      IconButton(
        icon: Icon(
          Icons.add,
        ),
        onPressed: () {
          numberOfColors.value++;
          opArt.attributes
              .firstWhere((element) => element.name == 'numberOfColors')
              .value = numberOfColors.value;
          if (numberOfColors.value > paletteLength) {
            String paletteType = opArt.attributes
                .firstWhere((element) => element.name == 'paletteType')
                .value
                .toString();
            opArt.palette.randomize(paletteType, numberOfColors.value);
          }

          rebuildTab.value++;
          rebuildCanvas.value++;
        },
      ),
    ]);
  }

  return ValueListenableBuilder<int>(
      valueListenable: rebuildTab,
      builder: (context, value, child) {
        return Container(
            height: MediaQuery.of(context).size.height,

            child: Column(
             // mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(height: 30,
                      child: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (numberOfColors.value > 2) {
                              numberOfColors.value--;
                              if (numberOfColors.value > paletteLength) {
                                opArt.palette.randomize(
                                    paletteType.value.toString(),
                                    numberOfColors.value);
                              }
                              height = (numberOfColors.value.toDouble() + 2) * 30;
                              if (height >
                                  MediaQuery.of(context).size.height * 0.7) {
                                height = MediaQuery.of(context).size.height * 0.7;
                              }
                              rebuildTab.value++;
                              rebuildCanvas.value++;
                            }
                          }),
                    ),
                    Container(height: MediaQuery.of(context).size.height - 115 - 70 - 30-30-150,
                      width: 30,
                      child: ListView.builder(
                          padding: EdgeInsets.all(2),
                          scrollDirection: Axis.vertical,
                          itemCount: numberOfColors.value,
                          reverse: false,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                currentColor = index;
                                showCustomColorPicker = true;
                                rebuildColorPicker.value++;
                                rebuildOpArtPage.value++;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: index == currentColor &&
                                                showCustomColorPicker
                                            ? 2
                                            : 0),
                                    color: opArt.palette.colorList[index],
                                    shape: BoxShape.circle),
                                height: 30,
                                width: 30,
                              ),
                            );
                          }),
                    ),
                    Container(height: 30,
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            numberOfColors.value++;
                            opArt.attributes
                                .firstWhere(
                                    (element) => element.name == 'numberOfColors')
                                .value = numberOfColors.value;
                            if (numberOfColors.value > paletteLength) {
                              String paletteType = opArt.attributes
                                  .firstWhere(
                                      (element) => element.name == 'paletteType')
                                  .value
                                  .toString();
                              opArt.palette
                                  .randomize(paletteType, numberOfColors.value);
                            }
                            height = (numberOfColors.value.toDouble() + 2) * 30;
                            if (height >
                                MediaQuery.of(context).size.height * 0.7) {
                              height = MediaQuery.of(context).size.height * 0.7;
                            }
                            rebuildTab.value++;
                            rebuildCanvas.value++;
                          }),
                    ),
                    Container(height: 150,child: _opacityWidget()),
                  ],
                ),
              ],
            ));
      });
}
