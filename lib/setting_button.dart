import 'package:flutter/material.dart';


class settingsButton extends StatefulWidget {
  String label;
  String tooltip;
  bool currentValue;
  Function onPressed;

  settingsButton(this.label, this.tooltip, this.currentValue, this.onPressed);

  @override
  _settingsButtonState createState() => _settingsButtonState();
}

class _settingsButtonState extends State<settingsButton> {

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
            onPressed: widget.onPressed,
            child: Text(widget.label),
          ),

        ),
      ],
    );

  }
}
