import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/foundation/key.dart';

import 'package:flutter/src/widgets/framework.dart';

class CaptainModal extends StatelessWidget {
  const CaptainModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseModal(
      type: Type.ANSWERABLE,
      text: "Oyuncuyu kaptan yapmak istiyor musun?",
      //icon: //findicon,
      accepButtonText: "Evet",
      onAccepted: () {
        //TODO:
      },
      onRefused: () {
        //TODO:
      },
      refuseButtonText: "Hayır",
      child: Text(
        "C",
        style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: "assets/fonts/Poppins-ExtraBold.ttf",
          color: Colors.orange,
        ),
      ),
    );
  }
}
