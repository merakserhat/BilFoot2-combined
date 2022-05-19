import 'package:bilfoot/data/models/team_model.dart';

class PlayerModel {
  PlayerModel({
    required this.email,
    required this.fullName,
    required this.preferredPositions,
    required this.specialSkills,
    required this.averagePoint,
    required this.pointerNum,
    this.imageUrl,
    required this.teams,
  });
  late final String email;
  late final String fullName;
  late final List<String> preferredPositions;
  late final List<String> specialSkills;
  late final double averagePoint;
  late final int pointerNum;
  late final String? imageUrl;
  late final List<TeamModel> teams;

  PlayerModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
    preferredPositions =
        List.castFrom<dynamic, String>(json['preferredPositions']);
    specialSkills = List.castFrom<dynamic, String>(json['specialSkills']);
    averagePoint = json['averagePoint'];
    pointerNum = json['pointerNum'];
    imageUrl = json['imageUrl'];
    teams = List.from(json['teams']).map((e) => TeamModel.fromJson(e)).toList();
  }
}
