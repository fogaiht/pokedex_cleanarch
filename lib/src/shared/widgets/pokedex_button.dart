import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared_files.dart';
import '../utils/pokedex_state.dart';

class PokedexButton extends StatefulWidget {
  final PokedexState state;
  final void Function() onTap;
  final String label;
  final bool? reverseButton;

  const PokedexButton({
    super.key,
    this.state = PokedexState.start,
    required this.onTap,
    required this.label,
    this.reverseButton = false,
  });

  @override
  _PokedexButtonState createState() => _PokedexButtonState();
}

class _PokedexButtonState extends State<PokedexButton> {
  @override
  Widget build(BuildContext context) {
    final buttonHeight = MediaQuery.of(context).size.width * .15;
    final buttonWidth = buttonHeight * 3;
    final iconSize = buttonHeight * .8;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: buttonHeight,
      width: widget.state == PokedexState.loading ? buttonHeight : buttonWidth,
      child: FloatingActionButton.extended(
        heroTag: widget.label + DateTime.now().toString(),
        label: _StateChild(
          state: widget.state,
          iconSize: iconSize,
          startLabel: widget.label,
          reverseButton: widget.reverseButton!,
        ),
        backgroundColor: widget.state == PokedexState.error
            ? const Color(0xFFE34F4F)
            : widget.reverseButton!
                ? ThemeColors.secondaryColor
                : const Color(0xff0075BE),
        onPressed: () {
          widget.onTap();
        },
      ),
    );
  }
}

class _StateChild extends StatelessWidget {
  final PokedexState state;
  final double iconSize;
  final String startLabel;
  final bool reverseButton;

  const _StateChild({
    required this.state,
    required this.iconSize,
    required this.startLabel,
    required this.reverseButton,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PokedexState.start:
        return Text(
          startLabel,
          style: GoogleFonts.poppins(
            color: reverseButton
                ? const Color(0xff0075BE)
                : ThemeColors.secondaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        );
      case PokedexState.loading:
        return PokedexSpinRing(size: iconSize * .75, color: Colors.white);
      case PokedexState.success:
        return Icon(Icons.check, size: iconSize);
      case PokedexState.error:
        return Icon(Icons.close_outlined, size: iconSize);
    }
  }
}
