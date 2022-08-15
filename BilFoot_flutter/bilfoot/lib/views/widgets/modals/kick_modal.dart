import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/foundation/key.dart';

import 'package:flutter/src/widgets/framework.dart';

class KickModal extends StatelessWidget {
  const KickModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseModal(
        type: Type.ANSWERABLE,
        text: "Oyuncuyu takımdan atmak istiyor musun?",
        //icon: //findicon,
        accepButtonText: "Evet",
        onAccepted: () {
          //TODO:
        },
        onRefused: () {
          //TODO:
        },
        refuseButtonText: "Hayır",
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ));
  }
}
