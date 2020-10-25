import 'package:flutter/material.dart';

class settingsSlider extends StatefulWidget {
  String label;
  String tooltip;
  double currentValue;
  double min;
  double max;
  bool locked;
  double zoom;
  Function onChanged;
  Function toggleLock;
  Function updateCache;

  settingsSlider(this.label, this.tooltip, this.currentValue, this.min,
      this.max, this.locked, this.zoom, this.onChanged, this.toggleLock,this.updateCache );

  @override
  _settingsSliderState createState() => _settingsSliderState();
}

// calculate the min of the zoom slider
double zoomMin (double min, double max, double value, double zoom) {
  double zoomRange = (max-min)/zoom;
  // if the value is within zoomRange of the min, then the min is the min
  if (value - min < zoomRange){
    return min;
  }
  else{
    return value - zoomRange;
  }
}

// calculate the max of the zoom slider
double zoomMax (double min, double max, double value, double zoom) {
  double zoomRange = (max-min)/zoom;
  // if the value is within zoomRange of the max, then the max is the max
  if (max - value < zoomRange){
    return max;
  }
  else{
    return value + zoomRange;
  }
}



class _settingsSliderState extends State<settingsSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min,
     // padding: const EdgeInsets.all(8),
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
                  'Don''t Randomize',
                ),
                Checkbox(
                  value: widget.locked,
                  onChanged: widget.toggleLock,
                ),
              ],
            )),
        Container(
          height: 50,
          child: Row(
            children: [
              Text(widget.min.toStringAsFixed(1)),

              Expanded(
                child: Slider(
                  activeColor: Colors.blue[600],
                  onChangeEnd: (double) {
                    widget.updateCache();
                  },
                  value: widget.currentValue,
                  min: widget.min,
                  max: widget.max,
                  onChanged: widget.locked ? null : widget.onChanged,
                  label: widget.currentValue.round().toString(),
                ),
              ),
              Text(widget.max.toStringAsFixed(1)),
            ],
          ),
        ),
        (widget.zoom > 0) ? Container(
          height: 50,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                child: Text(zoomMin(widget.min,widget.max,widget.currentValue, widget.zoom).toStringAsFixed(3)),
              ),

              Expanded(
                child: Slider(
                  activeColor: Colors.blue[300],
                  onChangeEnd: (double) {
                    print('*********** should update cache');
                    widget.updateCache();
                  },
                  value: widget.currentValue,
                  min: zoomMin(widget.min,widget.max,widget.currentValue, widget.zoom),
                  max: zoomMax(widget.min,widget.max,widget.currentValue, widget.zoom),
                  onChanged: widget.locked ? null : widget.onChanged,
                  label: widget.currentValue.round().toString(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,20,0),
                child: Text(zoomMax(widget.min,widget.max,widget.currentValue, widget.zoom).toStringAsFixed(3)),
              ),
            ],
          ),
        )
            : null,
      ],
    );
  }
}
