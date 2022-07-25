import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/auth_page/auth_page.dart';
import 'package:bilfoot/views/screens/auth_page/auth_verification_page.dart';
import 'package:bilfoot/views/screens/main_page/main_control_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  static const String routeName = "first_page";

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Loading..."),
          ],
        ),
      ),
    );
  }
}
