import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:opart_v2/loading.dart';
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
double aspectRatio = 2/3;

Offerings offerings;

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.cyan),
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
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
    await Purchases.setup("dZAXkioWKFdOESaEtJMQkRsrETmZbFUK");

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
//      print(e);
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
      // print(e);
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
  final _rebuildDelete = new ValueNotifier(0);
  List<OpArtTypes> opArtTypes;
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return WillPopScope(onWillPop: () async => false,
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.width > 350
                              ? 4
                              : 3
                          : MediaQuery.of(context).size.width > 800
                              ? 6
                              : MediaQuery.of(context).size.width > 600
                                  ? 5
                                  : 4,
                      childAspectRatio: 0.8),
                  itemCount: opArtTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OpArtPage(opArtTypes[index].opArtType, false)), );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(opArtTypes[index].image),
                          ),
                          Text(opArtTypes[index].name,
                              style: TextStyle(
                                  fontFamily: 'Righteous',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ],
                      ),
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyGallery(savedOpArt.length - 1, false)));
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
                    if (savedOpArt.length == 0) {
                      return Text('Curate your own gallery of stunning OpArt here.');
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
                                      child: Container(
                                        width: 70,
                                        height: 100,
                                        child: Image.memory(
                                          base64Decode(
                                              savedOpArt[index]['image']),
                                          fit: BoxFit.fitWidth,
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
                                                    child: FloatingActionButton(
                                                        onPressed: () {
                                                          DatabaseHelper helper =
                                                              DatabaseHelper.instance;
                                                          helper.delete(
                                                              savedOpArt[index]
                                                                  ['id']);
                                                          savedOpArt.removeAt(index);
                                                          showDelete = false;
                                                          rebuildMain.value++;
                                                        },
                                                        backgroundColor: Colors.white,
                                                        child: Icon(Icons.delete,
                                                            color: Colors.grey)),
                                                  ),
                                                ))
                                            : Container();
                                      }
                                    ),
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
      OpArtTypes('Spirals', OpArtType.Fibonacci, 'lib/assets/fibonacci_400.png'),
      OpArtTypes('Trees', OpArtType.Tree, 'lib/assets/tree_400.png'),
      OpArtTypes('Waves', OpArtType.Wave, 'lib/assets/wave_400.png'),
      OpArtTypes('Diagonal', OpArtType.Diagonal, 'lib/assets/diagonal_500.png'),
      OpArtTypes('Hexagons', OpArtType.Hexagons, 'lib/assets/hexagons_500.png'),
      OpArtTypes('Shapes', OpArtType.Shapes, 'lib/assets/shapes_500.png'),
      OpArtTypes('Maze', OpArtType.Maze, 'lib/assets/maze_500.png'),
      OpArtTypes('Quads', OpArtType.Quads, 'lib/assets/quads_500.png'),
      OpArtTypes('Riley', OpArtType.Riley, 'lib/assets/riley_500.png'),
      OpArtTypes('Squares', OpArtType.Squares, 'lib/assets/squares_500.png'),
      OpArtTypes('Triangles', OpArtType.Triangles, 'lib/assets/triangles_500.png'),
      OpArtTypes('Wallpaper', OpArtType.Wallpaper, 'lib/assets/wallpaper_500.png'),
      OpArtTypes('Neighbour', OpArtType.Neighbour, 'lib/assets/neighbour_500.png'),
      OpArtTypes('Eye', OpArtType.Eye, 'lib/assets/eye_500.png'),
    ];
    super.initState();

  }


}
