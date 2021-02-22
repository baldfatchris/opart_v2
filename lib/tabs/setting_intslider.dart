import 'package:flutter/material.dart';


class SettingsIntSlider extends StatefulWidget {
  final String label;
  final String tooltip;
  final int currentValue;
  final int min;
  final int max;
  final bool locked;
  final Function onChanged;
  final Function toggleLock;
  final Function updateCache;


  SettingsIntSlider(this.label, this.tooltip, this.currentValue, this.min, this.max, this.locked, this.onChanged, this.toggleLock, this.updateCache);

  @override
  _SettingsIntSliderState createState() => _SettingsIntSliderState();
}

class _SettingsIntSliderState extends State<SettingsIntSlider> {

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
            )),

        Container(
          height: 50,
          child:   Slider(
            onChangeEnd: (value){widget.updateCache();},
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
