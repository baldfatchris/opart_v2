import 'package:flutter/material.dart';


class settingsDropdown extends StatefulWidget {
  String label;
  String currentValue;
  List<String> dropdownItems;
  double max;
  bool locked;
  Function onChanged;
  Function toggleLock;

  settingsDropdown(this.label, this.currentValue, this.dropdownItems, this.locked, this.onChanged, this.toggleLock);

  @override
  _settingsDropdownState createState() => _settingsDropdownState();
}

class _settingsDropdownState extends State<settingsDropdown> {
  
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 1,
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
          flex: 2,

          child: DropdownButton<String>(
            value: widget.currentValue,
            onChanged: widget.locked ? null : widget.onChanged,
            items: widget.dropdownItems
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),

          )

        ),
      ],
    );
  }
}
