import 'package:bilfoot/data/models/player_model.dart';

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
}