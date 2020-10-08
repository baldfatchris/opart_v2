import 'package:flutter/material.dart';
import 'side_drawer.dart';
import 'opart_fibonacci.dart';
import 'opart_tree.dart';
import 'opart_waves.dart';
import 'opart_wallpaper.dart';
import 'dart:math';

class OpArtMenu extends StatefulWidget {
  @override
  _OpArtMenuState createState() => _OpArtMenuState();
}

bool showSettings = true;

class _OpArtMenuState extends State<OpArtMenu> {
  List<OpArtType> OpArtTypes = [
    OpArtType(name: 'Fibonacci', icon: 'lib/assets/fibonacci.png', widget: OpArtFibonacciStudio(showSettings)),
    OpArtType(name: 'Trees', icon: 'lib/assets/trees.png', widget: OpArtTreeStudio(showSettings)),
    OpArtType(name: 'Waves', icon: 'lib/assets/waves.png', widget: OpArtWaves()),
    OpArtType(name: 'Wallpaper', icon: 'lib/assets/wallpaper.png', widget: OpArtWallpaper()),
  ];

//  int currentWidget = Random().nextInt(3);
int currentWidget = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.settings),
          onPressed: () {
            setState(() {
              showSettings = !showSettings;
            });
          },
        ),
        drawer: Drawer(
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
                    setState(() {
                      currentWidget = index;
                      Navigator.pop(context);
                    });
                  },
                  title: Text(OpArtTypes[index].name),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('${OpArtTypes[index].icon}'),
                  ),
                ),
              ),
            );
          },
        )),
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text(OpArtTypes[currentWidget].name),
          centerTitle: true,
          elevation: 0,
        ),
        body: OpArtTypes[currentWidget].widget);
  }
}

class OpArtType {
  String name;
  String icon;
  Widget widget;

  OpArtType({this.name, this.icon, this.widget});
}
