import 'package:bilfoot/views/screens/first_page/first_page.dart';
import 'package:flutter/material.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case FirstPage.routeName:
        return MaterialPageRoute(builder: (_) => FirstPage());
      default:
        return MaterialPageRoute(builder: (_) => const FirstPage());
    }
  }
}
