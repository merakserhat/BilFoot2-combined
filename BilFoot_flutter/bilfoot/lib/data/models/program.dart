import 'package:bilfoot/data/models/notification_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/team_model.dart';

///A singleton class that holds some variables that is required in most of the pages.
class Program {
  //#region set singleton
  static final Program _program = Program._internal();

  factory Program() {
    return _program;
  }
  Program._internal();
  static Program get program => _program;
  //#endregion

  //Home data
  PlayerModel? user;
  String? token;
  List<NotificationModel> notifications = [];

  PlayerModel dummyPlayer1 = PlayerModel(
      id: "",
      email: "ayberk.senguder@ug.bilkent.edu.tr",
      fullName: "Ayberk Şengüder",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  PlayerModel dummyPlayer2 = PlayerModel(
      id: "",
      email: "serhat.merak@ug.bilkent.edu.tr",
      fullName: "Serhat Merak",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  PlayerModel dummyPlayer3 = PlayerModel(
      id: "",
      email: "mirza.atalar@ug.bilkent.edu.tr",
      fullName: "Mirza Atalar",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  PlayerModel boran = PlayerModel(
      id: "",
      email: "mirza.atalar@ug.bilkent.edu.tr",
      fullName: "Boran Sarı",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  PlayerModel ali = PlayerModel(
      id: "",
      email: "mirza.atalar@ug.bilkent.edu.tr",
      fullName: "Ali Cu",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  PlayerModel mete = PlayerModel(
      id: "",
      email: "mirza.atalar@ug.bilkent.edu.tr",
      fullName: "Metehan Boge",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  PlayerModel ayberk = PlayerModel(
      id: "",
      email: "mirza.atalar@ug.bilkent.edu.tr",
      fullName: "Ayberk Şengüder",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  PlayerModel memduh = PlayerModel(
      id: "",
      email: "mirza.atalar@ug.bilkent.edu.tr",
      fullName: "Memduh Tutuş",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  PlayerModel kerem = PlayerModel(
      id: "",
      email: "mirza.atalar@ug.bilkent.edu.tr",
      fullName: "Kerem Yakay",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  PlayerModel defans = PlayerModel(
      id: "",
      email: "mirza.atalar@ug.bilkent.edu.tr",
      fullName: "Defans Transfer",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  TeamModel dummyTeam1 = TeamModel(
      id: "",
      name: "TUTUNAMAYANLAR",
      shortName: "CU",
      mainColor: "#347282",
      accentColor: "#f6f2c2",
      creator: "",
      captain: "",
      players: []);
}
