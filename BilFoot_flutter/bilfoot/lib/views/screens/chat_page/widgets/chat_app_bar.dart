import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/views/widgets/profile_photo.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key, required this.playerModel}) : super(key: key);

  final PlayerModel playerModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Hero(
              tag: "CHAT_PROFILE_PHOTO",
              child: SizedBox(
                width: 36,
                height: 36,
                child: ProfilePhoto(imageUrl: playerModel.imageUrl!),
              ),
            ),
            const SizedBox.square(dimension: 10),
            Text(playerModel.fullName),
          ],
        ),
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
