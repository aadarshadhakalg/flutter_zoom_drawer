import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'enum_state.dart';

class RenderStyle6 extends StatelessWidget {
  final AnimationController controller;
  final Widget builderMain;
  final Widget builderMenu;
  final Function toggle;
  final DrawerState drawerState;

  RenderStyle6({
    this.controller,
    @required this.builderMain,
    @required this.builderMenu,
    this.toggle,
    this.drawerState,
  });
  @override
  Widget build(BuildContext context) {
    final Animation<double> scaleAnimation = new Tween(
      begin: 0.9,
      end: 1.0,
    ).animate(new CurvedAnimation(
      parent: controller,
      curve: Curves.slowMiddle,
    ));
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: [
            builderMain,
            if (controller.value > 0) ...[
              Opacity(
                // opacity: _animationController.value,
                opacity: controller
                    .drive(CurveTween(curve: Curves.easeIn))
                    .value, //Curves.easeOut
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: GestureDetector(
                    child: Stack(
                      children: <Widget>[
                        builderMenu,
                        Padding(
                          padding: EdgeInsets.only(right: 24, top: 24),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: FloatingActionButton(
                              onPressed: () {
                                if (drawerState == DrawerState.closed) {
                                  toggle();
                                }
                              },
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              child: Icon(Icons.close, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ],
        );
      },
    );
  }
}