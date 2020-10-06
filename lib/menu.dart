import 'package:flutter/material.dart';
import 'side_drawer.dart';

class OpArtMenu extends StatefulWidget {
  @override
  _OpArtMenuState createState() => _OpArtMenuState();
}

class _OpArtMenuState extends State<OpArtMenu> {




  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: DrawerWidget(),
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Choose an OpArt Type'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container());
  }
}



