import 'package:bilfoot/data/models/team_model.dart';
import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
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
    fullName = json['full_name'];
    preferredPositions =
        List.castFrom<dynamic, String>(json['preferred_positions']);
    specialSkills = List.castFrom<dynamic, String>(json['special_skills']);
    averagePoint = json['average_point'] * 1.0;
    pointerNum = json['pointer_num'];
    imageUrl = json['image_url'];
    teams = List.from(json['teams']).map((e) => TeamModel.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [email];
}
