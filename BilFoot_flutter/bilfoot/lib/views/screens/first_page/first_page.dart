import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  static const String routeName = "first_page";

  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ds");

    return Scaffold(
      appBar: AppBar(
        title: const Text("First Page Title"),
      ),
      body: const Center(
        child: Text("First Page "),
      ),
    );
  }
}
