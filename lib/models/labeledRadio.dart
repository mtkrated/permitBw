import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(5.0),
        decoration: myBoxDecoration(),
      child: InkWell(
        onTap: () {
          if (value != groupValue) onChanged(value);
        },
        child: Padding(
          padding: padding,
          child: Row(
            children: <Widget>[
              Radio<bool>(
                groupValue: groupValue,
                value: value,
                onChanged: (bool newValue) {
                  onChanged(newValue);
                },
              ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}