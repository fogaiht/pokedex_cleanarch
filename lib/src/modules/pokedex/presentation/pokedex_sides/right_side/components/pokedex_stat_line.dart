import 'package:flutter/material.dart';

class PokedexStatLine extends StatelessWidget {
  final String description;
  final int value;

  const PokedexStatLine({
    super.key,
    required this.description,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final double heightSize = MediaQuery.of(context).size.height * 0.9;
    final double widthSize = MediaQuery.of(context).size.width * 0.9;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              description,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: heightSize * 0.023,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          '$value',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: heightSize * 0.023,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        Column(
          children: [
            Stack(
              children: [
                Container(
                  width: widthSize * 0.4,
                  height: heightSize * 0.025,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                  ),
                ),
                Container(
                  width: widthSize * 0.4 * 0.45,
                  height: heightSize * 0.025,
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      border: Border(
                        top: BorderSide(width: 0.5),
                        bottom: BorderSide(width: 0.5),
                        left: BorderSide(width: 0.5),
                      )),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
