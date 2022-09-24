import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../config/constants/program_constants.dart';

class SettingsOptionItem extends StatelessWidget {
  const SettingsOptionItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onClick})
      : super(key: key);
  final String label;
  final IconData icon;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 44,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          boxShadow:
              ProgramConstants.getDefaultBoxShadow(context, smallShadow: true),
          color: Colors.white,
        ),
        child: InkWell(
          onTap: onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Icon(
                icon,
                size: 18,
                color: Colors.blueGrey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
