import 'package:flutter/material.dart';


class settingsRadioButton extends StatefulWidget {
  String label;
  String tooltip;
  bool currentValue;
  bool locked;
  Function onChanged;
  Function toggleLock;

  settingsRadioButton(this.label, this.tooltip, this.currentValue, this.locked, this.onChanged, this.toggleLock);

  @override
  _settingsRadioButtonState createState() => _settingsRadioButtonState();
}

class _settingsRadioButtonState extends State<settingsRadioButton> {

  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 50,

          child: Text(
            widget.label,
            style: widget.locked ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 50,

          child: Text(
            widget.tooltip,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
        Container(
            height: 50,

            child: Row(
              children:[
                Text(
                  'Lock',
                  style: widget.locked ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(
                  widget.locked ? Icons.lock : Icons.lock_open,
                  size: 20,
                  color: widget.locked ? Colors.grey : Colors.black,
                ),
              ],
            )
        ),
        Container(
          height: 50,

          child:   Switch(
              value: widget.currentValue,
              onChanged: widget.locked ? null : widget.onChanged
          ),

        ),
      ],
    );

  }
}
