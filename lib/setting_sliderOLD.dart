import 'package:flutter/material.dart';


class settingsSliderOLD extends StatefulWidget {
  String label;
  double currentValue;
  double min;
  double max;
  bool locked;
  Function onChanged;
  Function toggleLock;


  settingsSliderOLD(this.label, this.currentValue, this.min, this.max, this.locked, this.onChanged, this.toggleLock);

  @override
  _settingsSliderOLDState createState() => _settingsSliderOLDState();
}

class _settingsSliderOLDState extends State<settingsSliderOLD> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 2,
            child: GestureDetector(
                onLongPress: widget.toggleLock,
                child: Row(
                  children:[
                    Text(
                      widget.label,
                      style: widget.locked ? TextStyle(fontWeight: FontWeight.normal) : TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      widget.locked ? Icons.lock : Icons.lock_open,
                      size: 20,
                      color: widget.locked ? Colors.grey : Colors.black,
                    ),
                  ],
                )
            )
        ),
        Flexible(
          flex: 3,
          child: Slider(
            value: widget.currentValue,
            min: widget.min,
            max: widget.max,
            onChanged: widget.locked ? null : widget.onChanged,
            label: '${widget.label}',
          ),
        ),
      ],
    );
  }
}
