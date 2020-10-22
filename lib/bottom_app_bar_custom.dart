import 'package:flutter/material.dart';

bool randomiseButtonEnabled = true;
bool randomisePaletteButtonEnabled = true;
Widget CustomBottomAppBar(
    {Function randomise, Function randomisePalette, Function showBottomSheet})  {
  return ButtonBar(alignment: MainAxisAlignment.spaceAround,

        children: <Widget>[

          FlatButton(
            splashColor: Colors.white,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            color: Color.fromRGBO(58, 90, 128, 1),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.ltr,
              children: <Widget>[

                Icon(Icons.refresh,color: Colors.white,),
                SizedBox(width: 3),

                Text('Randomise\nEverything',textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                  ),
                ),
              ],
            ),
            onPressed: ()async {
             if(randomiseButtonEnabled) {
               randomise();
               randomiseButtonEnabled =false;
               await new Future.delayed(const Duration(seconds: 1));
               randomiseButtonEnabled = true;
             }
            },
          ),
          FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            color: Color.fromRGBO(58, 90, 128, 1),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.ltr,
              children: <Widget>[

                Icon(Icons.blur_circular,color: Colors.white,),
                SizedBox(width: 3),

                Text('Tools',
                  style: TextStyle(color: Colors.white,
                  ),
                ),
              ],
            ),
            onPressed: () {showBottomSheet();
            },
          ),FlatButton(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
            color: Color.fromRGBO(58, 90, 128, 1),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.ltr,
              children: <Widget>[

                Icon(Icons.palette,color: Colors.white,),
                SizedBox(width: 3),

                Text('Randomise'
                    '\nPalette',textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                  ),
                ),
              ],
            ),
            onPressed: ()async {
              if(randomisePaletteButtonEnabled) {
                randomisePalette();
                randomisePaletteButtonEnabled =false;
                await new Future.delayed(const Duration(seconds: 1));
                randomisePaletteButtonEnabled = true;
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
      );
}
