import 'package:flutter/material.dart';

Widget CustomBottomAppBar({Function randomise, Function randomisePalette,  Function showBottomSheet}){
  return BottomAppBar(
      color: Colors.white,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            onPressed: () {
              randomise();

            },
            icon: Icon(Icons.refresh),
            // child: Row(
            //   children: <Widget>[
            //     Icon(Icons.refresh),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //         'Randomise \nEverything',
            //         textAlign: TextAlign.center,
            //       ),
            //     )
            //   ],
            // ),
          ),
          OutlineButton(
              onPressed: () {

                showBottomSheet();
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.blur_circular),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tools',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )),
          IconButton(
            onPressed: () {
              randomisePalette();

            },
            icon: Icon(Icons.palette),
            // child: Row(
            //   children: <Widget>[
            //     Icon(Icons.palette),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //         'Randomise \nPalette',
            //         textAlign: TextAlign.center,
            //       ),
            //     )
            //   ],
            // ),
          )
        ],
      ));

}