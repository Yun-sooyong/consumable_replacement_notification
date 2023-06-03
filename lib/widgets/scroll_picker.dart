import 'package:flutter/material.dart';

class ScrollPicker extends StatefulWidget {
  ScrollPicker({Key? key}) : super(key: key);

  @override
  State<ScrollPicker> createState() => _ScrollPickerState();
}

class _ScrollPickerState extends State<ScrollPicker> {
  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      itemExtent: 50,
      perspective: 0.03,
      //diameterRatio: 2.5,
      children: [],
    );
  }
}

final List<String> _pickerData = [];
