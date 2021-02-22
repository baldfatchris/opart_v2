import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

// import 'package:opart_v2/loading.dart';
import 'database_helper.dart';
import 'information.dart';
import 'opart_page.dart';
import 'model_opart.dart';
import 'mygallery.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';

bool showDelete = false;
bool proVersion = true;
Random rnd = Random();
int seed = DateTime.now().millisecond;
double aspectRatio = 2 / 3;

Offerings offerings;

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.cyan),
    initialRoute: '/menu',
    routes: {
      // '/': (context) => Loading(),
      '/menu': (context) => MyApp(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpArt Lab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Op Art Studio'),
    );
  }

  Future<void> initPlatformState() async {
    proVersion = false;

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup('dZAXkioWKFdOESaEtJMQkRsrETmZbFUK');

    PurchaserInfo purchaserInfo;
    try {
      purchaserInfo = await Purchases.getPurchaserInfo();
      //  print(purchaserInfo.toString());
      if (purchaserInfo.entitlements.all['all_features'] != null) {
        proVersion = purchaserInfo.entitlements.all['all_features'].isActive;
      } else {
        proVersion = false;
      }
    } on PlatformException catch (e) {
      print(e);
    }

//    print('#### is user pro? ${proVersion}');

    try {
      offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current.availablePackages.isNotEmpty) {
        // print(offerings.current.availablePackages.length);
        // print('offerings');
        // Display packages for sale
      }
    } on PlatformException catch (e) {
      // print('offerings errors');
      print(e);
      // optional error handling
    }
  }

  @override
  void initState() {
    DatabaseHelper helper = DatabaseHelper.instance;
    // helper.deleteDB();
    initPlatformState();
    helper.getUserDb();

    super.initState();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _rebuildDelete = ValueNotifier(0);
  List<OpArtTypes> opArtTypes;

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('OpArt Lab',
                        style: TextStyle(
                            fontFamily: 'Righteous',
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.info, color: Colors.cyan),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InformationPage()));
                    })
              ],
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 1, maxCrossAxisExtent: 130),
                  itemCount: opArtTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OpArtPage(opArtTypes[index].opArtType, false)),
                          );
                        },
                        child: Hero(
                          tag: opArtTypes[index].name,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.9),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(5, 5),
                                )
                              ],
                            ),
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(20),
                              child: GridTile(
                                child: Image.asset(opArtTypes[index].image),
                                footer: Container(
                                  color: Colors.white.withOpacity(0.7),
                                  width: double.infinity,
                                  child: Text(opArtTypes[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Righteous',
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyGallery(savedOpArt.length - 1, false)));
              },
              child: Text('My Gallery',
                  style: TextStyle(
                      fontFamily: 'Righteous',
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ValueListenableBuilder<int>(
                  valueListenable: rebuildMain,
                  builder: (context, value, child) {
                    if (savedOpArt.isEmpty) {
                      return Text(
                          'Curate your own gallery of stunning OpArt here.');
                    }
                    return Container(
                      height: 100,
                      child: ListView.builder(
                          itemCount: savedOpArt.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyGallery(index + 1, false)));
                                },
                                onLongPress: () {
                                  showDelete = !showDelete;
                                  _rebuildDelete.value++;
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          child: Image.memory(
                                            base64Decode(
                                                savedOpArt[index]['image']),
                                            fit: BoxFit.fitWidth,
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
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle),
                                                    child: Center(
                                                      child:
                                                          FloatingActionButton(
                                                              onPressed: () {
                                                                if (savedOpArt[
                                                                        index]
                                                                    ['paid']) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                            title:
                                                                                Text(' Are you sure you want to delete?'),
                                                                            content: Text('You have paid for this image. If you delete it you will not be able to download it again.'),
                                                                            actions: [
                                                                              RaisedButton(
                                                                                child: Text('Delete'),
                                                                                onPressed: () {
                                                                                  DatabaseHelper helper = DatabaseHelper.instance;
                                                                                  helper.delete(savedOpArt[index]['id']);
                                                                                  savedOpArt.removeAt(index);
                                                                                  showDelete = false;
                                                                                  rebuildMain.value++;
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              ),
                                                                              RaisedButton(
                                                                                child: Text('Cancel'),
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              )
                                                                            ]);
                                                                      });
                                                                } else {
                                                                  DatabaseHelper
                                                                      helper =
                                                                      DatabaseHelper
                                                                          .instance;
                                                                  helper.delete(
                                                                      savedOpArt[
                                                                              index]
                                                                          [
                                                                          'id']);
                                                                  savedOpArt
                                                                      .removeAt(
                                                                          index);
                                                                  showDelete =
                                                                      false;
                                                                  rebuildMain
                                                                      .value++;
                                                                }
                                                              },
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
                                                  ))
                                              : Container();
                                        }),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }),
            ),
          ],
        ),
      )),
    );
  }

  @override
  void initState() {
    // InAppPurchaseConnection.enablePendingPurchases();

    opArtTypes = [
      OpArtTypes('Flow', OpArtType.Flow, 'lib/assets/flow_200.png'),
      OpArtTypes(
          'Wallpaper', OpArtType.Wallpaper, 'lib/assets/wallpaper_200.png'),
      OpArtTypes('Diagonal', OpArtType.Diagonal, 'lib/assets/diagonal_200.png'),
      OpArtTypes('Shapes', OpArtType.Shapes, 'lib/assets/shapes_200.png'),
      OpArtTypes('Trees', OpArtType.Tree, 'lib/assets/tree_200.png'),
      OpArtTypes('Maze', OpArtType.Maze, 'lib/assets/maze_200.png'),
      OpArtTypes('Quads', OpArtType.Quads, 'lib/assets/quads_200.png'),
      // OpArtTypes('Plasma', OpArtType.Plasma, 'lib/assets/plasma.png'),
      OpArtTypes('String', OpArtType.String, 'lib/assets/string_200.png'),
      OpArtTypes('Rhombus', OpArtType.Rhombus, 'lib/assets/rhombus_200.png'),
      OpArtTypes(
          'Triangles', OpArtType.Triangles, 'lib/assets/triangles_200.png'),
      OpArtTypes('Squares', OpArtType.Squares, 'lib/assets/squares_200.png'),
      // OpArtTypes('Life', OpArtType.Life, 'lib/assets/squares.png'),
      OpArtTypes(
          'Spirals', OpArtType.Fibonacci, 'lib/assets/fibonacci_200.png'),
      OpArtTypes('Eye', OpArtType.Eye, 'lib/assets/eye_200.png'),
      OpArtTypes('Hexagons', OpArtType.Hexagons, 'lib/assets/hexagons_200.png'),
      OpArtTypes('Waves', OpArtType.Wave, 'lib/assets/wave_200.png'),
      OpArtTypes('Riley', OpArtType.Riley, 'lib/assets/riley_200.png'),
      OpArtTypes(
          'Neighbour', OpArtType.Neighbour, 'lib/assets/neighbour_200.png'),
    ];
    super.initState();
  }
}
