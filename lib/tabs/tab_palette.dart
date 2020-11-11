import 'package:flutter/material.dart';
import 'package:opart_v2/opart_page.dart';
import '../model_opart.dart';
import '../model_palette.dart';

int currentColor = 0;


Widget PaletteTab(context){
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
              rebuildPalette.value++;
            },
          ),
        ),
      );
    }

    Widget _randomizeButton() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          child: IconButton(
              color: Colors.black,
              icon: Icon(Icons.refresh),
              onPressed: () {
                opArt.randomizePalette();
                rebuildPalette.value++;
                rebuildCanvas.value++;
                opArt.saveToCache();
              }),
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
                  .randomize(
                  paletteType.value.toString(), numberOfColors.value);
            }
            rebuildPalette.value++;
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

            rebuildPalette.value++;
            rebuildCanvas.value++;
          },
        ),
      ]);
    }

    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Colors.white.withOpacity(0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
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
                        if (height > MediaQuery
                            .of(context)
                            .size
                            .height * 0.7) {
                          height = MediaQuery
                              .of(context)
                              .size
                              .height * 0.7;
                        }
                        rebuildPalette.value++;
                        rebuildCanvas.value++;
                      }
                    }),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 3 * 55 - 150,
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
                                color: opArt.palette.colorList[index],
                                shape: BoxShape.circle),
                            height: 30,
                            width: 30,
                          ),
                        );
                      }),
                ),
                IconButton(
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
                      if (height > MediaQuery
                          .of(context)
                          .size
                          .height * 0.7) {
                        height = MediaQuery
                            .of(context)
                            .size
                            .height * 0.7;
                      }
                      rebuildPalette.value++;
                      rebuildCanvas.value++;
                    }),
                _opacityWidget(),
              ],
            ),
          ],
        ));
  }


