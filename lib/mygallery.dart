import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
  bool carouselView = true;
  int currentIndex;
  String currentSize = '8\' x 10\'';
  Color frameColor = Colors.black;
  final rebuildGallery = new ValueNotifier(0);
  final rebuildDialog = new ValueNotifier(0);
  final _rebuildDelete = new ValueNotifier(0);
  bool showDelete = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: rebuildGallery,
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  centerTitle: true,
                  title: Text('My Gallery',
                      style: TextStyle(
                          fontFamily: 'Righteous',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black)),
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
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            carouselView = !carouselView;
                          });
                        },
                        icon: Icon(carouselView
                            ? Icons.view_comfortable
                            : Icons.view_carousel_rounded))
                  ]
                  // actions: [
                  //   IconButton(
                  //     icon: Icon(Icons.add_shopping_cart, color: Colors.black),
                  //     onPressed: () {
                  //       showDialog<void>(
                  //           context: context,
                  //           barrierDismissible: true, // user must tap button!
                  //           builder: (BuildContext context) {
                  //             return ValueListenableBuilder<int>(
                  //                 valueListenable: rebuildDialog,
                  //                 builder: (context, value, child) {
                  //                   return SimpleDialog(
                  //                     backgroundColor: Colors.cyan[100],
                  //                     children: [
                  //                       Center(child: Text('Buy this print', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(30.0),
                  //                         child: Container(color: Colors.cyan[100],height: 200,
                  //                           child: Padding(
                  //                             padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  //                             child: Container(
                  //                               color: frameColor,
                  //                               child: Padding(
                  //                                 padding: const EdgeInsets.all(16.0),
                  //                                 child: Image.memory(
                  //                                   base64Decode(
                  //                                       savedOpArt[currentIndex - 1]
                  //                                           ['image']),
                  //                                   fit: BoxFit.cover,
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       Row(
                  //                         children: [
                  //                           Flexible(
                  //                             child: Column(
                  //                               children: [
                  //                                 Text('Frame Color'),
                  //                                 ListTile(
                  //                                   title: const Text('Black'),
                  //                                   leading: Radio(
                  //                                     value: Colors.black,
                  //                                     groupValue: frameColor,
                  //                                     onChanged: (Color value) {
                  //                                       frameColor = value;
                  //                                       rebuildDialog.value++;
                  //                                     },
                  //                                   ),
                  //                                 ),
                  //                                 ListTile(
                  //                                   title: const Text('White'),
                  //                                   leading: Radio(
                  //                                     value: Colors.white,
                  //                                     groupValue: frameColor,
                  //                                     onChanged: (Color value) {
                  //                                       frameColor = value;
                  //                                       rebuildDialog.value++;
                  //                                     },
                  //                                   ),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                           Flexible(
                  //                             child: Column(
                  //                               children: [
                  //                                 Text('Size'),
                  //                                 ListTile(
                  //                                   title: const Text('8\' x 10\''),
                  //                                   leading: Radio(
                  //                                     value: '8\' x 10\'',
                  //                                     groupValue: currentSize,
                  //                                     onChanged: (String value) {
                  //                                       currentSize = value;
                  //                                       rebuildDialog.value++;
                  //                                     },
                  //                                   ),
                  //                                 ),
                  //                                 ListTile(
                  //                                   title: const Text('11\' x 14\''),
                  //                                   leading: Radio(
                  //                                     value: '11\' x 14\'',
                  //                                     groupValue: currentSize,
                  //                                     onChanged: (String value) {
                  //                                       currentSize = value;
                  //                                       rebuildDialog.value++;
                  //                                     },
                  //                                   ),
                  //                                 ), ListTile(
                  //                                   title: const Text('12\' x 18\''),
                  //                                   leading: Radio(
                  //                                     value: '12\' x 18\'',
                  //                                     groupValue: currentSize,
                  //                                     onChanged: (String value) {
                  //                                       currentSize = value;
                  //                                       rebuildDialog.value++;
                  //                                     },
                  //                                   ),
                  //                                 ),
                  //                                 ListTile(
                  //                                   title: const Text('16\' x 20\''),
                  //                                   leading: Radio(
                  //                                     value: '16\' x 20\'',
                  //                                     groupValue: currentSize,
                  //                                     onChanged: (String value) {
                  //                                       currentSize = value;
                  //                                       rebuildDialog.value++;
                  //                                     },
                  //                                   ),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       ButtonBar(
                  //                         children: [
                  //                           RaisedButton(child: Text(
                  //                               'Buy now')),
                  //                         ],
                  //                       )
                  //                     ],
                  //                   );
                  //                 });
                  //           });
                  //     },
                  //   )
                  // ],
                  ),
              body: savedOpArt.length == 0
                  ? Center(
                      child: Text(
                          'You have not yet saved any opArt to your gallery'))
                  : carouselView
                      ? Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: CarouselSlider.builder(
                                options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    height: (MediaQuery.of(context).size.height),
                                    enlargeCenterPage: true,
                                    initialPage: widget.currentImage - 1),
                                itemCount: savedOpArt.length,
                                itemBuilder: (BuildContext context, int index) {
                                  currentIndex = index;
                                  return GestureDetector(
                                    onLongPress: () {
                                      print('long press');
                                      showDelete = true;
                                      _rebuildDelete.value++;
                                    },
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OpArtPage(
                                                    savedOpArt[index]['type'],
                                                    opArtSettings:
                                                        savedOpArt[index],
                                                  )));
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          color: Colors.grey[700],
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.memory(
                                                  base64Decode(savedOpArt[index]
                                                      ['image']),
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ValueListenableBuilder<int>(
                                            valueListenable: _rebuildDelete,
                                            builder: (context, value, child) {
                                              return showDelete
                                                  ? Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Center(
                                                          child:
                                                              FloatingActionButton(
                                                            onPressed: () {
                                                              DatabaseHelper
                                                                  helper =
                                                                  DatabaseHelper
                                                                      .instance;
                                                              helper.delete(
                                                                  savedOpArt[
                                                                          index]
                                                                      ['id']);
                                                              savedOpArt
                                                                  .removeAt(
                                                                      index);
                                                              showDelete =
                                                                  false;
                                                              rebuildGallery
                                                                  .value++;
                                                            },
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Icon(
                                                                Icons.delete,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ),
                                                      ))
                                                  : Container();
                                            }),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Center(
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                60)),
                                itemCount: savedOpArt.length,
                                itemBuilder: (BuildContext context, int index) {
                                  currentIndex = index;
                                  return Center(
                                    child: GestureDetector(
                                      onLongPress: () {
                                        print('long press');
                                        showDelete = true;
                                        _rebuildDelete.value++;
                                      },
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OpArtPage(
                                                      savedOpArt[index]['type'],
                                                      opArtSettings:
                                                          savedOpArt[index],
                                                    )));
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                color: Colors.black,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Image.memory(
                                                        base64Decode(
                                                            savedOpArt[index]
                                                                ['image']),
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ValueListenableBuilder<int>(
                                              valueListenable: _rebuildDelete,
                                              builder: (context, value, child) {
                                                return showDelete
                                                    ? Positioned(
                                                        right: 0,
                                                        top: 0,
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: Center(
                                                            child:
                                                                FloatingActionButton(
                                                              onPressed: () {
                                                                DatabaseHelper
                                                                    helper =
                                                                    DatabaseHelper
                                                                        .instance;
                                                                helper.delete(
                                                                    savedOpArt[
                                                                            index]
                                                                        ['id']);
                                                                savedOpArt
                                                                    .removeAt(
                                                                        index);
                                                                showDelete =
                                                                    false;
                                                                rebuildGallery
                                                                    .value++;
                                                              },
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),
                                                        ))
                                                    : Container();
                                              }),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ));
        });
  }

  @override
  void initState() {
    currentIndex = widget.currentImage;
  }
}
