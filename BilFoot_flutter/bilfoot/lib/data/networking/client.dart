import 'dart:convert';

import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/announcement_service.dart';
import 'package:bilfoot/data/networking/chat_service.dart';
import 'package:bilfoot/data/networking/team_service.dart';
import 'package:bilfoot/data/networking/user_service.dart';
import "package:http/http.dart" as http;

class BilfootClient {
  static final BilfootClient _instance = BilfootClient._internal();
  BilfootClient._internal();

  factory BilfootClient() {
    return _instance;
  }

  //get ip by writing ipconfig to terminal
  final String baseUrl = "http://192.168.1.103:8080/";

  //User endpoints
  final userTest = UserService.test;
  final getHomeData = UserService.getHomeData;

  //Chat endpoints
  final chatTest = ChatService.test;

  //Team endpoints
  final teamTest = TeamService.test;

  //Announcement endpoints
  final announcementTest = AnnouncementService.test;

  Future<http.Response?> sendRequest(
      {required String path, Map<String, dynamic>? body}) async {
    try {
      var url = Uri.parse(baseUrl + path);

      var response = await http.get(
        url,
//        body: body == null ? null : jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${Program.program.token}",
        },
      );
      /*
    Response -> is_registered = false or true;
     */

      return response;
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}
