import 'dart:io' show File, Platform;

import 'package:flutter/material.dart';

import 'opart_fibonacci.dart';
import 'opart_tree.dart';
import 'opart_wave.dart';
import 'opart_wallpaper.dart';
import 'package:share/share.dart';
import 'opart_model.dart';




bool showSettings = false;

File imageFile;


class OpArtMenu extends StatefulWidget {
  int currentWidget;
  OpArtMenu(this.currentWidget);
  @override
  _OpArtMenuState createState() => _OpArtMenuState();
}
List<OpArtType> OpArtTypes = [
  OpArtType(
    name: 'Fibonacci',
    icon: 'lib/assets/fibonacci_200.png',
    widget: OpArtFibonacciStudio(),

  ),
  OpArtType(
    name: 'Trees',
    icon: 'lib/assets/tree_200.png',
    widget: OpArtTreeStudio(),

  ),
  OpArtType(
    name: 'Waves',
    icon: 'lib/assets/wave_200.png',
    widget: OpArtWaveStudio(),
  ),
  OpArtType(
    name: 'Wallpaper',
    icon: 'lib/assets/wallpaper_200.png',
    widget: OpArtWallpaperStudio(),
  ),
];


class _OpArtMenuState extends State<OpArtMenu> {




  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
  //  PageController pageController = PageController(initialPage:widget.currentWidget);
  //  PageController _pageController = PageController(initialPage: 2);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // drawer: SizedBox(
      //   width: size.width,
      //   child: Drawer(
      //       child: ListView.builder(
      //
      //         itemCount: OpArtTypes.length,
      //         itemBuilder: (context, index) {
      //           return Padding(
      //             padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      //             child: Card(
      //               child: ListTile(
      //                 onTap: () {
      //                   setState(() {
      //                     pageController.jumpToPage(index);
      //                     Navigator.pop(context);
      //
      //                   });
      //                 },
      //                 title: Text(OpArtTypes[index].name),
      //                 leading: CircleAvatar(
      //                   backgroundImage: AssetImage('${OpArtTypes[index].icon}'),
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //       )),
      // ),
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.cyan[200],
          title: Text(OpArtTypes[widget.currentWidget].name,style: TextStyle(color: Colors.black,fontFamily: 'Righteous',
              fontSize: 24,
              fontWeight: FontWeight.bold ),),
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.home,color: Colors.black,), onPressed: (){
            Navigator.pop(context);
          },),
          actions: [
            IconButton(
                icon: Icon(
//                  Platform.isAndroid? Icons.share: Icons.ios_share,
                       Icons.share,
                  color: Colors.black,
                ),
                onPressed: () {
                  print('sharing');
                  imageFile = null;
                  screenshotController
                      .capture(delay: Duration(milliseconds: 0), pixelRatio: 2)
                      .then((File image) async {
                        print(image)
;                    setState(() {
                      imageFile = image;



                      // Share.share('Hello World',
                      //
                      //         sharePositionOrigin: Rect.fromLTWH(
                      //         0,0, size.width, size.height/2)
                      //     );

                        //    subject: 'Using Chris\'s fabulous OpArt App',


                      if(Platform.isAndroid){
                        Share.shareFiles([imageFile.path],
                          subject: 'Using Chris\'s fabulous OpArt App',
                          text: 'Download the OpArt App NOW!',

                        );
                      }
                      else{
                        Share.shareFiles([imageFile.path], sharePositionOrigin: Rect.fromLTWH(
                          0,0, size.width, size.height/2),
                         subject: 'Using Chris\'s fabulous OpArt App',

                        );
                      }





                    });
                  });
                })
          ],
        ),
        body: OpArtTypes[widget.currentWidget].widget);


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