import 'package:bilfoot/data/models/player_model.dart';

class TeamModel {
  TeamModel({
    required this.name,
    required this.shortName,
    required this.mainColor,
    required this.accentColor,
    this.creator,
    this.captain,
    required this.players,
  });
  late final String name;
  late final String shortName;
  late final String mainColor;
  late final String accentColor;
  late final String? creator;
  late final String? captain;
  late final List<String> players;

  TeamModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortName = json['short_name'];
    mainColor = json['main_color'];
    accentColor = json['accent_color'];
    creator = json['creator'];
    captain = json['captain'];
    players = List.castFrom<dynamic, String>(json["players"]);
  }
}
