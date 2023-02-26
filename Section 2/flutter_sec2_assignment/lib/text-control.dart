import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextControl extends StatelessWidget {
  final VoidCallback _changeTextFunc;

  const TextControl(this._changeTextFunc);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: this._changeTextFunc, icon: Icon(Icons.navigate_next));
  }
}
