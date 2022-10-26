import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NumberSlider extends StatefulWidget {
  const NumberSlider(
      {Key? key, required this.firstNumber, required this.lastNumber})
      : super(key: key);
  final double firstNumber;
  final double lastNumber;

  @override
  State<NumberSlider> createState() => _NumberSliderState();
}

class _NumberSliderState extends State<NumberSlider> {
  var _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Slider(
      min: widget.firstNumber,
      max: widget.lastNumber,
      value: _value,
      divisions: (widget.lastNumber - widget.firstNumber).round(),
      label: '${_value.round()}',
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
    ));
  }
}
