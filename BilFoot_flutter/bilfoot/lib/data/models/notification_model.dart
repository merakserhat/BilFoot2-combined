import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/team_model.dart';

class NotificationModel {
  NotificationModel(
      {required this.id,
      required this.from,
      this.to,
      this.object,
      required this.type,
      required this.status});

  late final String id;
  late final String from;
  late final String? to;
  late final String? object;
  late final String type;
  late final String status;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    from = json['from'];
    to = json['to'];
    object = json['object'];
    type = json['type'];
    status = json['status'];
  }
}

class OpponentAnnouncementNotificationModel {
  final NotificationModel notification;
  final TeamModel team;
  final PlayerModel playerModel;

  OpponentAnnouncementNotificationModel(
      {required this.notification,
      required this.team,
      required this.playerModel});
}
