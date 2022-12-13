import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../../shared/theme/colors.dart';
import '../../../shared/utils/pokedex_state.dart';
import '../../../shared/widgets/pokedex_spin_ring.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late NavigatorState _navigator;

  late SplashController _controller;

  late AnimationController _animController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _navigator = Navigator.of(context);
    _controller = GetIt.I.get<SplashController>();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            final routeName = await _controller.splashValidation();

            _navigator.pushReplacementNamed(routeName);
          });
        }
      });

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: const Interval(0.0, 1.0)),
    );

    _animController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: _opacityAnimation.value < 0.5
                      ? SizedBox(
                          height: widthSize * 0.5,
                          width: widthSize * 0.5,
                          child: SvgPicture.asset(
                            'images/openned_pokeball.svg',
                          ),
                        )
                      : SizedBox(
                          height: widthSize * 0.5,
                          width: widthSize * 0.5,
                          child: SvgPicture.asset(
                            'images/captured_pokeball.svg',
                          ),
                        ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Observer(
                builder: (_) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 1500),
                    opacity: (_controller.pokedexState == PokedexState.loading)
                        ? 1
                        : 0,
                    child: const PokedexSpinRing(color: ThemeColors.white),
                  );
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
