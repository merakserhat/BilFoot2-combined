import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';

class PlayerAnnouncementModel {
  PlayerAnnouncementModel(
      {required this.announcer,
      required this.match,
      required this.createdAt,
      required this.positions,
      required this.candidates,
      required this.playerLimit});
  late final PlayerModel announcer;
  late final MatchModel? match;
  late final DateTime createdAt;
  late final List<String> positions;
  late final int playerLimit;
  late final int candidates;
  late final MatchModel matchModel;

  PlayerAnnouncementModel.fromJson(Map<String, dynamic> json) {
    announcer = PlayerModel.fromJson(json['pitch']);
    match =
        json['match'] == null ? null : MatchModel.fromJson(json['matchTime']);
    DateTime dataDate = DateTime.parse(json['created_at']);
    createdAt = DateTime(dataDate.year, dataDate.month, dataDate.day);
    positions = List.from(json["positions"]);
    playerLimit = json["player_limit"];
    candidates = json["candidates"];
    matchModel = MatchModel.fromJson(json["match"]);
  }
}
