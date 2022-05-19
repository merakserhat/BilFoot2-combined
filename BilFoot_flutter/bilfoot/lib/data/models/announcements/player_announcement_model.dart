import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/team_model.dart';

class PlayerAnnouncementModel {
  PlayerAnnouncementModel({
    required this.announcer,
    this.match,
    required this.date,
    required this.positions,
    required this.forTeam,
    this.teamModel,
  });
  late final PlayerModel announcer;
  late final MatchModel? match;
  late final DateTime date;
  late final List<String> positions;
  late final bool forTeam;
  late TeamModel? teamModel;

  PlayerAnnouncementModel.fromJson(Map<String, dynamic> json) {
    announcer = PlayerModel.fromJson(json['pitch']);
    match =
        json['match'] == null ? null : MatchModel.fromJson(json['matchTime']);
    DateTime dataDate = DateTime.parse(json['date']);
    date = DateTime(dataDate.year, dataDate.month, dataDate.day);
    positions = List.from(json["positions"]);
    forTeam = json["for_team"];
    teamModel = json["team"] == null ? null : TeamModel.fromJson(json["team"]);
  }
}
