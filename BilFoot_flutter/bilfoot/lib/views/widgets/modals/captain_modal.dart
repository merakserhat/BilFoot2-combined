import 'dart:ffi';

import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CaptainModal extends StatelessWidget {
  final VoidCallback onAccepted;

  const CaptainModal({Key? key, required this.onAccepted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseModal(
      type: Type.ANSWERABLE,
      text: "Oyuncuyu kaptan yapmak istiyor musun?",
      accepButtonText: "Evet",
      onAccepted: onAccepted,
      onRefused: () {
        Navigator.of(context).pop();
      },
      refuseButtonText: "Hayır",
      child: const Text(
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
