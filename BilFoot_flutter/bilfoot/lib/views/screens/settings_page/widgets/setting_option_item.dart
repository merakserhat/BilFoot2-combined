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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Material(
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          onTap: onClick,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
        ),
      ),
    );
  }
}
