import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({Key? key}) : super(key: key);

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'TR';
  PhoneNumber number = PhoneNumber(isoCode: 'TR');

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        setState(() {
          this.number = number;
        });
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      validator: validatePhoneNumber,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: Theme.of(context).textTheme.headline3,
      initialValue: number,
      textFieldController: controller,
      formatInput: true,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: InputBorder.none,
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }

  String? validatePhoneNumber(String? number) {
    print(number);
    //TODO: do these validations for other common countries
    if (number == null || number.isEmpty) {
      return "Phone number can not be empty";
    }

    if (number.length != 10) {
      return "Phone number is not valid";
    }

    return null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
