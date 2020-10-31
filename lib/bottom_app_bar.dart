import 'package:flutter/material.dart';
import 'model_opart.dart';
import 'toolbox.dart';
import 'canvas.dart';

Widget customBottomAppBar(
    {BuildContext context, OpArt opArt}) {
  return Container(color: Colors.white.withOpacity(0.8),
    
      height: 70,
      child: GestureDetector(
      onVerticalDragUpdate: (value) {
    ToolBox(context, opArt);
  },child: 
    ButtonBar(
    alignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      FlatButton(
        splashColor: Colors.white,

        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        color: Colors.cyan[200],
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
                'randomize\nEverything',
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
            opArt.randomizeSettings();
            opArt.randomizePalette();
            opArt.saveToCache();
            enableButton = false;
          }
        },
      ),
      FlatButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        color: Colors.cyan[200],
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
          playPauseController.forward(from: 0);
          playing = false;
          animationController.stop();
          ToolBox(context, opArt, );
        },
      ),
      FlatButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        color: Colors.cyan[200],
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
                'randomize'
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

            opArt.randomizePalette();
            opArt.saveToCache();
           enableButton = false;

          }
        },
      ),
      // RaisedButton.icon(
      //   splashColor: Colors.red,
      //   animationDuration: Duration(milliseconds: 10),
      //   onPressed: () {
      //     randomize();
      //   },
      //   icon: Icon(Icons.refresh),
      //   label: Text(
      //     'randomize',
      //     textAlign: TextAlign.center,
      //   ),
      // ),

      // IconButton(
      //   onPressed: () {
      //     randomize();
      //
      //   },
      //  // icon: Icon(Icons.refresh),
      //   // child: Row(
      //   //   children: <Widget>[
      //   //     Icon(Icons.refresh),
      //   //     Padding(
      //   //       padding: const EdgeInsets.all(8.0),
      //   //       child: Text(
      //   //         'randomize \nEverything',
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
      //     randomizePalette();
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
      //     randomizePalette();
      //
      //   },
      //   icon: Icon(Icons.palette),
      // child: Row(
      //   children: <Widget>[
      //     Icon(Icons.palette),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(
      //         'randomize \nPalette',
      //         textAlign: TextAlign.center,
      //       ),
      //     )
      //   ],
      // ),
      // )
    ],
    )));
}