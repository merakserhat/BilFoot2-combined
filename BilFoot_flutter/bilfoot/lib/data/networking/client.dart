import 'dart:convert';

import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/announcement_service.dart';
import 'package:bilfoot/data/networking/chat_service.dart';
import 'package:bilfoot/data/networking/team_service.dart';
import 'package:bilfoot/data/networking/user_service.dart';
import "package:http/http.dart" as http;

enum Method { post, get }

class BilfootClient {
  static final BilfootClient _instance = BilfootClient._internal();
  BilfootClient._internal();

  factory BilfootClient() {
    return _instance;
  }

  //get ip by writing ipconfig to terminal
  final String baseUrl = "http://192.168.1.100:8080/";

  //User endpoints
  final userTest = UserService.test;
  final getHomeData = UserService.getHomeData;
  final getNotifications = UserService.getUserNotifications;
  final searchPlayers = UserService.searchPlayers;
  final registerUser = UserService.registerUser;
  final answerToNotification = UserService.answerToNotification;

  //Chat endpoints
  final chatTest = ChatService.test;

  //Team endpoints
  final teamTest = TeamService.test;
  final createTeam = TeamService.createTeam;
  final getTeamModel = TeamService.getTeamModel;
  final getTeamInvitation = TeamService.getTeamInvitation;
  final inviteToTeam = TeamService.inviteToTeam;
  final quitTeam = TeamService.quitTeam;
  final makeCaptain = TeamService.makeCaptain;
  final kickPlayer = TeamService.kickPlayer;

  //Announcement endpoints
  final announcementTest = AnnouncementService.test;

  Future<http.Response?> sendRequest({
    required String path,
    Map<String, dynamic>? body,
    Method method = Method.get,
  }) async {
    try {
      var url = Uri.parse(baseUrl + path);

      if (method == Method.get) {
        var response = await http.get(
          url,
//        body: body == null ? null : jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${Program.program.token}",
          },
        );
        return response;
      } else if (Method.post == method) {
        var response = await http.post(
          url,
          body: body == null ? null : jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${Program.program.token}",
          },
        );
        return response;
      }
      /*
    Response -> is_registered = false or true;
     */

    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}
