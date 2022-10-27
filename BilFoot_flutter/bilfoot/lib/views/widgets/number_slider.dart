import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NumberSlider extends StatefulWidget {
  const NumberSlider(
      {Key? key, required this.firstNumber, required this.lastNumber})
      : super(key: key);
  final double firstNumber;
  final double lastNumber;

  @override
  State<NumberSlider> createState() => _NumberSliderState();
}

class _NumberSliderState extends State<NumberSlider> {
  var _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: PolygonSliderThumb(
          thumbRadius: 16.0,
          sliderValue: _value,
        ),
      ),
      child: Slider(
        min: widget.firstNumber,
        max: widget.lastNumber,
        value: _value,
        divisions: (widget.lastNumber - widget.firstNumber).round(),
        label: '${_value.round()}',
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
      ),
    ));
  }
}

class PolygonSliderThumb extends SliderComponentShape {
  final double thumbRadius;
  final double sliderValue;
  const PolygonSliderThumb({
    required this.thumbRadius,
    required this.sliderValue,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    // Define the slider thumb design here
    final Canvas canvas = context.canvas;
    int sides = 4;
    double innerPolygonRadius = thumbRadius * 1.2;
    double outerPolygonRadius = thumbRadius * 1.4;
    double angle = (math.pi * 2) / sides;
    final outerPathColor = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    var outerPath = Path();

    Offset startPoint2 = Offset(
      outerPolygonRadius * math.cos(0.0),
      outerPolygonRadius * math.sin(0.0),
    );

    outerPath.moveTo(
      startPoint2.dx + center.dx,
      startPoint2.dy + center.dy,
    );

    for (int i = 1; i <= sides; i++) {
      double x = outerPolygonRadius * math.cos(angle * i) + center.dx;
      double y = outerPolygonRadius * math.sin(angle * i) + center.dy;
      outerPath.lineTo(x, y);
    }

    outerPath.close();
    canvas.drawPath(outerPath, outerPathColor);

    final innerPathColor = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.black
      ..style = PaintingStyle.fill;

    var innerPath = Path();

    Offset startPoint = Offset(
      innerPolygonRadius * math.cos(0.0),
      innerPolygonRadius * math.sin(0.0),
    );

    innerPath.moveTo(
      startPoint.dx + center.dx,
      startPoint.dy + center.dy,
    );

    for (int i = 1; i <= sides; i++) {
      double x = innerPolygonRadius * math.cos(angle * i) + center.dx;
      double y = innerPolygonRadius * math.sin(angle * i) + center.dy;
      innerPath.lineTo(x, y);
    }

    innerPath.close();
    canvas.drawPath(innerPath, innerPathColor);

    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      text: sliderValue.round().toString(),
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();

    Offset textCenter = Offset(
      center.dx - (tp.width / 2),
      center.dy - (tp.height / 2),
    );

    tp.paint(canvas, textCenter);
  }
}
