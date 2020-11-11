import 'model_palette.dart';
import 'model_opart.dart';
import 'package:flutter/material.dart';

import 'opart_page.dart';

import 'dart:math';

import 'choose_palette.dart';

class ChoosePalette extends StatefulWidget {
  @override
  _ChoosePaletteState createState() => _ChoosePaletteState();
}

class _ChoosePaletteState extends State<ChoosePalette> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _circularPalette(int index) {
      int _sizeOfPalette = defaultPalettes[index][3].length;

      List<Widget> _list = [];
      if (_sizeOfPalette < 11) {
        for (int i = 0; i < _sizeOfPalette; i++) {
          _list.add(Transform.rotate(
              angle: i * 2 * pi / _sizeOfPalette,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.6),
                    shape: BoxShape.circle,
                    color: Color(int.parse(defaultPalettes[index][3][i])),
                  ),
                  height: 20,
                  width: 20,
                ),
              )));
        }
      } else {
        for (int i = 0; i < _sizeOfPalette; i++) {
          if(i<10){
          _list.add(Transform.rotate(
              angle: i * 2 * pi / 10,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.6),
                    shape: BoxShape.circle,
                    color: Color(int.parse(defaultPalettes[index][3][i])),
                  ),
                  height: 20,
                  width: 20,
                ),
              ))

          );}
          else{
            _list.add(Transform.rotate(
                angle: i * 2 * pi / (_sizeOfPalette-10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.6),
                        shape: BoxShape.circle,
                        color: Color(int.parse(defaultPalettes[index][3][i])),
                      ),
                      height: 20,
                      width: 20,
                    ),
                  ),
                ))

            );
          }
        }
      }
      return _list;
    }

    return Container(
        height: 700,
        child: ListView.builder(
            itemCount: defaultPalettes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
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
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Stack(
                              children: _circularPalette(index),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      defaultPalettes[index][0],
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              );
            }));
  }
}
