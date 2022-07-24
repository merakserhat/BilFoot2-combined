import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/notification_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/match_page/create_match_panel.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_list_item.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_table.dart';
import 'package:bilfoot/views/screens/notifications_page/types/opponent_announcemnt_notification.dart';
import 'package:bilfoot/views/screens/notifications_page/types/team_invitation_notification.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import "package:flutter/material.dart";

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final OpponentAnnouncementNotificationModel
      opponentAnnouncementNotification;

  late final TeamInvitationNotificationModel teamInvitationNotificationModel;

  @override
  void initState() {
    super.initState();

    opponentAnnouncementNotification = OpponentAnnouncementNotificationModel(
        notification: NotificationModel(
            id: "se",
            from: "se",
            type: "opponent-announcement",
            status: "active"),
        team: Program.program.dummyTeam1,
        player: Program.program.dummyPlayer1);

    teamInvitationNotificationModel = TeamInvitationNotificationModel(
        notification: NotificationModel(
            id: "se",
            from: "se",
            type: "opponent-announcement",
            status: "active"),
        team: Program.program.dummyTeam1,
        player: Program.program.dummyPlayer1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: Program.program.notifications
                .map(_getNotificationWidgets)
                .toList()),
      ),
    );
  }

  Widget _getNotificationWidgets(NotificationModel notification) {
    switch (notification.type) {
      case Notifications.teamInvitation:
        {
          TeamInvitationNotificationModel teamInvitationNotificationModel =
              (notification as TeamInvitationNotificationModel);
          return TeamInvitationNotification(
              teamInvitationNotificationModel: teamInvitationNotificationModel);
        }
      case Notifications.opponentAnnouncement:
        {
          OpponentAnnouncementNotificationModel
              opponentAnnouncementNotificationModel =
              (notification as OpponentAnnouncementNotificationModel);
          return OpponentAnnouncementNotification(
              opponentAnnouncementNotificationModel:
                  opponentAnnouncementNotificationModel);
        }
    }

    return const Text("Bilmiyoeruz bunu");
  }
}
