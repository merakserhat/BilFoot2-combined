import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ValidationModal extends StatelessWidget {
  final VoidCallback onAccepted;
  final String text;

  const ValidationModal(
      {Key? key, required this.onAccepted, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseModal(
        type: Type.ANSWERABLE,
        text: text,
        accepButtonText: "Evet",
        onAccepted: onAccepted,
        color: Theme.of(context).primaryColor,
        onRefused: () {
          Navigator.of(context).pop();
        },
        refuseButtonText: "Hayır",
        icon: Icon(
          Icons.question_mark_rounded,
          color: Theme.of(context).primaryColor,
        ));
  }
}
