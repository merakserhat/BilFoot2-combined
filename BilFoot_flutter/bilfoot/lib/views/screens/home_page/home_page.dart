import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/widgets/fragmented_header/fragmented_header.dart';
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
        children: const [
          Text("Home Page"),
        ],
      ),
    ));
  }
}
