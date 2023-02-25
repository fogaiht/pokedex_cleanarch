import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';
import 'pokedex_button.dart';

class PokedexDialog extends StatefulWidget {
  final String message;
  final String positiveButton;
  final String negativeButton;
  final VoidCallback onPositivePressed;
  final VoidCallback? onNegativePressed;

  const PokedexDialog({
    super.key,
    required this.message,
    required this.positiveButton,
    this.negativeButton = 'Cancelar',
    required this.onPositivePressed,
    this.onNegativePressed,
  });

  @override
  _PokedexDialogState createState() => _PokedexDialogState();
}

class _PokedexDialogState extends State<PokedexDialog>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.3,
        decoration: BoxDecoration(
          color: ThemeColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(offset: Offset(10.0, 10.0), blurRadius: 3.0),
            BoxShadow(
              offset: Offset(10.0, 10.0),
              blurRadius: 8.0,
              color: ThemeColors.pokeShadowColor,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 2),
            Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xff0075BE),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Flexible(
                  child: PokedexButton(
                    onTap: () {
                      widget.onPositivePressed();
                      _controller.reverse();
                      Navigator.pop(context);
                    },
                    label: widget.positiveButton,
                    scale: 0.75,
                  ),
                ),
                Flexible(
                  child: PokedexButton(
                    onTap: () {
                      widget.onNegativePressed?.call();
                      _controller.reverse();
                      Navigator.pop(context);
                    },
                    label: widget.negativeButton,
                    scale: 0.75,
                    reverseButton: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
