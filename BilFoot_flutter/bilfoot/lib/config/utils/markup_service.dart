import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  String name = "Serhat Merak";
  String team = "Bilfoot";
  String exampleText =
      "[b]$name has[red]refused[]your invitation to team[1]$team[].";

  RegExp regex = RegExp(r'\[[^\]]*]');

  List<MarkupModel> markups = [];
  List<Map<String, int>> markupPointers = [];

  exampleText.splitMapJoin(regex, onMatch: (Match m) {
    markupPointers.add({
      "start": m.start,
      "end": m.end,
    });

    return "";
  });

  if (markupPointers[0]["start"] != 0) {
    String style = "default"; // getTextStyle
    String text = exampleText.substring(0, markupPointers[0]["start"]);
    markups.add(MarkupModel(textStyleHint: style, text: text));
  }

  for (int i = 0; i < markupPointers.length; i++) {
    String style = "";
    String text = "";

    style = exampleText.substring(
        markupPointers[i]["start"]!, markupPointers[i]["end"]);

    if (i != markupPointers.length - 1) {
      text = exampleText.substring(
          markupPointers[i]["end"]!, markupPointers[i + 1]["start"]);
    } else {
      text = exampleText.substring(markupPointers[i]["end"]!);
    }

    markups.add(MarkupModel(textStyleHint: style, text: text));
  }

  print(markups);
  fillMarkupStyles(markups);

  /*
  while(exampleText.contains(regex)) {
    int firstMarkupIndex = exampleText.indexOf(regex);

    String markup = exampleText.splitMapJoin(regex,onMatch: (value) => {});

    exampleText = exampleText.replaceFirst(regex,"");
  }

  */

  //print(list);
}

void fillMarkupStyles(List<MarkupModel> markups) {
  List<TextStyle> textStyles = [
    const TextStyle(color: Colors.red),
    const TextStyle(color: Colors.blue)
  ];

  for (MarkupModel markupModel in markups) {
    if (markupModel.textStyleHint == "[]") {
      markupModel.textStyle = textStyles[0];
    } else {
      List<String> markupHints = markupModel.textStyleHint
          .replaceAll("[", "")
          .replaceAll("]", "")
          .split(",");

      int textStyleIndex = int.parse(markupHints.firstWhere(
          (element) => RegExp(r'^[0-9]+$').hasMatch(element),
          orElse: () => "0"));

      TextStyle currentStyle = textStyles[textStyleIndex].copyWith();

      if (markupHints.contains("b")) {
        currentStyle = currentStyle.copyWith(fontWeight: FontWeight.bold);
      }

      String color = markupHints.firstWhere(
          (element) => element.length == 7 && element[0] == "#",
          orElse: () => "#000000");
      /*
      if (color.isEmpty) {
        color = markupHints.firstWhere(
            (element) => RegExp(r'[a-z]+').hasMatch(element) && element != "b",
            orElse: () => "black");
        color = Colors;
      }*/

      currentStyle = currentStyle.copyWith(
          color: Color(int.parse('ff${color.replaceAll('#', '')}', radix: 16)));

      markupModel.textStyle = currentStyle;
    }
  }
}

class MarkupModel {
  final String textStyleHint;
  final String text;
  TextStyle? textStyle;

  MarkupModel({required this.textStyleHint, required this.text});

  String toString() {
    return "{TextStyleHint: $textStyleHint, text: $text}";
  }
}
