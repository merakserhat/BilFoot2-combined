import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/foundation/key.dart';

import 'package:flutter/src/widgets/framework.dart';

class QuitModal extends StatelessWidget {
  const QuitModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseModal(
        type: Type.ANSWERABLE,
        text: "Takımdan ayrılmak istiyor musun?",
        //icon: //findicon,
        accepButtonText: "Evet",
        onAccepted: () {
          //TODO:
        },
        onRefused: () {
          //TODO:
        },
        refuseButtonText: "Hayır",
        icon: const Icon(
          Icons.question_mark,
          color: Colors.red,
        ));
  }
}
