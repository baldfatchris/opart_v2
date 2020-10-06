import 'package:flutter/material.dart';

class OpArtMenu extends StatefulWidget {
  @override
  _OpArtMenuState createState() => _OpArtMenuState();
}

class _OpArtMenuState extends State<OpArtMenu> {

  List<OpArtType> OpArtTypes = [
    OpArtType(name: 'Trees', icon: 'lib/assets/trees.png', link: '/tree'),
    OpArtType(name: 'Waves', icon: 'lib/assets/waves.png', link: '/waves'),
    OpArtType(name: 'Wallpaper', icon: 'lib/assets/wallpaper.png', link: '/wallpaper'),
  ];


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Choose an OpArt Type'),
          centerTitle: true,
          elevation: 0,
        ),
        body:ListView.builder(
          itemCount: OpArtTypes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                child: ListTile(
                  onTap: () {
                    print(OpArtTypes[index].name);
                    Navigator.pushReplacementNamed(context, OpArtTypes[index].link);
                  },
                  title: Text(OpArtTypes[index].name),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('${OpArtTypes[index].icon}'),
                  ),
                ),
              ),
            );
          },
        )

    );
  }
}

class OpArtType {
  String name;
  String icon;
  String link;

  OpArtType({this.name, this.icon, this.link});

}