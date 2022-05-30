import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class RememberMeCheckbox extends StatefulWidget {
  final Function(bool?) onChanged;

  const RememberMeCheckbox({Key? key, required this.onChanged})
      : super(key: key);

  @override
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool rememberMeSigned = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: Theme.of(context).primaryColor,
      value: rememberMeSigned,
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      visualDensity: VisualDensity.compact,
      onChanged: (value) {
        setState(() {
          rememberMeSigned = value ?? false;
          widget.onChanged(value);
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        "Remember me",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
