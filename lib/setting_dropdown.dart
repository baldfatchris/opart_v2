import 'package:flutter/material.dart';

class settingsDropdown extends StatefulWidget {
  String label;
  String tooltip;
  String currentValue;
  List<String> dropdownItems;
  bool locked;
  Function onChanged;
  Function toggleLock;

  settingsDropdown(this.label, this.tooltip, this.currentValue, this.dropdownItems, this.locked, this.onChanged, this.toggleLock);


  
  @override
  _settingsDropdownState createState() => _settingsDropdownState();
}






class _settingsDropdownState extends State<settingsDropdown> {
  
  @override
  Widget build(BuildContext context) {

    if (!widget.dropdownItems.contains(widget.currentValue.toString())){
      widget.dropdownItems.insert(0, widget.currentValue.toString());
    }


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


            child: DropdownButton<String>(
              value: widget.currentValue,
              isDense: true,
              isExpanded: true,
              items: widget.dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              onChanged: widget.locked ? null : (String value) {
                widget.onChanged(value);
                Navigator.pop(context);
              },

            )

        ),
      ],
    );


  }
}
