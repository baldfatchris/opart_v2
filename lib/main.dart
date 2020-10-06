import 'package:flutter/material.dart';
import 'package:opart_v2/loading.dart';
import 'package:opart_v2/menu.dart';
import 'package:opart_v2/opart_tree.dart';
import 'package:opart_v2/opart_wallpaper.dart';
import 'package:opart_v2/opart_waves.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) => Loading(),
    '/menu':(context) => OpArtMenu(),
    '/tree':(context) => OpArtTree(),
    '/wallpaper':(context) => OpArtWallpaper(),
    '/waves':(context) => OpArtWaves(),
  },

));

