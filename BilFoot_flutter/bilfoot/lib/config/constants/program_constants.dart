import 'dart:ui';

import 'package:flutter/material.dart';

class ProgramConstants {
  static const EdgeInsets pagePadding =
      EdgeInsets.symmetric(vertical: 16, horizontal: 24);

  static List<BoxShadow>? getDefaultBoxShadow(BuildContext context,
      {bool smallShadow = false}) {
    // return AdaptiveTheme.of(context).theme ==
    //         AdaptiveTheme.of(context).lightTheme
    //     ?
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: smallShadow ? 1 : 2,
        blurRadius: smallShadow ? 1.5 : 3,
        offset: const Offset(0, 1), // changes position of shadow
      ),
    ];
    // : [
    //     BoxShadow(
    //       color: Colors.grey.withOpacity(0.2),
    //       spreadRadius: smallShadow ? 1 : 2,
    //       blurRadius: smallShadow ? 1.5 : 3,
    //       offset: const Offset(0, 1), // changes position of shadow
    //     ),
    //   ]; //null instead
  }

  static void showBlurryBackground({
    required BuildContext context,
    required Widget child,
    bool closeOnTab = true,
  }) {
    showGeneralDialog(
      barrierDismissible: closeOnTab,
      barrierLabel: '',
      // barrierColor: Colors.black54.withOpacity(0.75),
      // barrierColor: ProgramColors.of(context).isLight()
      //     ? Colors.white.withOpacity(0.05)
      //     : Colors.black54.withOpacity(0.75),
      barrierColor: Colors.white.withOpacity(0.05),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => child,
      transitionBuilder: (ctx, anim1, anim2, child) {
        return WillPopScope(
          onWillPop: () async => closeOnTab,
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 18 * anim1.value, sigmaY: 18 * anim1.value),
            child: FadeTransition(
              child: child,
              opacity: anim1,
            ),
          ),
        );
      },
      context: context,
    );
  }
}
