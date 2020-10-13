
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'opart_fibonacci.dart';
import 'opart_tree.dart';
import 'opart_wave.dart';
import 'opart_wallpaper.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

bool showSettings = false;
Random rnd = Random();
int seed = rnd.nextInt(1<<32);

File imageFile;
ScreenshotController screenshotController = ScreenshotController();

class OpArtMenu extends StatefulWidget {
  @override
  _OpArtMenuState createState() => _OpArtMenuState();
}

class _OpArtMenuState extends State<OpArtMenu> {
  List<OpArtType> OpArtTypes = [
    OpArtType(
      name: 'Fibonacci',
      icon: 'lib/assets/fibonacci.png',
      widgetWithSettings: OpArtFibonacciStudio(true, screenshotController: screenshotController),
      widgetWithoutSettings: OpArtFibonacciStudio(false, screenshotController: screenshotController),
    ),
    OpArtType(
      name: 'Trees',
      icon: 'lib/assets/trees.png',
      widgetWithSettings: OpArtTreeStudio(true, screenshotController: screenshotController),
      widgetWithoutSettings: OpArtTreeStudio(false, screenshotController: screenshotController),
    ),
    OpArtType(
        name: 'Waves',
        icon: 'lib/assets/waves.png',
        widgetWithSettings: OpArtWaveStudio(seed, true, screenshotController: screenshotController),
        widgetWithoutSettings: OpArtWaveStudio(seed, false, screenshotController: screenshotController)),
    OpArtType(
        name: 'Wallpaper',
        icon: 'lib/assets/wallpaper.png',
        widgetWithSettings: OpArtWallpaperStudio(seed, true, screenshotController: screenshotController),
        widgetWithoutSettings: OpArtWallpaperStudio(seed, false, screenshotController: screenshotController)),
  ];

//  int currentWidget = Random().nextInt(3);
  int currentWidget = 1;
  @override
  void initState() {
    super.initState();
  }

  Hero btn2;
  @override
  Widget build(BuildContext context) {
    print(showSettings);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: btn2,
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
          actions: [
            IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () {
                  imageFile = null;
                  screenshotController
                      .capture(delay: Duration(milliseconds: 0), )
                      .then((File image) async {
                    setState(() {
                      imageFile = image;
                      Share.shareFiles([imageFile.path]);
                    });

                  });
                })
          ],
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
