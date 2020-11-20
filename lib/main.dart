import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opart_v2/loading.dart';

import 'opart_page.dart';
import 'model_opart.dart';

// import 'package:in_app_purchase/in_app_purchase.dart';
bool showDelete = false;
void main() {
  // InAppPurchaseConnection.enablePendingPurchases();

  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.cyan),
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/menu': (context) => MyApp(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Op Art Studio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<OpArtTypes> opArtTypes;
  @override
  Widget build(BuildContext context) {
    print(savedOpArt.length);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('OpArt Lab',
                style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 0.7),
                itemCount: opArtTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OpArtPage(opArtTypes[index].opArtType)));
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
                                fontSize: 20)),
                      ],
                    ),
                  );
                }),
          ),
          Text('My Gallery',
              style: TextStyle(
                  fontFamily: 'Righteous',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ValueListenableBuilder<int>(
                valueListenable: rebuildMain,
                builder: (context, value, child) {
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
                              onLongPress: () {
                                showDelete = true;
                                rebuildMain.value++;
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OpArtPage(
                                  savedOpArt[index]['type'], opArtSettings: savedOpArt[index],)
                                            ));
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 100,
                                        height: 100,
                                        child: Image.file(
                                          savedOpArt[index]['image'],
                                          fit: BoxFit.fitWidth,
                                        )),
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
                                                    savedOpArt.removeAt(index);
                                                    showDelete = false;
                                                    rebuildMain.value++;
                                                  },
                                                  backgroundColor: Colors.white,
                                                  child: Icon(Icons.remove,
                                                      color: Colors.red)),
                                            ),
                                          ))
                                      : Container(),
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
    ));
  }

  @override
  void initState() {
    opArtTypes = [
      OpArtTypes(
          'Spirals', OpArtType.Fibonacci, 'lib/assets/fibonacci_400.png'),
      OpArtTypes('Trees', OpArtType.Tree, 'lib/assets/tree_400.png'),
      OpArtTypes('Waves', OpArtType.Wave, 'lib/assets/wave_400.png'),
      OpArtTypes('Diagonal', OpArtType.Diagonal, 'lib/assets/diagonal_500.png'),
      OpArtTypes('Hexagons', OpArtType.Hexagons, 'lib/assets/hexagons_500.png'),
      OpArtTypes('Maze', OpArtType.Maze, 'lib/assets/maze_500.png'),
      OpArtTypes(
          'Neighbour', OpArtType.Neighbour, 'lib/assets/neighbour_500.png'),
      OpArtTypes('Quads', OpArtType.Quads, 'lib/assets/quads_500.png'),
      OpArtTypes('Riley', OpArtType.Riley, 'lib/assets/riley_500.png'),
      OpArtTypes('Shapes', OpArtType.Shapes, 'lib/assets/shapes_500.png'),
      OpArtTypes('Squares', OpArtType.Squares, 'lib/assets/squares_500.png'),
      OpArtTypes(
          'Wallpaper', OpArtType.Wallpaper, 'lib/assets/wallpaper_500.png'),
    ];
    super.initState();
  }
}
