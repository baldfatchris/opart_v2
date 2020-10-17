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
int seed = rnd.nextInt(1 << 32);

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
      widgetWithSettings: OpArtFibonacciStudio(seed, true,
          screenshotController: screenshotController),
      widgetWithoutSettings: OpArtFibonacciStudio(seed, false,
          screenshotController: screenshotController),
    ),
    OpArtType(
      name: 'Trees',
      icon: 'lib/assets/trees.png',
      widgetWithSettings: OpArtTreeStudio(seed, true,
          screenshotController: screenshotController),
      widgetWithoutSettings: OpArtTreeStudio(seed, false,
          screenshotController: screenshotController),
    ),
    OpArtType(
        name: 'Waves',
        icon: 'lib/assets/waves.png',
        widgetWithSettings: OpArtWaveStudio(seed, true,
            screenshotController: screenshotController),
        widgetWithoutSettings: OpArtWaveStudio(seed, false,
            screenshotController: screenshotController)),
    OpArtType(
        name: 'Wallpaper',
        icon: 'lib/assets/wallpaper.png',
        widgetWithSettings: OpArtWallpaperStudio(seed, true,
            screenshotController: screenshotController),
        widgetWithoutSettings: OpArtWallpaperStudio(seed, false,
            screenshotController: screenshotController)),
  ];

//  int currentWidget = Random().nextInt(3);
  int currentWidget = 1;
  @override
  void initState() {
    super.initState();
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(height: 300,
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.text_rotation_angledown),Text('angle')],
                ),Column(
                  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.photo_size_select_large_outlined),Text('size')],
                ), Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.text_rotation_angledown),Text('angle')],
                ),Column(
                  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.photo_size_select_large_outlined),Text('size')],
                ), Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.text_rotation_angledown),Text('angle')],
                ),Column(
                  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.photo_size_select_large_outlined),Text('size')],
                ), Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.text_rotation_angledown),Text('angle')],
                ),Column(
                  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.photo_size_select_large_outlined),Text('size')],
                ), Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.text_rotation_angledown),Text('angle')],
                ),Column(
                  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.photo_size_select_large_outlined),Text('size')],
                ), Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.text_rotation_angledown),Text('angle')],
                ),Column(
                  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.photo_size_select_large_outlined),Text('size')],
                ),

              ],
            ),
          );
        });
  }

  Hero btn2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(showSettings);
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.refresh),
                      SizedBox(width: 5),
                      Text('Randomise')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        _settingModalBottomSheet(context);
                      },
                      child: Text('TOOLS')),
                ),
                Container(width: 100, height: 1),
              ],
            )),
        floatingActionButton: FloatingActionButton(
          heroTag: btn2,
          child: Icon(Icons.settings),
          onPressed: () {
            setState(() {
              showSettings = !showSettings;
            });
          },
        ),
        drawer: SizedBox(
          width: size.width,
          child: Drawer(
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
        ),
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
                      .capture(delay: Duration(milliseconds: 0), pixelRatio: 20)
                      .then((File image) async {
                    setState(() {
                      imageFile = image;
                      Share.shareFiles([imageFile.path],
                          subject: 'Using Chris\'s fabulous OpArt App',
                          text: 'Download the OpArt App NOW!');
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
