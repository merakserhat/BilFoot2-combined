import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';

class PlayerAnnouncementModel {
  PlayerAnnouncementModel({
    required this.id,
    required this.announcer,
    required this.match,
    required this.createdAt,
    required this.positions,
    required this.candidates,
    required this.refusedPlayers,
    required this.acceptedPlayers,
    required this.playerLimit,
  });
  late final String id;
  late final PlayerModel announcer;
  late final MatchModel match;
  late final DateTime createdAt;
  late final List<String> positions;
  late final int playerLimit;
  late final int candidates;
  late final int refusedPlayers;
  late final int acceptedPlayers;

  PlayerAnnouncementModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    announcer = PlayerModel.fromJson(json['announcer']);
    match = MatchModel.fromJson(json['match']);
    DateTime dataDate = DateTime.parse(json['created_at']);
    createdAt = DateTime(dataDate.year, dataDate.month, dataDate.day);
    positions = List.from(json["positions"]);
    playerLimit = json["player_limit"];
    candidates = List.from(json["candidates"]).length;
    refusedPlayers = List.from(json["refused_players"]).length;
    acceptedPlayers = List.from(json["accepted_players"]).length;
  }
}
