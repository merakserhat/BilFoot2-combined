import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/team_model.dart';

class Notifications {
  static const String teamInvitation = "team_invitation";
  static const String teamInvitationAnswer = "team_invitation_answer";
  static const String matchInvitation = "match_invitation";
  static const String matchInvitationAnswer = "match_invitation_answer";
  static const String opponentAnnouncement = "opponent_announcement";
}

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

  static List<NotificationModel> splitDetailedNotifications(
      Map<String, dynamic> json) {
    if (json["detailed_notifications"] != null) {
      List<NotificationModel> notifications =
          (json["detailed_notifications"] as List<dynamic>)
              .map((detailedNotification) {
        switch (detailedNotification["type"]) {
          case Notifications.teamInvitation:
            {
              PlayerModel player =
                  PlayerModel.fromJson(detailedNotification["player"]);
              TeamModel team = TeamModel.fromJson(detailedNotification["team"]);
              NotificationModel notification = NotificationModel.fromJson(
                  detailedNotification["notification"]);

              return TeamInvitationNotificationModel(
                  notification: notification, team: team, player: player);
            }
          case Notifications.opponentAnnouncement:
            {
              PlayerModel player =
                  PlayerModel.fromJson(detailedNotification["player"]);
              TeamModel team = TeamModel.fromJson(detailedNotification["team"]);
              NotificationModel notification = NotificationModel.fromJson(
                  detailedNotification["notification"]);

              return OpponentAnnouncementNotificationModel(
                  notification: notification, team: team, player: player);
            }
          default:
            {
              return NotificationModel.fromJson(
                  detailedNotification["notification"]);
            }
        }
      }).toList();

      return notifications;
    }
    return [];
  }
}

class OpponentAnnouncementNotificationModel extends NotificationModel {
  final TeamModel team;
  final PlayerModel player;

  OpponentAnnouncementNotificationModel({
    required NotificationModel notification,
    required this.team,
    required this.player,
  }) : super(
            id: notification.id,
            from: notification.from,
            type: notification.type,
            to: notification.to,
            object: notification.object,
            status: notification.status);
}

class TeamInvitationNotificationModel extends NotificationModel {
  final TeamModel team;
  final PlayerModel player;

  TeamInvitationNotificationModel({
    required NotificationModel notification,
    required this.team,
    required this.player,
  }) : super(
            id: notification.id,
            from: notification.from,
            type: notification.type,
            to: notification.to,
            object: notification.object,
            status: notification.status);
}
