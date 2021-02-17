import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'enum_state.dart';

class RenderStyle1 extends StatelessWidget {
  final AnimationController controller;
  final Widget builderMain;
  final Widget builderMenu;
  final Function toggle;
  final DrawerState drawerState;
  final Color backgroundColor;
  RenderStyle1({
    this.controller,
    @required this.builderMain,
    @required this.builderMenu,
    this.toggle,
    this.drawerState,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final rightSlide = MediaQuery.of(context).size.width * 0.75;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double slide = rightSlide * controller.value;
        return Stack(
          children: [
            Scaffold(
              backgroundColor: backgroundColor,
              body: Transform.translate(
                offset: Offset(0, 0),
                child: builderMenu,
              ),
            ),
            Transform(
              transform: Matrix4.identity()..translate(slide),
              alignment: Alignment.center,
              child: Container(
                child: GestureDetector(
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
              ),
            ),
          ],
        );
      },
    );
  }
}