import 'package:bilfoot/data/models/player_model.dart';

class MatchModel {
  MatchModel({
    required this.date,
    required this.hour,
    required this.pitch,
    required this.isPitchApproved,
    required this.creator,
    required this.people,
    required this.authPeople,
    required this.showOnTable,
    required this.peopleLimit,
  });
  late final String date;
  late final String hour;
  late final String pitch;
  late final bool isPitchApproved;
  late final PlayerModel creator;
  late final List<PlayerModel> people;
  late final List<PlayerModel> authPeople;
  late final bool showOnTable;
  late final int peopleLimit;

  MatchModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    hour = json['hour'];
    pitch = json['pitch'];
    isPitchApproved = json['isPitchApproved'];
    creator = PlayerModel.fromJson(json["creator"]);
    people =
        List.from(json["people"]).map((e) => PlayerModel.fromJson(e)).toList();
    authPeople = List.from(json["auth_people"])
        .map((e) => PlayerModel.fromJson(e))
        .toList();
    showOnTable = json['show_on_table'];
    peopleLimit = json['people_limit'];
  }
}
