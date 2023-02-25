import 'package:flutter/material.dart';

import '../../../../shared/data/extensions.dart';
import '../../../../shared/theme/colors.dart';

class LoginFormCard extends StatelessWidget {
  final Widget child;
  const LoginFormCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size1 = context.constSize1;
    return Container(
      decoration: const BoxDecoration(
        color: ThemeColors.white,
        boxShadow: [
          BoxShadow(offset: Offset(10.0, 10.0), blurRadius: 3.0),
          BoxShadow(
            offset: Offset(10.0, 10.0),
            blurRadius: 8.0,
            color: ThemeColors.pokeShadowColor,
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: size1 * 16,
        right: size1 * 16,
        top: size1 * 16,
      ),
      margin: EdgeInsets.only(
        bottom: size1 * 32,
        right: size1 * 16,
        left: size1 * 16,
      ),
      child: child,
    );
  }
}
