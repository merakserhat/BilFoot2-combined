import 'package:bilfoot/data/models/notification_model.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:flutter/material.dart';

class TeamInvitationNotification extends StatefulWidget {
  const TeamInvitationNotification(
      {Key? key, required this.teamInvitationNotificationModel})
      : super(key: key);

  final NotificationModel teamInvitationNotificationModel;

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
      onLongPress: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            /* SizedBox(
              width: 80,
              height: 80,
              child: FittedBox(
                child: TeamLogoTitle(
                  teamModel: widget.teamInvitationNotificationModel.team,
                  bigLogo: true,
                ),
              ),
            ),*/
            const SizedBox.square(dimension: 20),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.teamInvitationNotificationModel.to,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(text: ' is inviting you to his team '),
                        TextSpan(
                            text: widget.teamInvitationNotificationModel.to,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox.square(
                    dimension: 10,
                  ),
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
              ),
            ))
          ],
        ),
      ),
    );
  }
}
