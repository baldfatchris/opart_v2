import 'package:flutter/material.dart';
import 'package:opart_v2/loading.dart';


import 'opart_page.dart';
import 'model_opart.dart';




void main() {
  runApp(MaterialApp(
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
    return MaterialApp(debugShowCheckedModeBanner: false,
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
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('OpArt Lab',
                style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.8),
                itemCount: opArtTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OpArtPage(opArtTypes[index].opArtType)));
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
        ],
      ),
    ));
  }

  @override
  void initState() {
     opArtTypes = [
      OpArtTypes('Spirals', OpArtType.Fibonacci, 'lib/assets/fibonacci_400.png'),
      OpArtTypes('Waves', OpArtType.Wave, 'lib/assets/wave_400.png'),
      OpArtTypes('Trees', OpArtType.Tree, 'lib/assets/tree_400.png'),
      OpArtTypes('Wallpaper', OpArtType.Wallpaper, 'lib/assets/wallpaper_500.png'),
      OpArtTypes('Diagonal', OpArtType.Diagonal, 'lib/assets/diagonal_500.png'),
      OpArtTypes('Shapes', OpArtType.Shapes, 'lib/assets/shapes_500.png'),
       OpArtTypes('Squares', OpArtType.Squares, 'lib/assets/squares_500.png'),
       OpArtTypes('Hexagons', OpArtType.Hexagons, 'lib/assets/hexagons_500.png'),
       OpArtTypes('Quads', OpArtType.Quads, 'lib/assets/quads_500.png'),
       OpArtTypes('Riley', OpArtType.Riley, 'lib/assets/quads_500.png'),

    ];
  }
}
