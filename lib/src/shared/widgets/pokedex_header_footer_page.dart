import 'package:flutter/material.dart';

class PokedexHeaderFooterPage extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? footer;
  final bool centralizeBody;
  final bool hasHeaderSpacer;

  const PokedexHeaderFooterPage({
    super.key,
    this.header,
    required this.body,
    this.footer,
    this.centralizeBody = false,
    this.hasHeaderSpacer = false,
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
                  if (hasHeaderSpacer) ...{const Spacer()},
                  header ?? const SizedBox(),
                  if (centralizeBody) ...{const Spacer()},
                  body,
                  if (centralizeBody) ...{const Spacer()},
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
