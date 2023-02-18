import 'package:flutter/material.dart';

class PokedexText extends StatelessWidget {
  final String label;
  final double? fontSize;
  final Offset? shadowOffset;
  const PokedexText({
    super.key,
    this.fontSize,
    required this.label,
    this.shadowOffset = const Offset(10.0, 10.0),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Pokemon',
        color: Colors.yellow,
        shadows: [
          Shadow(offset: shadowOffset!, blurRadius: 3.0),
          Shadow(
            offset: shadowOffset!,
            blurRadius: 8.0,
            color: const Color.fromARGB(125, 0, 0, 255),
          ),
        ],
      ),
    );
  }
}
