import 'dart:convert';

import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:http/http.dart';

class UserService {
  static void test() {}

  static Future<bool> getHomeData() async {
    Response? response =
        await BilfootClient().sendRequest(path: "player/get-home-data");

    if (response == null) {
      //TODO
      print("null responde getHomeData");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status getHomeData");
      return false;
    }

    var jsonData = json.decode(response.body);
    print("getHomeData");
    print(jsonData);
    if (jsonData["player"] != null) {
      PlayerModel playerModel = PlayerModel.fromJson(jsonData["player"]);
      Program.program.user = playerModel;
      return true;
    }

    return false;
  }
}
