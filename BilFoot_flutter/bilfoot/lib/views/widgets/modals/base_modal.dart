import 'package:bilfoot/config/constants/program_constants.dart';
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
      this.onAccepted,
      this.onRefused,
      this.accepButtonText,
      this.refuseButtonText})
      : super(key: key);
  final Widget? child;
  final Type type;
  final String text;
  final Widget? icon;
  final Function? onAccepted;
  final Function? onRefused;
  final String? accepButtonText;
  final String? refuseButtonText;

  @override
  State<BaseModal> createState() => _BaseModalState();
}

class _BaseModalState extends State<BaseModal> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                        child:
                            (widget.icon == null) ? widget.child : widget.icon,
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
          SizedBox(
            height: 16,
          ),
          (widget.type == Type.ANSWERABLE)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () => widget.onAccepted,
                        child: Text(widget.accepButtonText as String)),
                    TextButton(
                        onPressed: () => widget.onRefused,
                        child: Text(widget.refuseButtonText as String))
                  ],
                )
              : const SizedBox(
                  height: 0,
                )
        ],
      ),
    );
  }
}
