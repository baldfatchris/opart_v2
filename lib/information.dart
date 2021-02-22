
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:launch_review/launch_review.dart';


class InformationPage extends StatefulWidget {

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final rebuildGallery =  ValueNotifier(0);
  bool showDelete = false;
  @override
  Widget build(BuildContext context) {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'info@amovada.com',
        queryParameters: {
          'subject': 'OpArt Lab'
        }
    );
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
      child: ListView(children: [
        Text('Inspired by the work of Bridget Riley, OpArt Lab allows you to produce your own OpArt creations '
            'without going to the the bother of recruiting a team of art students to painstakingly color in your canvases '
            'and with absolutely no formaldehyde.\n\n'
            'Written in Flutter and available on both Apple and Android platforms, '
            'OpArt Lab is a collaboration between teams of artists and nerds.\n\n'
            'If you have any feedback, suggestions for new features or additional OpArt styles, please drop the team an email at info@amovada.com',
        style: TextStyle(fontSize: 18),
        ),
        IconButton(icon: Icon(Icons.mail), onPressed: (){launch(_emailLaunchUri.toString());},),
        SizedBox(height: 18),
        Text(
          'If you have enjoyed this app we would really appreciate a positive review. Please click on the star below.',
          style: TextStyle(fontSize: 18),
        ),
        Center(
          child: IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              LaunchReview.launch(
                androidAppId:
                'com.opartlab',
                iOSAppId: '1538193511',
              );
            },
          ),
        ),
      ],),
    ));
  }
}
