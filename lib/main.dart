import 'package:flutter/material.dart';
import 'package:opart_v2/loading.dart';
import 'package:opart_v2/oparttree.dart';
import 'package:opart_v2/opartwaves.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) => Loading(),
    '/tree':(context) => OpArtTree(),
    '/waves':(context) => OpArtWaves(),
  },

));

