import 'package:flutter/material.dart';
import 'package:opart_v2/model_settings.dart';
import 'package:opart_v2/opart_page.dart';
import '../model_opart.dart';
import '../model_palette.dart';

int currentColor = 0;

Widget PaletteTab(context) {
int lengthOfAdditionColors = 0;
List<Widget> additionColors = [];
  for (int i = 0; i< opArt.attributes.length; i++){
   if( opArt.attributes[i].settingType ==
        SettingType.color){

     additionColors.add(Padding(
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
                   width: i == currentColor &&
                       showCustomColorPicker
                       ? 2
                       : 0),
               color: opArt.attributes[i].value,
               shape: BoxShape.circle),
           height: 30,
           width: 30,
         ),
       ),
     ));
     lengthOfAdditionColors++;
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
          min: 0.0,
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
        return Container(
            height: MediaQuery.of(context).size.height,
            child:
                Column(
                  children: [
                    SizedBox(height: 8),
                    Container(
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
                                height =
                                    (numberOfColors.value.toDouble() + 2) * 30;
                                if (height >
                                    MediaQuery.of(context).size.height * 0.7) {
                                  height =
                                      MediaQuery.of(context).size.height * 0.7;
                                }
                                opArt.saveToCache();
                                rebuildTab.value++;
                                rebuildCanvas.value++;
                              }
                            }
                          }),
                    ),
                    Text(
                      numberOfColors.value.toString(),
                    ),
                    Container(
                      height: 30,
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            if (enableButton) {
                              enableButton = false;

                              numberOfColors.value++;
                              opArt.attributes
                                  .firstWhere((element) =>
                                      element.name == 'numberOfColors')
                                  .value = numberOfColors.value;
                              if (numberOfColors.value > paletteLength) {
                                String paletteType = opArt.attributes
                                    .firstWhere((element) =>
                                        element.name == 'paletteType')
                                    .value
                                    .toString();
                                opArt.palette.randomize(
                                    paletteType, numberOfColors.value);
                              }
                              height =
                                  (numberOfColors.value.toDouble() + 2) * 30;
                              if (height >
                                  MediaQuery.of(context).size.height * 0.7) {
                                height =
                                    MediaQuery.of(context).size.height * 0.7;
                              }
                              opArt.saveToCache();
                              rebuildTab.value++;
                              rebuildCanvas.value++;
                            }
                          }),
                    ),
                    Container(
                            height: lengthOfAdditionColors.toDouble()*35,
                            width: 30,
                            child: Column(children: additionColors,)
                          )

                  ,
                    Container(
                      height:
                          MediaQuery.of(context).size.height - 115 - 70 - 150 - 30 - 30 -30 - lengthOfAdditionColors.toDouble()*35,
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
                    Container(height: 130, child: _opacityWidget()),
                  ],

            ));
      });
}
