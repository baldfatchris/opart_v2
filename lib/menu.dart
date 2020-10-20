import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'opart_fibonacci.dart';
import 'opart_tree.dart';
import 'opart_wave.dart';
import 'opart_wallpaper.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'model.dart';

bool showSettings = false;

File imageFile;


class OpArtMenu extends StatefulWidget {
  @override
  _OpArtMenuState createState() => _OpArtMenuState();
}

class _OpArtMenuState extends State<OpArtMenu> {
  List<OpArtType> OpArtTypes = [
    OpArtType(
      name: 'Fibonacci',
      icon: 'lib/assets/fibonacci.png',
      widget: OpArtFibonacciStudio(),

    ),
    OpArtType(
      name: 'Trees',
      icon: 'lib/assets/trees.png',
      widget: OpArtTreeStudio(),

    ),
    OpArtType(
        name: 'Waves',
        icon: 'lib/assets/waves.png',
        widget: OpArtWaveStudio(),
      ),
    OpArtType(
        name: 'Wallpaper',
        icon: 'lib/assets/wallpaper.png',
        widget: OpArtWallpaperStudio(),
       ),
  ];

//  int currentWidget = Random().nextInt(3);
  int currentWidget = 0;
  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
  //  PageController _pageController = PageController(initialPage: Random().nextInt(4));
    PageController _pageController = PageController(initialPage: 0);

    Size size = MediaQuery.of(context).size;
    print(showSettings);
    return PageView.builder(controller: _pageController,
        itemCount: 4, itemBuilder: (context, position) {
      return Scaffold(
          drawer: SizedBox(
            width: size.width,
            child: Drawer(
                child: ListView.builder(
                  
                  itemCount: OpArtTypes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              _pageController.jumpToPage(index);
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
            title: Text(OpArtTypes[position].name),
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
                        .capture(delay: Duration(milliseconds: 0), pixelRatio: 1)
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
          body: OpArtTypes[position].widget);}
    );
  }
}

class OpArtType {
  String name;
  String icon;
  Widget widget;

  OpArtType(
      {this.name,
        this.icon,
        this.widget});
}