import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservedCheckbox extends StatefulWidget {
  final Function(bool?) onChanged;
  final bool defaultValue;

  const ReservedCheckbox(
      {Key? key, required this.onChanged, this.defaultValue = false})
      : super(key: key);

  @override
  _ReservedCheckboxState createState() => _ReservedCheckboxState();
}

class _ReservedCheckboxState extends State<ReservedCheckbox> {
  late bool reservedSigned;

  @override
  void initState() {
    super.initState();
    reservedSigned = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: Theme.of(context).primaryColor,
      value: reservedSigned,
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      visualDensity: VisualDensity.compact,
      onChanged: (value) {
        setState(() {
          reservedSigned = value ?? false;
          widget.onChanged(value);
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        "Pitch is reserved",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
