import 'package:flutter/material.dart';
import 'model.dart';

Widget CustomBottomAppBar(
    {Function randomise, Function randomisePalette, Function showToolBox}) {
  return Container(
      height: 70,
      child: GestureDetector(
      onVerticalDragUpdate: (value) {
    showToolBox();
  },child: 
    ButtonBar(
    alignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      FlatButton(
        splashColor: Colors.white,

        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        color: Colors.blue[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            SizedBox(width: 3),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Randomise\nEverything',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        onPressed: () async {
          if (enableButton) {
            randomise();
            enableButton = false;

          }
        },
      ),
      FlatButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        color: Colors.blue[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Icon(
              Icons.blur_circular,
              color: Colors.black,
            ),
            SizedBox(width: 3),
            Text(
              'Tools',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        onPressed: () {
          showToolBox();
        },
      ),
      FlatButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        color: Colors.blue[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Icon(
              Icons.palette,
              color: Colors.black,
            ),
            SizedBox(width: 3),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Randomise'
                    '\nPalette',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        onPressed: () async {
          if (enableButton) {
            randomisePalette();
            enableButton = false;

          }
        },
      ),
      // RaisedButton.icon(
      //   splashColor: Colors.red,
      //   animationDuration: Duration(milliseconds: 10),
      //   onPressed: () {
      //     randomise();
      //   },
      //   icon: Icon(Icons.refresh),
      //   label: Text(
      //     'Randomise',
      //     textAlign: TextAlign.center,
      //   ),
      // ),

      // IconButton(
      //   onPressed: () {
      //     randomise();
      //
      //   },
      //  // icon: Icon(Icons.refresh),
      //   // child: Row(
      //   //   children: <Widget>[
      //   //     Icon(Icons.refresh),
      //   //     Padding(
      //   //       padding: const EdgeInsets.all(8.0),
      //   //       child: Text(
      //   //         'Randomise \nEverything',
      //   //         textAlign: TextAlign.center,
      //   //       ),
      //   //     )
      //   //   ],
      //   // ),
      // ),
      // OutlineButton(
      //     onPressed: () {
      //       showBottomSheet();
      //     },
      //     child: Row(
      //       children: <Widget>[
      //         Icon(Icons.blur_circular),
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Text(
      //             'Tools',
      //             textAlign: TextAlign.center,
      //           ),
      //         )
      //       ],
      //     )),
      // GestureDetector(
      //   onTap: () {
      //     randomisePalette();
      //   },
      //   child: Row(
      //     children: <Widget>[
      //       Icon(Icons.palette),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text(
      //           'new palette',
      //           textAlign: TextAlign.center,
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // IconButton(
      //   onPressed: () {
      //     randomisePalette();
      //
      //   },
      //   icon: Icon(Icons.palette),
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
      // )
    ],
    )));
}