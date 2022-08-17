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
    markups.add(MarkupModel(textStyle: style, text: text));
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

    markups.add(MarkupModel(textStyle: style, text: text));
  }

  print(markups);

  /*
  while(exampleText.contains(regex)) {
    int firstMarkupIndex = exampleText.indexOf(regex);

    String markup = exampleText.splitMapJoin(regex,onMatch: (value) => {});

    exampleText = exampleText.replaceFirst(regex,"");
  }

  */

  //print(list);
}

class MarkupModel {
  final String textStyle;
  final String text;

  MarkupModel({required this.textStyle, required this.text});

  String toString() {
    return "TextStyle: $textStyle, text: $text";
  }
}

class TextStyle {
  final String color;
  final String type;

  TextStyle({required this.color, required this.type});
}
