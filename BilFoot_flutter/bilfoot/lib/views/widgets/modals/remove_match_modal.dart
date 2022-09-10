import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';

class RemoveMatchModal extends StatelessWidget {
  final VoidCallback onAccepted;

  const RemoveMatchModal({Key? key, required this.onAccepted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseModal(
        type: Type.ANSWERABLE,
        text: "Bu maçı silmek istiyor musun?",
        accepButtonText: "Evet",
        onAccepted: onAccepted,
        color: Theme.of(context).errorColor,
        onRefused: () {
          Navigator.of(context).pop();
        },
        refuseButtonText: "Hayır",
        icon: Icon(
          Icons.warning_outlined,
          color: Theme.of(context).errorColor,
        ));
  }
}
