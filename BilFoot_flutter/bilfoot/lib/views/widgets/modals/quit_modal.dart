import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuitModal extends StatelessWidget {
  final VoidCallback onAccepted;

  const QuitModal({Key? key, required this.onAccepted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseModal(
        type: Type.UNANSWERABLE,
        text: "Takımdan ayrılmak istiyor musun?",
        //icon: //findicon,
        accepButtonText: "Evet",
        onAccepted: onAccepted,
        onRefused: () {
          Navigator.of(context).pop();
        },
        refuseButtonText: "Hayır",
        icon: const Icon(
          Icons.warning_outlined,
          color: Colors.red,
        ));
  }
}
