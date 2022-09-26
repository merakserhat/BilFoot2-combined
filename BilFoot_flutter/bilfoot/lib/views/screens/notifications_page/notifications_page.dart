import 'package:bilfoot/config/constants/notification_types.dart';
import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/notification_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/match_page/create_edit_match_panel.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_list_item.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_table.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/markup_text.dart';
import 'package:bilfoot/views/widgets/notifications/notification_card.dart';
import 'package:bilfoot/views/widgets/notifications/opponent_announcemnt_notification.dart';
import 'package:bilfoot/views/widgets/notifications/team_invitation_notification.dart';
import "package:flutter/material.dart";

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationModel notificationModel1;
  @override
  void initState() {
    super.initState();
    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: Program.program.notifications
              .map((e) => NotificationCard(notificationModel: e))
              .toList(),
        ),
      ),
    );
  }

  void _getNotifications() async {
    await BilfootClient().getNotifications();
    setState(() {});
  }
}
