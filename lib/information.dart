
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'main.dart';


class InformationPage extends StatefulWidget {

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final rebuildGallery = new ValueNotifier(0);
  bool showDelete = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.cyan,
          centerTitle: true,
        title: Text('Information',
        style: TextStyle(
        fontFamily: 'Righteous',
        fontWeight: FontWeight.bold,
        fontSize: 24, color: Colors.black)),
    ), body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Text('Siblings Chris and Emily teamed up remotely to create this beautiful app. \n\n'
            'It combines Chris\'s passion for OpArt with Emily\'s love for app design.',
        style: TextStyle(fontSize: 18),
        )
      ],),
    ));
  }
}
