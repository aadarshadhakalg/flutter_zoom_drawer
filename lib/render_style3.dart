import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'enum_state.dart';
import 'dart:math' show pi;
import 'dart:ui' as ui show window;
class RenderStyle3 extends StatelessWidget {
  final AnimationController controller;
  final Widget builderMain;
  final Widget builderMenu;
  final Function toggle;
  final DrawerState drawerState;
  final bool showShadow;
  final double angle;
  final double slideWidth;
  final Curve openCurve;
  final Curve closeCurve;
  final double slideHeight;
  final double borderRadius;
  final Color backgroundColor;
  static bool isRTL() {
    return ui.window.locale.languageCode.toLowerCase() == "ar";
  }
  double get _percentOpen => controller.value;
  RenderStyle3({
    Key key,
    this.controller,
    @required this.builderMain,
    @required this.builderMenu,
    this.toggle,
    this.drawerState,
    this.openCurve,
    this.closeCurve,
    this.angle = -12.0,
    this.slideWidth = 275.0,
    this.slideHeight = 0.0,
    this.borderRadius = 16.0,
    this.showShadow = false,
    this.backgroundColor = Colors.white,
  }) : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    final double slidePercent =
        isRTL() ? MediaQuery.of(context).size.width * .1 : 15.0;
    final Curve _slideOutCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
    final Curve _slideInCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
    final Curve _scaleDownCurve = Interval(0.0, 0.3, curve: Curves.easeOut);
    final Curve _scaleUpCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
    print('style3');
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Transform.translate(
                offset: Offset(0, 0),
                child: builderMenu,
              ),
            ),
            if (showShadow) ...[
              /// Displaying the first shadow
              AnimatedBuilder(
                animation: controller,
                builder: (_, w) => _zoomAndSlideContent(
                  w,
                  angle: (angle == 0.0) ? 0.0 : angle - 8,
                  scale: .9,
                  slideW: slidePercent * 2,
                  slideWidth: slideWidth,
                  slideHeight: slideHeight,
                  slidePercent: slidePercent,
                  scaleUpCurve: _scaleUpCurve,
                  openCurve: openCurve,
                  slideOutCurve: _slideOutCurve,
                  slideInCurve: _slideInCurve,
                  scaleDownCurve: _scaleDownCurve,
                ),
                child: Container(
                  color: backgroundColor.withAlpha(31),
                ),
              ),

              /// Displaying the second shadow
              AnimatedBuilder(
                animation: controller,
                builder: (_, w) => _zoomAndSlideContent(
                  w,
                  angle: (angle == 0.0) ? 0.0 : angle - 4.0,
                  scale: .95,
                  slideW: slidePercent,
                  slideWidth: slideWidth,
                  slideHeight: slideHeight,
                  slidePercent: slidePercent,
                  scaleUpCurve: _scaleUpCurve,
                  openCurve: openCurve,
                  slideOutCurve: _slideOutCurve,
                  slideInCurve: _slideInCurve,
                  scaleDownCurve: _scaleDownCurve,
                ),
                child: Container(
                  color: backgroundColor,
                ),
              ),
            ],
            AnimatedBuilder(
              animation: controller,
              builder: (_, w) => _zoomAndSlideContent(
                w,
                angle: angle,
                slideWidth: slideWidth,
                slideHeight: slideHeight,
                slidePercent: slidePercent,
                openCurve: openCurve,
                slideOutCurve: _slideOutCurve,
                slideInCurve: _slideInCurve,
                scaleDownCurve: _scaleDownCurve,
                scaleUpCurve: _scaleUpCurve,
              ),
              child: GestureDetector(
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
                onTap: () {
                  if (drawerState == DrawerState.closed) {
                    toggle();
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }

  _zoomAndSlideContent(
    Widget container, {
    double angle,
    double scale,
    double slideWidth,
    double slideHeight,
    double slideW = 0,
    double slideH = 0,
    double slidePercent,
    Curve openCurve,
    Curve slideOutCurve,
    Curve scaleDownCurve,
    Curve slideInCurve,
    Curve scaleUpCurve,
  }) {
    var scalePercent;
    final int _rtlSlide = isRTL() ? -1 : 1;

    /// determine current slide percent based on the MenuStatus
    switch (DrawerState.opening) {
      case DrawerState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case DrawerState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case DrawerState.opening:
        slidePercent = (openCurve ?? slideOutCurve).transform(_percentOpen);
        scalePercent = scaleDownCurve.transform(_percentOpen);
        break;
      case DrawerState.closing:
        slidePercent = (closeCurve ?? slideInCurve).transform(_percentOpen);
        scalePercent = scaleUpCurve.transform(_percentOpen);
        break;
    }

    /// calculated sliding amount based on the RTL and animation value
    final slideAmountWidth = (slideWidth - slideW) * slidePercent * _rtlSlide;
    final slideAmountHeight = (slideHeight - slideH) * slidePercent * _rtlSlide;

    /// calculated scale amount based on the provided scale and animation value
    final contentScale = (scale ?? 1.0) - (0.2 * scalePercent);

    /// calculated radius based on the provided radius and animation value
    final cornerRadius = borderRadius * _percentOpen;

    /// calculated rotation amount based on the provided angle and animation value
    final rotationAngle =
        (((angle ?? angle) * pi * _rtlSlide) / 180) * _percentOpen;

    return Transform(
      transform:
          Matrix4.translationValues(slideAmountWidth, slideAmountHeight, 0.0)
            ..rotateZ(rotationAngle)
            ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: container,
      ),
    );
  }
}