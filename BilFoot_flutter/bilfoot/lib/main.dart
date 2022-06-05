import 'package:bilfoot/views/routes/router.dart';
import 'package:bilfoot/views/themes/my_themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final token = await messaging.getToken();
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
