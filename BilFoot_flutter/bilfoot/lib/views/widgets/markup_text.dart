//TODO: improve this and create a package
import "package:flutter/material.dart";

class MarkupText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const MarkupText(this.text, {Key? key, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = textStyle ?? Theme.of(context).textTheme.bodyText2!;
    List<Map<String, dynamic>> texts = _defactorizeTexts();

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: style,
          children: texts
              .map((e) => TextSpan(
                  text: e["text"],
                  style: e["type"] == "bold"
                      ? style.copyWith(fontWeight: FontWeight.bold)
                      : style))
              .toList()),
    );
  }

  List<Map<String, dynamic>> _defactorizeTexts() {
    List<Map<String, dynamic>> texts = [];
    List<String> dirtyTexts = text.split("<b>");
    List<List<String>> textPairs =
        dirtyTexts.map((dirtyText) => dirtyText.split("</>")).toList();
    for (var textPair in textPairs) {
      if (textPair.length == 1) {
        texts.add({"text": textPair[0], "type": "normal"});
      } else if (textPair.length == 2) {
        texts.add({"text": textPair[0], "type": "bold"});
        texts.add({"text": textPair[1], "type": "normal"});
      } else {
        throw AssertionError("Text pattern is not valid");
      }
    }

    return texts;
  }
}
