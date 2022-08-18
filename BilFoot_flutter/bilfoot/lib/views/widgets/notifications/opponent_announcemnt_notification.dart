import 'package:bilfoot/data/models/notification_model.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:flutter/material.dart';

class OpponentAnnouncementNotification extends StatelessWidget {
  const OpponentAnnouncementNotification(
      {Key? key, required this.opponentAnnouncementNotificationModel})
      : super(key: key);

  final NotificationModel opponentAnnouncementNotificationModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            /*SizedBox(
              width: 80,
              height: 80,
              child: FittedBox(
                child: TeamLogoTitle(
                  teamModel: opponentAnnouncementNotificationModel.team,
                  bigLogo: true,
                ),
              ),
            ),*/
            const SizedBox.square(dimension: 10),
            Expanded(
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        TextSpan(
                            text: opponentAnnouncementNotificationModel.to,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text: ' is looking for an opponent for his team '),
                        TextSpan(
                            text: opponentAnnouncementNotificationModel.to,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            //TODO Later
                          },
                          child: const Text("See Profile")),
                      const SizedBox.square(dimension: 10),
                      ElevatedButton(
                          onPressed: () {
                            //TODO Later
                          },
                          child: const Text("Write Message"))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
