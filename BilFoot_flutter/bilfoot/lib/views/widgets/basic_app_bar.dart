import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text("BilFoot"),
      ),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

/*
Image.asset(
          AdaptiveTheme.of(context).theme ==
              AdaptiveTheme.of(context).lightTheme
              ? 'assets/images/logo/logo_w_text_horiz_black.png'
              : 'assets/images/logo/logo_w_text_horiz_white.png',
          height: 24,
        ),
 */
