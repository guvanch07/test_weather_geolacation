import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DottedLineHelper extends StatelessWidget {
  const DottedLineHelper({
    Key? key,
    required this.widthRatio,
  }) : super(key: key);
  final double widthRatio;

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: widthRatio,
      lineThickness: 1.0,
      dashColor: Colors.grey,
    );
  }
}
