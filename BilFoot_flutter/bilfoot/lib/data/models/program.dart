import 'package:bilfoot/config/utils/dummy_data.dart';
import 'package:bilfoot/data/models/notification_model.dart';
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
  String? token;
  List<NotificationModel> notifications = [];
   DummyData? _dummyData;

  DummyData get dummyData {
    _dummyData ??= DummyData();

    return _dummyData!;
  }
}
