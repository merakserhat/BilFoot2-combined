import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput(
      {Key? key,
      this.initialNumber,
      required this.controller,
      required this.setNumber})
      : super(key: key);

  final String? initialNumber;
  final TextEditingController controller;
  final Function(PhoneNumber phoneNumber) setNumber;

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  String initialCountry = 'TR';
  late PhoneNumber number;

  @override
  void initState() {
    super.initState();
    if (widget.initialNumber != null) {
      _setInitialCountry();
    }
    number = PhoneNumber(isoCode: initialCountry);
  }

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        widget.setNumber(number);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: Theme.of(context).textTheme.headline3,
      initialValue: number,
      textFieldController: widget.controller,
      formatInput: true,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: InputBorder.none,
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }

  void _setInitialCountry() async {
    number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(widget.initialNumber!);
    setState(() {});
  }
}
