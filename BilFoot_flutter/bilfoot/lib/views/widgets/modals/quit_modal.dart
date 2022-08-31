import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuitModal extends StatelessWidget {
  final VoidCallback onAccepted;
  final bool quitMatch;

  const QuitModal({Key? key, required this.onAccepted, this.quitMatch = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseModal(
        type: Type.ANSWERABLE,
        text: quitMatch
            ? "Maçtan ayrılmak istiyor musun?"
            : "Takımdan ayrılmak istiyor musun?",
        //icon: //findicon,
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
