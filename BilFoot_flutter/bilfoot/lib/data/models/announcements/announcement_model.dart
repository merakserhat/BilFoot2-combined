import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';

class AnnouncementModel {
  AnnouncementModel({
    required this.announcer,
    this.match,
    required this.date,
  });
  late final PlayerModel announcer;
  late final MatchModel? match;
  late final DateTime date;

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    announcer = PlayerModel.fromJson(json['pitch']);
    match =
        json['match'] == null ? null : MatchModel.fromJson(json['matchTime']);
    DateTime dataDate = DateTime.parse(json['date']);
    date = DateTime(dataDate.year, dataDate.month, dataDate.day);
  }
}
