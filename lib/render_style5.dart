import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'enum_state.dart';
import 'dart:math' show pi;

class RenderStyle5 extends StatelessWidget {
  final AnimationController controller;
  final Widget builderMain;
  final Widget builderMenu;
  final Function toggle;
  final DrawerState drawerState;

  RenderStyle5({
    this.controller,
    @required this.builderMain,
    @required this.builderMenu,
    this.toggle,
    this.drawerState,
  });
  @override
  Widget build(BuildContext context) {
    final rightSlide = MediaQuery.of(context).size.width * 0.75;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double x = controller.value * (rightSlide / 2.52);
        double scale = 1 - (controller.value * 0.3);
        double rotate = controller.value * (pi / 4);
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Transform.translate(
                offset: Offset(0, 0),
                child: builderMenu,
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0009)
                ..translate(x)
                ..scale(scale)
                ..rotateY(-rotate),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  if (drawerState == DrawerState.closed) {
                    toggle();
                  }
                },
                child: Stack(
                  children: [
                    builderMain,
                    if (controller.value > 0) ...[
                      Opacity(
                        opacity: 0,
                        child: Container(
                          color: Colors.black,
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}