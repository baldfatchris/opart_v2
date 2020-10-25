import 'package:flutter/material.dart';
import 'package:opart_v2/loading.dart';
import 'package:opart_v2/menu.dart';
import 'package:opart_v2/opart_fibonacci.dart';
import 'package:opart_v2/opart_tree.dart';
import 'package:opart_v2/opart_wallpaper.dart';
import 'package:opart_v2/opart_wave.dart';
import 'opart_page.dart';

import 'menu.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
    //  '/': (context) => Loading(),
      '/': (context) => OpArtPage(0),
      '/menu': (context) => MyApp(),
    //  '/fibonacci': (context) => OpArtFibonacciStudio(),
      '/tree': (context) => OpArtTreeStudio(),
      '/wallpaper': (context) => OpArtWallpaperStudio(),
      '/waves': (context) => OpArtWaveStudio(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemCount: OpArtTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OpArtMenu(index)));
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(OpArtTypes[index].icon),
                        ),
                        Text(OpArtTypes[index].name,style: TextStyle(
                  fontFamily: 'Righteous',

                  fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
