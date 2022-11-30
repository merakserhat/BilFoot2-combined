import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/team_model.dart';

class OpponentAnnouncementModel {
  OpponentAnnouncementModel({
    required this.announcer,
    required this.match,
    required this.createdAt,
    required this.teamModel,
  });
  late final PlayerModel announcer;
  late final MatchModel match;
  late final DateTime createdAt;
  late final TeamModel teamModel;

  OpponentAnnouncementModel.fromJson(Map<String, dynamic> json) {
    announcer = PlayerModel.fromJson(json['announcer']);
    match = MatchModel.fromJson(json['match']);
    DateTime dataDate = DateTime.parse(json['created_at']);
    createdAt = DateTime(dataDate.year, dataDate.month, dataDate.day);
    teamModel = TeamModel.fromJson(json["team"]);
  }
}
