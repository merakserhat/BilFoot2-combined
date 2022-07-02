import 'package:bilfoot/config/constants/program_colors.dart';
import "package:flutter/material.dart";

class CircularButtonInListItem extends StatelessWidget {
  CircularButtonInListItem(
      {Key? key, required this.buttonType, required this.onTap})
      : super(key: key);

  final String buttonType;
  final VoidCallback onTap;

  static const String profileButton = "profile";
  static const String kickButton = "kick";
  static const String captainButton = "captain";
  static const String inviteButton = "invite";
  static const String teamButton = "team";
  static const String authButton = "auth";

  final Map<String, Map<String, dynamic>> buttonData = {
    profileButton: {
      "color": Colors.blue,
      "icon": Icons.person,
    },
    captainButton: {
      "color": Colors.orange,
      "text": "C",
    },
    authButton: {
      "color": Colors.green,
      "text": "A",
    },
    kickButton: {
      "color": Colors.red,
      "icon": Icons.close,
    },
    inviteButton: {
      "color": Colors.green,
      "icon": Icons.add,
    },
    teamButton: {
      "color": Colors.purple,
      "icon": Icons.group_outlined,
    },
  };

  final double buttonSize = 26;
  final double iconSize = 16;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: buttonData[buttonType]?["color"]),
        child: Center(
          child: buttonData[buttonType]?["icon"] != null
              ? Icon(
                  buttonData[buttonType]?["icon"],
                  color: Colors.white,
                  size: iconSize,
                )
              : Text(
                  buttonData[buttonType]?["text"],
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: iconSize),
                ),
        ),
      ),
    );
  }
}
