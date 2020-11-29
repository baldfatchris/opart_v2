
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
        Text('Inspired by the work of Bridget Riley, OpArt Lab allows you to produce your own OpArt creations '
            'without going to the the bother of recruiting a team of art students to painstakingly color in your canvases '
            'and with absolutely no formaldehyde.\n\n'
            'Written in Flutter and available in on both Apple and Android platforms, '
            'OpArt Lab is an collaboration between team of artists and nerds.\n\n'
            'If you have any feedback, suggestions for new features or additional OpArt styles, please drop the team an email at info@amovada.com',
        style: TextStyle(fontSize: 18),
        )
      ],),
    ));
  }
}
