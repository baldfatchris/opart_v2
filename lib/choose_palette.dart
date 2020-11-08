import 'model_palette.dart';
import 'model_opart.dart';
import 'package:flutter/material.dart';

class ChoosePalette extends StatefulWidget {
  @override
  _ChoosePaletteState createState() => _ChoosePaletteState();
}

class _ChoosePaletteState extends State<ChoosePalette> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: defaultPalettes.length,
            itemBuilder: (context, index) {

                return Card(
                    child: Row(
                  children: [
                    Container(
                        width: 100, child: Text(defaultPalettes[index][0])),
                    Container(height: 30,
                      width: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: defaultPalettes[index][3].length,
                          itemBuilder: (context, _index) {
                            return Container(
                              height: 20,
                              width: 20,
                              color: Color(int.parse(defaultPalettes[index][3][_index])),
                            );
                          }),
                    )
                  ],
                ));

            }));
  }
}
