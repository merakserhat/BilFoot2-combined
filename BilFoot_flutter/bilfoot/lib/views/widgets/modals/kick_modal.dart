import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class KickModal extends StatelessWidget {
  final VoidCallback onAccepted;
  final PlayerModel playerModel;
  final bool kickFromMatch;

  const KickModal(
      {Key? key,
      required this.onAccepted,
      required this.playerModel,
      this.kickFromMatch = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseModal(
        type: Type.ANSWERABLE,
        text:
            "${playerModel.fullName} adlı oyuncuyu ${kickFromMatch ? "maçtan" : "takımdan"} atmak istiyor musun?",
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
