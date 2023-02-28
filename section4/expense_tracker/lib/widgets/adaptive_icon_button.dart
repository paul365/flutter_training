import 'dart:io';

import 'package:flutter/material.dart';

class AdaptiveIconButton extends StatelessWidget {
  final Function _actionFunction;
  final IconData _materialIcon;
  final IconData _cupertinoIcon;

  const AdaptiveIconButton(
      this._actionFunction, this._materialIcon, this._cupertinoIcon);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: () => _actionFunction(context), child: Icon(_cupertinoIcon))
        : IconButton(
            onPressed: () => _actionFunction(context),
            icon: Icon(_materialIcon));
  }
}
