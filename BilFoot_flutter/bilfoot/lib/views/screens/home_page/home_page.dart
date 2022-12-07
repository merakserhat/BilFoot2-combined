import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/widgets/mirza/mirza.dart';
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: ProgramConstants.pagePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Home Page"),
          Mirza(
            content: Center(child: Text("content")),
            msgSend: "Announce",
            titles: [
              "Select Match",
              "Select Positions",
              "Select Player Limit",
            ],
          )
        ],
      ),
    ));
  }
}
