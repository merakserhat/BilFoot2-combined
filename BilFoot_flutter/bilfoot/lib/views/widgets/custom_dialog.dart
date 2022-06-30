import "package:flutter/material.dart";

enum DialogType { warning, confirmation }

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.description,
    this.dialogType = DialogType.confirmation,
    this.onConfirm,
    this.onCancel,
    this.confirmationText = "Yes",
    this.title,
  }) : super(key: key);

  final String description;
  final String? title;
  final DialogType dialogType;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String confirmationText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context).textTheme.headline3,
            )
          : null,
      content: Text(description),
      actions: getActions(context),
    );
  }

  List<Widget> getActions(BuildContext context) {
    if (dialogType == DialogType.confirmation) {
      return [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) {
              onCancel!();
            }
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onConfirm != null) {
              onConfirm!();
            }
          },
          child: Text(confirmationText),
        ),
      ];
    } else {
      return [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Ok"),
        ),
      ];
    }
  }
}
