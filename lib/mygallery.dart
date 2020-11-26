import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'database_helper.dart';
import 'main.dart';
import 'model_opart.dart';
import 'opart_page.dart';

class MyGallery extends StatefulWidget {
  int currentImage;
  MyGallery(this.currentImage);
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  final rebuildGallery = new ValueNotifier(0);
  bool showDelete = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: rebuildGallery,
        builder: (context, value, child) {
          return Scaffold(backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('My Gallery',
                    style: TextStyle(
                        fontFamily: 'Righteous',
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                leading: IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    }),
              ),
              body: savedOpArt.length == 0
                  ? Center(
                      child: Text(
                          'You have not yet saved any opArt to your gallery'))
                  : Center(
                      child: CarouselSlider.builder(
                          options: CarouselOptions(
                              height:
                                  (MediaQuery.of(context).size.height - 60) *
                                      0.9,
                              enlargeCenterPage: true,
                          initialPage: widget.currentImage-1),
                          itemCount: savedOpArt.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onLongPress: () {
                                print('long press');
                                showDelete = true;
                                rebuildGallery.value++;
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OpArtPage(
                                              savedOpArt[index]['type'],
                                              opArtSettings: savedOpArt[index],
                                            )));
                              },
                              child: Stack(
                                children: [
                                  Container(color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.memory(
                                           base64Decode( savedOpArt[index]['image']),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  showDelete
                                      ? Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: FloatingActionButton(
                                                  onPressed: () {
                                                    DatabaseHelper helper = DatabaseHelper.instance;
                                                    helper.delete(savedOpArt[index]['id']);
                                                    savedOpArt.removeAt(index);
                                                    showDelete = false;
                                                    rebuildGallery.value++;
                                                  },
                                                  backgroundColor: Colors.white,
                                                  child: Icon(Icons.delete,color: Colors.grey),),
                                            ),
                                          ))
                                      : Container(),
                                ],
                              ),
                            );
                          }),
                    ));
        });
  }
}
