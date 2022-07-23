import 'package:flutter/material.dart';

class TeamInvitationNotification extends StatefulWidget {
  const TeamInvitationNotification({Key? key}) : super(key: key);

  @override
  State<TeamInvitationNotification> createState() =>
      _TeamInvitationNotificationState();
}

class _TeamInvitationNotificationState
    extends State<TeamInvitationNotification> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Text(""),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                const Text("Serhat Merak is inviting you to Cu S.K"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: () {}, child: const Text("Refuse")),
                    const SizedBox.square(dimension: 32),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Accept")),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
