import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/widgets/bilfoot_button.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import 'package:flutter/material.dart';
import 'package:bilfoot/views/themes/my_themes.dart';

// ignore_for_file: constant_identifier_names
enum Type { ANSWERABLE, UNANSWERABLE }

///Base Component to show a panel above the blurry background
class BaseModal extends StatefulWidget {
  const BaseModal(
      {Key? key,
      this.child,
      required this.type,
      required this.text,
      this.icon,
      required this.onAccepted,
      required this.onRefused,
      this.color,
      this.accepButtonText,
      this.refuseButtonText})
      : super(key: key);
  final Widget? child;
  final Type type;
  final String text;
  final Widget? icon;
  final Function onAccepted;
  final VoidCallback onRefused;
  final String? accepButtonText;
  final String? refuseButtonText;
  final Color? color;

  @override
  State<BaseModal> createState() => _BaseModalState();
}

class _BaseModalState extends State<BaseModal> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: ProgramConstants.getDefaultBoxShadow(context),
                  color: Colors.white),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: (widget.icon == null)
                              ? widget.child
                              : widget.icon,
                        ),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        widget.text,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            (widget.type == Type.ANSWERABLE)
                ? isLoading
                    ? const SpinnerSmall()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: widget.onRefused,
                              child: Text(widget.refuseButtonText as String,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black87))),
                          BilfootButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await widget.onAccepted();

                              setState(() {
                                isLoading = false;
                              });
                            },
                            label: widget.accepButtonText as String,
                            color: widget.color,
                          )
                        ],
                      )
                : ElevatedButton(
                    onPressed: () => widget.onAccepted, child: Text("Tamam"))
          ],
        ),
      ),
    );
  }
}
