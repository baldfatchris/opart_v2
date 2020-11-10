import 'package:flutter/material.dart';
import 'choose_palette.dart';
import 'model_palette.dart';
import 'opart_page.dart';
import 'settings_dialog.dart';
import 'model_opart.dart';
import 'model_settings.dart';

void BottomSheetChoosePalette(
  BuildContext context,
) {
  showSettings = false;
  rebuildOpArtPage.value++;
  showModalBottomSheet(barrierColor: Colors.white.withOpacity(0),
      backgroundColor: Colors.white.withOpacity(0.8),
      context: context,
      builder: (BuildContext bc) {
        return Container(
            height: 250,
            child: Container(
                child: GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: defaultPalettes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            List newPalette = defaultPalettes[index][3];
                            opArt.palette.colorList.clear();
                            for (int i = 0; i < newPalette.length; i++) {
                              opArt.palette.colorList
                                  .add(Color(int.parse(newPalette[i])));
                            }
                            numberOfColors.value = newPalette.length;
                            rebuildPalette.value++;
                            rebuildCanvas.value++;
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: GridView.builder(
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount: defaultPalettes[index][3].length,
                                    itemBuilder: (context, _index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(int.parse(
                                              defaultPalettes[index][3]
                                                  [_index])),
                                        ),
                                        height: 10,
                                        width: 10,
                                      );
                                    }),
                              ),
                              SizedBox(height: 2),
                              Container(
                                  width: 100,
                                  child: Text(
                                    defaultPalettes[index][0],
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                        ),
                      );
                    })));
      }).then((value){
    showSettings = true;
    rebuildOpArtPage.value++;
    opArt.saveToCache();
  });
}
