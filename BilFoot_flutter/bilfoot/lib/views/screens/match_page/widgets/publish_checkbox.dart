import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class PublishCheckbox extends StatefulWidget {
  final Function(bool?) onChanged;
  final bool defaultValue;

  const PublishCheckbox(
      {Key? key, required this.onChanged, this.defaultValue = false})
      : super(key: key);

  @override
  _PublishCheckboxState createState() => _PublishCheckboxState();
}

class _PublishCheckboxState extends State<PublishCheckbox> {
  late bool publishSigned;

  @override
  void initState() {
    super.initState();
    publishSigned = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: Theme.of(context).primaryColor,
      value: publishSigned,
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      visualDensity: VisualDensity.compact,
      onChanged: (value) {
        setState(() {
          publishSigned = value ?? false;
          widget.onChanged(value);
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        "Publish Match",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
