import 'package:bilfoot/config/constants/program_colors.dart';
import "package:flutter/material.dart";

class BilfootButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final EdgeInsets? customPadding;
  final double? horizontalPadding;
  final double? verticalPadding;
  final FontWeight? fontWeight;
  final Color? color;
  final bool disabled;

  const BilfootButton({
    this.color,
    this.onPressed,
    required this.label,
    this.customPadding,
    this.horizontalPadding,
    this.verticalPadding,
    this.fontWeight,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      //This material is necessary for blurry background panels
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: disabled ? () {} : onPressed,
        child: Material(
          color: _getColor(context),
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: customPadding ??
                EdgeInsets.symmetric(
                    vertical: verticalPadding ?? 9,
                    horizontal: horizontalPadding ?? 45),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: fontWeight ?? FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor(BuildContext context) {
    if (color != null) {
      if (disabled) {
        return color!.withOpacity(0.5);
      } else {
        return color!;
      }
    } else {
      if (disabled) {
        return Theme.of(context).primaryColor.withOpacity(0.5);
      } else {
        return Theme.of(context).primaryColor;
      }
    }
  }
}
