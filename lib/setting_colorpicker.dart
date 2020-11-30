import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';



class SettingsColorPicker extends StatefulWidget {
  String label;
  String tooltip;
  Color currentValue;
  bool locked;
  Function onChanged;
  Function toggleLock;

  SettingsColorPicker(this.label, this.tooltip, this.currentValue, this.locked, this.onChanged, this.toggleLock);

  @override
  _SettingsColorPickerState createState() => _SettingsColorPickerState();
}

class _SettingsColorPickerState extends State<SettingsColorPicker> {

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

        Container(
          height: 200,

          child:   ColorPicker(
            displayThumbColor: false,
            pickerAreaHeightPercent: 0.3,
            pickerAreaBorderRadius: BorderRadius.circular(10.0),
            pickerColor: widget.currentValue,
            onColorChanged: widget.locked ? null : widget.onChanged,
            showLabel: false,
          )

        ),
      ],
    );

  }
}
