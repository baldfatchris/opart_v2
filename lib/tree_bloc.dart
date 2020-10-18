
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'opart_tree.dart';

class TreeSettingsCubit extends Cubit<TreeSettings> {
  TreeSettingsCubit() : super(TreeSettings(
                                 id: 0,
                                 palette: [
                                   Colors.red,
                                   Colors.pink,
                                   Colors.purple,
                                   Colors.deepPurple,
                                   Colors.indigo,
                                   Colors.blue,
                                   Colors.lightBlue,
                                   Colors.cyan,
                                   Colors.teal,
                                   Colors.green,
                                   Colors.lightGreen,
                                   Colors.lime,
                                   Colors.yellow,
                                   Colors.amber,
                                   Colors.orange,
                                   Colors.deepOrange,
                                   Colors.brown,
                                   Colors.grey,
                                   Colors.blueGrey,
                                   Colors.white,
                                   Colors.redAccent,
                                   Colors.pinkAccent,
                                   Colors.purpleAccent,
                                   Colors.deepPurpleAccent,
                                   Colors.indigoAccent,
                                   Colors.blueAccent,
                                   Colors.lightBlueAccent,
                                   Colors.cyanAccent,
                                   Colors.tealAccent,
                                   Colors.greenAccent,
                                   Colors.lightGreenAccent,
                                   Colors.limeAccent,
                                   Colors.yellowAccent,
                                   Colors.amberAccent,
                                   Colors.orangeAccent,
                                   Colors.deepOrangeAccent,
                                 ],
                                   backgroundColor: Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity),
                                 trunkFillColor: Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity),
                                 trunkOutlineColour: Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(opacity),
                                   opacity: 0.5,
                                   trunkWidth: 10.0,
                                   widthDecay: 0.92,
                                   segmentLength: 35.0,
                                   segmentDecay: 0.92,
                                   branch: 0.7,
                                   angle: 0.5,
                                   ratio: 0.7,
                                   bulbousness: 1.9,
                                   maxDepth: 18,
                                   leavesAfter: 10,
                                   leafAngle: 0.7,
                                 leafLength: 8,
                                 randomLeafLength : 18,
                                 leafSquareness : 1,
                                 leafDecay : 0.99,

                               ),);

void changeTrunkWidth( var value){
state.trunkWidth = value;
emit(state);
}
  }
}