import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/widgets/modals/set_phone_modal.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class WhatsappButton extends StatefulWidget {
  const WhatsappButton({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<WhatsappButton> createState() => _WhatsappButtonState();
}

class _WhatsappButtonState extends State<WhatsappButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(context),
      child: Icon(
        Icons.whatsapp,
        color: Color(!isLoading ? 0xFF25D366 : 0xFF999999),
        size: 32,
      ),
    );
  }

  void onClicked(BuildContext context) async {
    /*if (Program.program.user?.phoneNumber == null) {
      ProgramConstants.showBlurryBackground(
          context: context, child: const SetPhoneModal());
      return;
    }*/

    setState(() {
      isLoading = true;
    });

    String? phoneNumber =
        await BilfootClient().getPhoneNumber(userId: widget.userId);

    setState(() {
      isLoading = false;
    });

    if (phoneNumber != null) {
      //TODO: test this on a real device
      final link = WhatsAppUnilink(
        phoneNumber: phoneNumber,
        text: "Hey! I'm inquiring about the apartment listing",
      );

      await launchUrlString('$link');
      //print(phoneNumber);
    }
  }
}
