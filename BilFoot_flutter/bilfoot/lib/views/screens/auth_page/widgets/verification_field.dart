import "package:flutter/material.dart";

import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationField extends StatefulWidget {
  final TextEditingController textEditingController;

  const VerificationField({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  _VerificationFieldState createState() => _VerificationFieldState();
}

class _VerificationFieldState extends State<VerificationField> {
  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).primaryColor;
    final boxColor = Theme.of(context).primaryColor.withOpacity(0.3);

    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PinCodeTextField(
          appContext: context,
          length: 6,
          enableActiveFill: true,
          enablePinAutofill: true,
          controller: widget.textEditingController,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            borderWidth: 1,
            fieldHeight: width * 0.12,
            fieldWidth: width * 0.12,
            selectedColor: borderColor,
            inactiveColor: borderColor,
            inactiveFillColor: boxColor,
            activeColor: boxColor,
            errorBorderColor: boxColor,
            activeFillColor: boxColor,
            selectedFillColor: boxColor,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {}),
    );
  }
}
