import 'package:bilfoot/views/screens/first_page/first_page.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
import 'package:flutter/material.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case FirstPage.routeName:
        return MaterialPageRoute(builder: (_) => const FirstPage());
      default:
        return MaterialPageRoute(builder: (_) => const FirstPage());
    }
  }
}
