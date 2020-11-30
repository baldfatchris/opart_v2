import 'package:flutter/material.dart';


class SettingsRadioButton extends StatefulWidget {
  String label;
  String tooltip;
  bool currentValue;
  bool locked;
  Function onChanged;
  Function toggleLock;

  SettingsRadioButton(this.label, this.tooltip, this.currentValue, this.locked, this.onChanged, this.toggleLock);

  @override
  _SettingsRadioButtonState createState() => _SettingsRadioButtonState();
}

class _SettingsRadioButtonState extends State<SettingsRadioButton> {

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
            child: Row(
              children: [
                Text(
                  'Don\'t Randomize',
                ),
                Checkbox(
                  value: widget.locked,
                  onChanged: widget.toggleLock,
                ),
              ],
            )
        ),

        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('No'),
            Container(
              height: 50,

              child:   Switch(
                  value: widget.currentValue,
                  onChanged: widget.locked ? null : widget.onChanged
              ),

            ),Text('Yes')
          ],
        ),
      ],
    );

  }
}
