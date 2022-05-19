import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ProgramConstants {
  static const EdgeInsets pagePadding =
      EdgeInsets.symmetric(vertical: 16, horizontal: 24);

  static List<BoxShadow>? getDefaultBoxShadow(BuildContext context) {
    return AdaptiveTheme.of(context).theme ==
            AdaptiveTheme.of(context).lightTheme
        ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]
        : [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]; //null instead
  }
}
