import 'package:flutter/material.dart';
import 'package:opart_v2/model_settings.dart';
import 'package:opart_v2/opart_page.dart';
import 'package:opart_v2/tabs/tab_widget.dart';
import '../model_opart.dart';
import '../model_palette.dart';

int currentColor = 0;

Widget PaletteTab(context) {
List<Widget> listViewWidgets = List();
  int lengthOfAdditionalColors = 0;
  List<Widget> additionalColors = [];
  void _additionalColors() {
    for (int i = 0; i < opArt.attributes.length; i++) {

      if (opArt.attributes[i].settingType == SettingType.color) {

        if(opArt.attributes[i].name =='lineColor' && opArt.attributes.firstWhere((element) => element.name =='lineWidth').value ==0){
          print('should leave out');
        }
        else{
        listViewWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: GestureDetector(
            onTap: () {
              currentColor = i + 100;
              showCustomColorPicker = true;
              rebuildColorPicker.value++;
              rebuildOpArtPage.value++;
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: i == currentColor && showCustomColorPicker
                          ? 2
                          : 0),
                  color: opArt.attributes[i].value,
                  shape: BoxShape.circle),
              height: 30,
              width: 30,
            ),
          ),
        ));
        lengthOfAdditionalColors++;
      }}
    }
  }

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
          value: (opacity.value == null)
              ? 1
              : (opacity.value < 0 || opacity.value > 1)
                  ? 1
                  : opacity.value,
          min: 0.2,
          max: 1.0,
          onChanged: (value) {
            opacity.value = value;
            rebuildTab.value++;
            rebuildCanvas.value++;
          },
          onChangeEnd: (value) {
            opArt.saveToCache();
          },
        ),
      ),
    );
  }

  int paletteLength = opArt.palette.colorList.length;

  return ValueListenableBuilder<int>(
      valueListenable: rebuildTab,
      builder: (context, value, child) {
        _additionalColors();
        listViewWidgets.add(Container(
          height: 30,
          child: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (enableButton) {
                  enableButton = false;

                  if (numberOfColors.value > 1) {
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
                    opArt.saveToCache();
                    rebuildTab.value++;
                    rebuildCanvas.value++;
                  }
                }
              }),
        ),);
        listViewWidgets.add( Container(width: 30,
          child: Center(
            child: Text(
              numberOfColors.value.toString(),
            ),
          ),
        ),);

        listViewWidgets.add(Container(
          height: 30,
          child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                if (enableButton) {
                  enableButton = false;

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
                  opArt.saveToCache();
                  rebuildTab.value++;
                  rebuildCanvas.value++;
                }
              }),
        ),);

        for (int i =0; i< numberOfColors.value; i++){
          listViewWidgets.add(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () {
                    currentColor = i;
                    showCustomColorPicker = true;
                    rebuildColorPicker.value++;
                    rebuildOpArtPage.value++;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: i == currentColor &&
                                showCustomColorPicker
                                ? 2
                                : 0),
                        color: opArt.palette.colorList[i],
                        shape: BoxShape.circle),
                    height: 30,
                    width: 30,
                  ),
                ),
              )

          );
        }
        listViewWidgets.add(_opacityWidget());
        return Container(
            height: MediaQuery.of(context).size.height - 60-60-70,
            child: ListView(
              children: listViewWidgets
            ));
      });
}
