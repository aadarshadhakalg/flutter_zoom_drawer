import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'enum_state.dart';

class RenderDefault extends StatelessWidget {
  final AnimationController controller;
  final Widget builderMain;
  final Widget builderMenu;
  final Function toggle;
  final DrawerState drawerState;

  RenderDefault({
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
        double left = (1 - controller.value) * rightSlide;
        return Stack(
          children: [
            GestureDetector(
              child: Stack(
                children: [
                  builderMain,
                  if (controller.value > 0) ...[
                    Opacity(
                      opacity: controller.value * 0.5,
                      child: Container(
                        color: Colors.black,
                      ),
                    )
                  ],
                ],
              ),
              onTap: () {
                if (drawerState == DrawerState.closed) {
                  toggle();
                }
              },
            ),
            Transform.translate(
              offset: Offset(-left, 0),
              child: Container(
                width: rightSlide,
                child: builderMenu,
              ),
            ),
          ],
        );
      },
    );
  }
}