import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservedCheckbox extends StatelessWidget {
  final Function(bool?) onChanged;
  final bool defaultValue;
  final bool disabled;

  const ReservedCheckbox(
      {Key? key,
      required this.onChanged,
      this.defaultValue = false,
      required this.disabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: Opacity(
        opacity: disabled ? 0.3 : 1,
        child: CheckboxListTile(
          activeColor: Theme.of(context).primaryColor,
          value: defaultValue,
          dense: true,
          contentPadding: const EdgeInsets.all(0),
          visualDensity: VisualDensity.compact,
          onChanged: (value) {
            onChanged(value);
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            "Pitch is reserved",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
