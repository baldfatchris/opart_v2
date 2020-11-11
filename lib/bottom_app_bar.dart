import 'package:flutter/material.dart';
import 'bottom_sheet_palette.dart';
import 'model_opart.dart';
import 'toolbox.dart';
import 'canvas.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:opart_v2/tab_palette.dart';
import 'opart_page.dart';
import 'toolbox_palette.dart';

Widget customBottomAppBar({BuildContext context, OpArt opArt}) {
  double width = MediaQuery.of(context).size.width;
  print('width: $width');

  return Container(
      color: Colors.white.withOpacity(0.8),
      height: 70,
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            color: Colors.cyan[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Icon(
                  MdiIcons.tools,
                  color: Colors.black,
                ),
                (width > 400) ? SizedBox(width: 3) : Container(),
                (width > 400)
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Tool\nBox',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            onPressed: () {
              if (animationController != null){
                animationController.stop();
              }
              ToolBox(
                context,
                opArt,
              );
            },
          ),
          FlatButton(
            splashColor: Colors.white,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            color: Colors.cyan[50],
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Icon(
                  MdiIcons.autoFix,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(width: 3),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Randomize\nEverything',
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
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Icon(
                  Icons.palette,
                  color: Colors.black,
                ),
                (width > 400) ? SizedBox(width: 3) : Container(),
                (width > 400)
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Change'
                          '\nColors',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            onPressed: () {
             // BottomSheetPalette(context);
              animationController.stop();
              PaletteToolBox(
                context,
                opArt,
              );
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
      ));
}
