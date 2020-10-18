import 'package:flutter/material.dart';


class settingsSlider2 extends StatefulWidget {
  String label;
  String tooltip;
  double currentValue;
  double min;
  double max;
  bool locked;
  Function onChanged;
  Function toggleLock;


  settingsSlider2(this.label, this.tooltip, this.currentValue, this.min, this.max, this.locked, this.onChanged, this.toggleLock);

  @override
  _settingsSlider2State createState() => _settingsSlider2State();
}

class _settingsSlider2State extends State<settingsSlider2> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
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

          child:   Slider(
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
