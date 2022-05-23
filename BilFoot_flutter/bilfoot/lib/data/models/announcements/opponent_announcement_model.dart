import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/team_model.dart';

class OpponentAnnouncementModel {
  OpponentAnnouncementModel({
    required this.announcer,
    this.match,
    required this.date,
    required this.teamModel,
  });
  late final PlayerModel announcer;
  late final MatchModel? match;
  late final DateTime date;
  late final TeamModel teamModel;

  OpponentAnnouncementModel.fromJson(Map<String, dynamic> json) {
    announcer = PlayerModel.fromJson(json['pitch']);
    match =
        json['match'] == null ? null : MatchModel.fromJson(json['matchTime']);
    DateTime dataDate = DateTime.parse(json['date']);
    date = DateTime(dataDate.year, dataDate.month, dataDate.day);
    teamModel = TeamModel.fromJson(json["team"]);
  }
}
