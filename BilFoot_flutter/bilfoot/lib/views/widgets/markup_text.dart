//TODO: improve this and create a package
import "package:flutter/material.dart";

class MarkupText extends StatelessWidget {
  final String text;
  final List<TextStyle> textStyles;

  const MarkupText(this.text, {Key? key, this.textStyles = const [TextStyle()]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MarkupModel> markups = _getMarkups();

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: textStyles[0],
          children: markups
              .map((e) => TextSpan(text: e.text, style: e.textStyle))
              .toList()),
    );
  }

  List<MarkupModel> _getMarkups() {
    RegExp regex = RegExp(r'\[[^\]]*]');

    List<MarkupModel> markups = [];

    List<Map<String, int>> markupPointers = [];

    text.splitMapJoin(regex, onMatch: (Match m) {
      markupPointers.add({
        "start": m.start,
        "end": m.end,
      });

      return "";
    });

    if (markupPointers[0]["start"] != 0) {
      String style = "default"; // getTextStyle
      String textPart = text.substring(0, markupPointers[0]["start"]);
      markups.add(MarkupModel(markupText: style, text: textPart));
    }

    for (int i = 0; i < markupPointers.length; i++) {
      String style = "";
      String textPart = "";

      style =
          text.substring(markupPointers[i]["start"]!, markupPointers[i]["end"]);

      if (i != markupPointers.length - 1) {
        textPart = text.substring(
            markupPointers[i]["end"]!, markupPointers[i + 1]["start"]);
      } else {
        textPart = text.substring(markupPointers[i]["end"]!);
      }

      markups.add(MarkupModel(markupText: style, text: textPart));
    }

    fillMarkupStyles(markups);

    return markups;
  }

  void fillMarkupStyles(List<MarkupModel> markups) {
    for (MarkupModel markupModel in markups) {
      if (markupModel.markupText == "[]") {
        markupModel.textStyle = textStyles[0];
      } else {
        List<String> markupHints = markupModel.markupText
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
            color:
                Color(int.parse('ff${color.replaceAll('#', '')}', radix: 16)));

        markupModel.textStyle = currentStyle;
      }
    }
  }
}

class MarkupModel {
  final String markupText;
  final String text;
  TextStyle? textStyle;

  MarkupModel({required this.markupText, required this.text});
}
