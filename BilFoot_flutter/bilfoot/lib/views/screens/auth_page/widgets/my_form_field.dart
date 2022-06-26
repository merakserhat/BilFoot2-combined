import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class MyFormField extends StatefulWidget {
  final String title;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String)? onChange;
  final bool obscureText;
  final bool usernameError;
  final bool emailError;
  final bool emailErrorForRegister;
  final bool enableOnlyNumberAndLetter;

  const MyFormField(
      {Key? key,
      required this.title,
      this.textInputType,
      required this.textEditingController,
      this.inputFormatters,
      this.onChange,
      this.validator,
      this.usernameError = false,
      this.emailError = false,
      this.obscureText = false,
      this.emailErrorForRegister = false,
      this.enableOnlyNumberAndLetter = false})
      : super(key: key);

  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  String oldValue = "";
  late bool _showPassword;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _showPassword = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 32, 5),
              child: Text(widget.title,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
        TextFormField(
          controller: widget.textEditingController,
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1!.color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          minLines: 1,
          obscureText: _showPassword,
          cursorColor: Theme.of(context).textTheme.headline1!.color,
          keyboardType: widget.textInputType,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.enableOnlyNumberAndLetter
              ? (value) {
                  onChanged(value);
                  if (widget.onChange != null) {
                    widget.onChange!(value);
                  }
                }
              : widget.onChange,
          validator: widget.validator,
          decoration: InputDecoration(
            errorText: widget.usernameError
                ? "Bu kullanıcı adı kullanımda."
                : widget.emailError
                    ? "Bilgilerini kontrol et ve yeniden dene."
                    : widget.emailErrorForRegister
                        ? "Bu e-posta adresi kullanımda."
                        : null,
            isDense: true,
            filled: true,
            suffixIcon: IconButton(
              icon: Visibility(
                visible: widget.obscureText,
                child: Icon(
                  // Based on passwordVisible state choose the icon
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              onPressed: widget.obscureText
                  ? () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    }
                  : null,
            ),
            fillColor: Theme.of(context).colorScheme.onBackground,
            hoverColor: Colors.grey.shade300,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0.0,
                color: Theme.of(context).errorColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0.0,
                color: Theme.of(context).errorColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0.0,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onChanged(String value) {
    RegExp r = RegExp(r'^[A-Za-z0-9_.]+$');

    if (value == "") {
      oldValue = "";
      return;
    }

    if (!r.hasMatch(value)) {
      controller.forward(from: 0);
      widget.textEditingController.text = oldValue;
      widget.textEditingController.selection =
          TextSelection.fromPosition(TextPosition(offset: oldValue.length));
    } else {
      oldValue = value;
    }
  }
}
