import 'package:bilfoot/data/models/match_model.dart';
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
  NotificationModel({
    required this.id,
    required this.from,
    required this.to,
    required this.type,
    required this.status,
    required this.interaction,
    this.playerModel,
    this.teamModel,
    this.matchModel,
  });

  late final String id;
  late final String from;
  late final String? to;
  late final String type;
  late String status;
  late final String interaction; //static-chat-approval
  late final PlayerModel? playerModel;
  late final TeamModel? teamModel;
  late final MatchModel? matchModel;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    from = json['from'];
    to = json['to'];
    type = json['type'];
    status = json['status'];
    interaction = json["interaction"];
    playerModel = json["player_model"] == null
        ? null
        : PlayerModel.fromJson(json["player_model"]);
    teamModel = json["team_model"] == null
        ? null
        : TeamModel.fromJson(json["team_model"]);
    matchModel = json["match_model"] == null
        ? null
        : MatchModel.fromJson(json["match_model"]);
  }
}
