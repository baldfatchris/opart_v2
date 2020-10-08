import 'package:flutter/material.dart';

import 'opart_fibonacci.dart';
import 'opart_tree.dart';
import 'opart_waves.dart';
import 'opart_wallpaper.dart';

bool showSettings = false;

class OpArtMenu extends StatefulWidget {
  @override
  _OpArtMenuState createState() => _OpArtMenuState();
}

class _OpArtMenuState extends State<OpArtMenu> {
  List<OpArtType> OpArtTypes = [
    OpArtType(
      name: 'Fibonacci',
      icon: 'lib/assets/fibonacci.png',
      widgetWithSettings: OpArtFibonacciStudio(true),
      widgetWithoutSettings: OpArtFibonacciStudio(false),
    ),
    OpArtType(
      name: 'Trees',
      icon: 'lib/assets/trees.png',
      widgetWithSettings: OpArtTreeStudio(true),
      widgetWithoutSettings: OpArtTreeStudio(false),
    ),
    OpArtType(
        name: 'Waves',
        icon: 'lib/assets/waves.png',
        widgetWithSettings: OpArtWaves(),
        widgetWithoutSettings: OpArtWaves()),
    OpArtType(
        name: 'Wallpaper',
        icon: 'lib/assets/wallpaper.png',
        widgetWithSettings: OpArtWallpaper(),
        widgetWithoutSettings: OpArtWallpaper()),
  ];

//  int currentWidget = Random().nextInt(3);
  int currentWidget = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(showSettings);
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
        body: showSettings
            ? OpArtTypes[currentWidget].widgetWithSettings
            : OpArtTypes[currentWidget].widgetWithoutSettings);
  }
}

class OpArtType {
  String name;
  String icon;
  Widget widgetWithSettings;
  Widget widgetWithoutSettings;

  OpArtType(
      {this.name,
      this.icon,
      this.widgetWithSettings,
      this.widgetWithoutSettings});
}
