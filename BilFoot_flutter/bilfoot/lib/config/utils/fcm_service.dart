import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/views/screens/team_page/team_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FCMService {
  final BuildContext context;
  late FirebaseMessaging messaging;

  FCMService({required this.context}) {
    messaging = FirebaseMessaging.instance;
  }

  void init() {
    printToken();
    subscribeTopics();
  }

  void subscribeTopics() {
    messaging.subscribeToTopic("general");
  }

  void printToken() async {
    final token = await messaging.getToken();
    print(token);
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage initialMessage) {
    if (initialMessage.data['type'] == 'chat') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              TeamPage(teamModel: Program.program.dummyData.dummyTeam1)));
    }
  }
}
