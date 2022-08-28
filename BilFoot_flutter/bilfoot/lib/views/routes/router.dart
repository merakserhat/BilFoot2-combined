import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/first_page/first_page.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
import 'package:bilfoot/views/screens/team_page/team_page.dart';
import 'package:flutter/material.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case FirstPage.routeName:
        return MaterialPageRoute(builder: (_) => const FirstPage());
      case TeamPage.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                TeamPage(teamModel: settings.arguments as TeamModel?));
      default:
        return MaterialPageRoute(builder: (_) => const FirstPage());
    }
  }
}
