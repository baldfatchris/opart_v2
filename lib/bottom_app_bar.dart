import 'package:flutter/material.dart';

import 'model_opart.dart';

import 'canvas.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'opart_page.dart';


Widget customBottomAppBar({BuildContext context, OpArt opArt}) {
  double width = MediaQuery.of(context).size.width;
  print('width: $width');

  return Container(
    //  color: Colors.white.withOpacity(0.8),
      height: 70,
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(width: (width > 400) ?110: 50,
            child: FlatButton(
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              color: Colors.white.withOpacity(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Icon(
                    MdiIcons.shape,
                    color: Colors.cyan,
                  ),
                  (width > 400) ? SizedBox(width: 3) : Container(),
                  (width > 400)
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Random\nShape',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : Container(),
                ],
              ),
              onPressed: () {
                if (enableButton) {
                  opArt.randomizeSettings();
                  // opArt.randomizePalette();
                  opArt.saveToCache();
                  enableButton = false;
                //
                //   opArt.randomizeSettings();
                //   opArt.saveToCache();
                //   enableButton = false;
                  rebuildCanvas.value++;

                }
              },
            ),
          ),
          FlatButton(
            splashColor: Colors.white,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            color: Colors.white.withOpacity(0.8),
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Icon(
                  MdiIcons.autoFix,
                  color: Colors.cyan,
                  size: 30,
                ),
                SizedBox(width: 3),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Go\nWild!',
                    style: TextStyle(color: Colors.black),
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
                rebuildCanvas.value++;

              }
            },
          ),
          Container(width: (width > 400) ?110: 50,
            child: FlatButton(
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
              color: Colors.white.withOpacity(0.8),
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Icon(
                    Icons.palette,
                    color: Colors.cyan,
                  ),
                  (width > 400) ? SizedBox(width: 3) : Container(),
                  (width > 400)
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Random\nColors',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : Container(),
                ],
              ),
              onPressed: () {
                if (enableButton) {
                  opArt.randomizePalette();
                  opArt.saveToCache();
                  enableButton = false;
                  rebuildCanvas.value++;

                }
               // BottomSheetPalette(context);
               // if (animationController != null) {
               //   animationController.stop();
               // }
                // PaletteToolBox(
                //   context,
                //   opArt,
                // );

              },
            ),
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
          //   //         'Go Wild!',
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
      ));
}

