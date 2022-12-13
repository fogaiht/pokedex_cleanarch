import 'package:flutter/material.dart';

class PokedexHeaderFooterPage extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? footer;

  const PokedexHeaderFooterPage({
    super.key,
    this.header,
    required this.body,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  header ?? const SizedBox(),
                  body,
                  footer ?? const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
