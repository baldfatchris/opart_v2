import 'package:flutter/material.dart';
import 'package:opart_v2/loading.dart';
import 'package:opart_v2/menu.dart';
import 'package:opart_v2/opart_fibonacci.dart';
import 'package:opart_v2/opart_tree.dart';
import 'package:opart_v2/opart_wallpaper.dart';
import 'package:opart_v2/opart_wave.dart';



void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) => Loading(),
    '/menu':(context) => OpArtMenu(),
    '/fibonacci':(context) => OpArtFibonacciStudio(false),
    '/tree':(context) => OpArtTreeStudio(false),
    '/wallpaper':(context) => OpArtStudio(false),
    '/waves':(context) => OpArtWaveStudio(0, false),
  },

));

