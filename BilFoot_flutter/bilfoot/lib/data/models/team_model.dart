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
  late final PlayerModel? creator;
  late final PlayerModel? captain;
  late final List<PlayerModel> players;

  TeamModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortName = json['shortName'];
    mainColor = json['mainColor'];
    accentColor = json['accentColor'];
    creator = PlayerModel.fromJson(json['creator']);
    captain = PlayerModel.fromJson(json['captain']);
    players =
        List.from(json['players']).map((e) => PlayerModel.fromJson(e)).toList();
  }
}
