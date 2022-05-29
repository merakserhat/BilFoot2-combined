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

  PlayerModel dummyPlayer1 = PlayerModel(
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
      email: "serhat.merak@ug.bilkent.edu.tr",
      fullName: "Serhat Merak",
      preferredPositions: ["GK", "St"],
      specialSkills: ["Tireless", "Playmaker"],
      averagePoint: 4.6,
      pointerNum: 17,
      teams: [],
      imageUrl:
          "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

  TeamModel dummyTeam1 = TeamModel(
      name: "Cu S.K",
      shortName: "CU",
      mainColor: "#347282",
      accentColor: "#f6f2c2",
      creator: PlayerModel(
          email: "ayberk.senguder@ug.bilkent.edu.tr",
          fullName: "Ayberk Şengüder",
          preferredPositions: ["GK", "St"],
          specialSkills: ["Tireless", "Playmaker"],
          averagePoint: 4.6,
          pointerNum: 17,
          teams: [],
          imageUrl:
              "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"),
      captain: PlayerModel(
          email: "ayberk.senguder@ug.bilkent.edu.tr",
          fullName: "Ayberk Şengüder",
          preferredPositions: ["GK", "St"],
          specialSkills: ["Tireless", "Playmaker"],
          averagePoint: 4.6,
          pointerNum: 17,
          teams: [],
          imageUrl:
              "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"),
      players: []);
}
