import 'package:bilfoot/views/routes/router.dart';
import 'package:bilfoot/views/themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Page',
      theme: MyThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: PageRouter.generateRoute,
    );
  }
}
