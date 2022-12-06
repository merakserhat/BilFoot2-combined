import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/views/screens/phone_number_page/phone_number_page.dart';
import 'package:bilfoot/views/screens/phone_number_page/phone_number_settings_page.dart';
import 'package:bilfoot/views/widgets/modals/base_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

enum PhoneModalText {
  announcementText,
  whatsappButtonText,
}

class SetPhoneModal extends StatelessWidget {
  const SetPhoneModal({Key? key, required this.phoneModalText})
      : super(key: key);

  final PhoneModalText phoneModalText;
  @override
  Widget build(BuildContext context) {
    return BaseModal(
        type: Type.ANSWERABLE,
        text: _getModalText(),
        //icon: //findicon,
        accepButtonText: "Numaramı Ekle",
        onAccepted: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const PhoneNumberSettingsPage()));
        },
        onRefused: () {
          Navigator.of(context).pop();
        },
        refuseButtonText: "Şimdi Değil",
        icon: const Icon(
          Icons.whatsapp,
          color: Color(0xFF25D366),
        ));
  }

  String _getModalText() {
    switch (phoneModalText) {
      case PhoneModalText.announcementText:
        return "Diğer oyuncuların ilanına daha kolay yanıt verebilmesi için numaranı ekleyebilirsin.\n\nSadece kabul ettiğin kişiler ilanlardan numarana erişebilir.";
      case PhoneModalText.whatsappButtonText:
        return "Telefon numaranı ekleyerek birlikte oynamak istediğiniz kişiler ile daha kolay iletişim kurabilirsiniz.\n\nSadece bağlantılı olduğunuz kişiler numaranızı görebilir.";
      default:
        return "Phone text not found";
    }
  }
}
