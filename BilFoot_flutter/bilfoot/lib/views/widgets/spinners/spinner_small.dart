import 'package:bilfoot/config/constants/program_colors.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinnerSmall extends StatelessWidget {
  const SpinnerSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: 20,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: _getCircleColor(index),
          ),
        );
      },
    );
  }

  Color _getCircleColor(int index) {
    switch (index) {
      case 0:
        return ProgramColors.bilkentPalette[0];
      case 1:
        return ProgramColors.bilkentPalette[1];
      case 2:
        return ProgramColors.bilkentPalette[2];
      case 3:
        return ProgramColors.bilkentPalette[3];
      default:
        return ProgramColors.bilkentPalette[0];
    }
  }
}
