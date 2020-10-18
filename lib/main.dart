import 'package:flutter/material.dart';
import 'package:opart_v2/loading.dart';
import 'package:opart_v2/menu.dart';
import 'package:opart_v2/opart_fibonacci.dart';
import 'package:opart_v2/opart_tree.dart';
import 'package:opart_v2/opart_wallpaper.dart';
import 'package:opart_v2/opart_wave.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/menu': (context) => OpArtMenu(),
      '/fibonacci': (context) => OpArtFibonacciStudio(0, false),
      '/tree': (context) => OpArtTreeStudio(0, false),
      '/wallpaper': (context) => OpArtWallpaperStudio(0, false),
      '/waves': (context) => OpArtWaveStudio(0, false),
    },
  ));
}
