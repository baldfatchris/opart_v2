
import 'package:flutter/material.dart';

import 'opart_tree.dart';
import 'opart_waves.dart';
import 'opart_wallpaper.dart';
Widget DrawerWidget(){
  List<OpArtType> OpArtTypes = [
    OpArtType(name: 'Trees', icon: 'lib/assets/trees.png', widget: OpArtTree()),
    OpArtType(name: 'Waves', icon: 'lib/assets/waves.png', widget: OpArtWaves()),
    OpArtType(name: 'Wallpaper', icon: 'lib/assets/wallpaper.png', widget: OpArtWallpaper()),
  ];
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
      child: ListView.builder(
        itemCount: OpArtTypes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: () {
                  print(OpArtTypes[index].name);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OpArtTypes[index].widget));

                },
                title: Text(OpArtTypes[index].name),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('${OpArtTypes[index].icon}'),
                ),
              ),
            ),
          );
        },
      )
  );
}
class OpArtType {
  String name;
  String icon;
  Widget widget;

  OpArtType({this.name, this.icon, this.widget});

}