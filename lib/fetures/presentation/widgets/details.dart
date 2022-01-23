import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DetailsHelper extends StatelessWidget {
  const DetailsHelper({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
            color: Colors.grey,
            strokeWidth: 1,
            dashPattern: const <double>[5, 2],
            child: Icon(
              icon,
              size: 30,
              color: Colors.yellow[700],
            )),
        Text(text, style: Theme.of(context).textTheme.bodyText2)
      ],
    );
  }
}
