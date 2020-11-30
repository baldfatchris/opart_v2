import 'package:flutter/material.dart';


class SettingsButton extends StatefulWidget {
  String label;
  String tooltip;
  bool currentValue;
  Function onPressed;

  SettingsButton(this.label, this.tooltip, this.currentValue, this.onPressed);

  @override
  _SettingsButtonState createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {

  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 50,

          child: Text(
            widget.tooltip,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),

        Container(
          height: 50,
          child:   RaisedButton(
            onPressed: (){
              widget.onPressed();
              Navigator.pop(context);
            },
            child: Text(widget.label),
          ),

        ),
      ],
    );

  }
}
