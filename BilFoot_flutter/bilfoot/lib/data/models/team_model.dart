import 'package:bilfoot/data/models/player_model.dart';
import 'package:equatable/equatable.dart';

class TeamModel extends Equatable {
  TeamModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.mainColor,
    required this.accentColor,
    this.creator,
    this.captain,
    required this.players,
  });
  late final String id;
  late final String name;
  late final String shortName;
  late final String mainColor;
  late final String accentColor;
  late final String? creator;
  late final String? captain;
  late final List<PlayerModel> players;

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    shortName = json['short_name'];
    mainColor = json['main_color'];
    accentColor = json['accent_color'];
    creator = json['creator'];
    captain = json['captain'];
    players =
        List.from(json["players"]).map((e) => PlayerModel.fromJson(e)).toList();
  }

  TeamModel copyWith(
          {String? name,
          String? creator,
          String? captain,
          String? shortName,
          String? mainColor,
          String? accentColor,
          List<PlayerModel>? players}) =>
      TeamModel(
        id: this.id,
        name: name ?? this.name,
        shortName: shortName ?? this.shortName,
        mainColor: mainColor ?? this.mainColor,
        accentColor: accentColor ?? this.accentColor,
        players: players ?? this.players,
        captain: captain ?? this.captain,
        creator: creator ?? this.creator,
      );

  @override
  List<Object?> get props =>
      [id, name, shortName, mainColor, accentColor, players, captain, creator];
}
