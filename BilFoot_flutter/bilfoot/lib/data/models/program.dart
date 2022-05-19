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
}
