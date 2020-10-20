import 'package:flutter/material.dart';


class settingsIntSlider extends StatefulWidget {
  String label;
  String tooltip;
  int currentValue;
  int min;
  int max;
  bool locked;
  Function onChanged;
  Function toggleLock;


  settingsIntSlider(this.label, this.tooltip, this.currentValue, this.min, this.max, this.locked, this.onChanged, this.toggleLock);

  @override
  _settingsIntSliderState createState() => _settingsIntSliderState();
}

class _settingsIntSliderState extends State<settingsIntSlider> {

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
                  'Lock',
                ),
                Checkbox(
                  value: widget.locked,
                  onChanged: widget.toggleLock,
                ),
              ],
            )),

        Container(
          height: 50,
          child:   Slider(
            value: widget.currentValue.toDouble(),
            min: widget.min.toDouble(),
            max: widget.max.toDouble(),
            onChanged: widget.locked ? null : widget.onChanged,
            divisions: widget.max-widget.min,
            label: widget.currentValue.round().toString(),
          ),
        ),
          ],
    );
  }
}
