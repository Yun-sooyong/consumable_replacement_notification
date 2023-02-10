import 'package:flutter/material.dart';

class Classify {
  String title;
  bool isSelected;

  Classify(this.title, this.isSelected);
}

class CustomRadio extends StatelessWidget {
  final Classify _classify;
  const CustomRadio(this._classify, {super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    return Card(
      color: _classify.isSelected ? themeColor.primary : themeColor.background,
      child: Container(
        height: 20,
        width: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
        child: Text(
          _classify.title,
          style: TextStyle(
            color: _classify.isSelected
                ? themeColor.background
                : themeColor.primary,
          ),
        ),
      ),
    );
  }
}
