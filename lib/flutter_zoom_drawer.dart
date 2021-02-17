library flutter_zoom_drawer;
import 'dart:ui' as ui show window;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'render_default.dart';
import 'render_style1.dart';
import 'render_style2.dart';
import 'render_style3.dart';
import 'render_style4.dart';
import 'render_style5.dart';
import 'render_style6.dart';
import 'enum_state.dart';
export 'enum_state.dart';

class ZoomDrawerController {
  /// callback function to open the drawer
  Function open;

  /// callback function to close the drawer
  Function close;

  /// callback function to toggle the drawer
  Function toggle;

  /// callback function to determine the status of the drawer
  Function isOpen;

  /// Drawer state notifier
  /// opening, closing, open, closed
  ValueNotifier<DrawerState> stateNotifier;
}

class ZoomDrawer extends StatelessWidget {
  ZoomDrawer({
    Key key,
    this.type = StyleState.styleDefault,
    this.controller,
    @required this.menuScreen,
    @required this.mainScreen,
    this.slideWidth = 275.0,
    this.slideHeight = 0.0,
    this.borderRadius = 16.0,
    this.angle = -12.0,
    this.backgroundColor = Colors.white,
    this.showShadow = false,
    this.openCurve,
    this.closeCurve,
    this.duration,
  }) : assert(angle <= 0.0 && angle >= -30.0);

  final StyleState type;

  /// controller to have access to the open/close/toggle function of the drawer
  final ZoomDrawerController controller;

  /// Screen containing the menu/bottom screen
  final Widget menuScreen;

  /// Screen containing the main content to display
  final Widget mainScreen;

  /// Sliding width of the drawer - defaults to 275.0
  final double slideWidth;
  final double slideHeight;

  /// Border radius of the slided content - defaults to 16.0
  final double borderRadius;

  /// Rotation angle of the drawer - defaults to -12.0
  final double angle;

  /// Background color of the drawer shadows - defaults to white
  final Color backgroundColor;

  /// Boolean, whether to show the drawer shadows - defaults to false
  final bool showShadow;

  /// Drawer slide out curve
  final Curve openCurve;

  /// Drawer slide in curve
  final Curve closeCurve;

  /// Drawer Duration
  final Duration duration;

  /// Static function to determine the device text direction RTL/LTR
  static bool isRTL() {
    return ui.window.locale.languageCode.toLowerCase() == "ar";
  }

  factory ZoomDrawer.style({
    Key key,
    StyleState type,
    Widget menuScreen,
    Widget mainScreen,
    double slideWidth,
    double slideHeight,
    double angle,
    bool showShadow,
    double borderRadius,
    Color backgroundColor,
  }) = _ZoomDrawerStyle;

  @override
  Widget build(BuildContext context) {
    print(slideWidth);
    return AnimatedDrawerWidget(
      controller: controller,
      duration: duration,
      slideWidth: slideWidth,
      angle: angle,
      builderAnimated:
          (AnimationController _animationController, DrawerState state, Function toggle) {
        return RenderDefault(
          builderMain: mainScreen,
          builderMenu: menuScreen,
          controller: _animationController,
          drawerState: state,
          toggle: toggle,
        );
      },
    );
  }
}



class _ZoomDrawerStyle extends ZoomDrawer {
  final StyleState type;
  _ZoomDrawerStyle({
    Color backgroundColor,
    double borderRadius = 16.0,
    Key key,
    Widget menuScreen,
    Widget mainScreen,
    double slideWidth,
    double slideHeight = 0.0,
    double angle = -12,
    bool showShadow,
    this.type = StyleState.style1,
  }) : super(
          key: key,
          menuScreen: menuScreen,
          mainScreen: mainScreen,
          slideWidth: slideWidth,
          slideHeight: slideHeight,
          showShadow: showShadow,
          angle: angle,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
        );
  Widget renderLayout() {
    switch (type) {
      case StyleState.style1:
        return AnimatedDrawerWidget(
          controller: controller,
          duration: duration,
          builderAnimated: (AnimationController controller, DrawerState state,
              Function toggle) {
            return RenderStyle1(
              backgroundColor: backgroundColor,
              builderMain: mainScreen,
              builderMenu: menuScreen,
              controller: controller,
              drawerState: state,
              toggle: toggle,
            );
          },
        );
        break;
      case StyleState.style2:
        return AnimatedDrawerWidget(
          controller: controller,
          duration: duration,
          builderAnimated: (AnimationController controller, DrawerState state,
              Function toggle) {
            return RenderStyle2(
              builderMain: mainScreen,
              builderMenu: menuScreen,
              controller: controller,
              drawerState: state,
              toggle: toggle,
            );
          },
        );
        break;
      case StyleState.style3:
        return AnimatedDrawerWidget(
          controller: controller,
          duration: duration,
          builderAnimated: (AnimationController controller, DrawerState state,
              Function toggle) {
            return RenderStyle3(
              builderMain: mainScreen,
              builderMenu: menuScreen,
              controller: controller,
              drawerState: state,
              toggle: toggle,
              angle: angle,
              slideWidth: slideWidth,
              slideHeight: slideHeight,
              showShadow: showShadow,
              backgroundColor: backgroundColor,
              borderRadius: borderRadius,
            );
          },
        );
        break;
      case StyleState.style4:
        return AnimatedDrawerWidget(
          controller: controller,
          duration: duration,
          builderAnimated: (AnimationController controller, DrawerState state,
              Function toggle) {
            return RenderStyle4(
              builderMain: mainScreen,
              builderMenu: menuScreen,
              controller: controller,
              drawerState: state,
              toggle: toggle,
            );
          },
        );
        break;
      case StyleState.style5:
        return AnimatedDrawerWidget(
          controller: controller,
          duration: duration,
          builderAnimated: (AnimationController controller, DrawerState state,
              Function toggle) {
            return RenderStyle5(
              builderMain: mainScreen,
              builderMenu: menuScreen,
              controller: controller,
              drawerState: state,
              toggle: toggle,
            );
          },
        );
        break;
      case StyleState.style6:
        return AnimatedDrawerWidget(
          controller: controller,
          duration: duration,
          builderAnimated: (AnimationController controller, DrawerState state,
              Function toggle) {
            return RenderStyle6(
              builderMain: mainScreen,
              builderMenu: menuScreen,
              controller: controller,
              drawerState: state,
              toggle: toggle,
            );
          },
        );
        break;
      default:
        return AnimatedDrawerWidget(
          controller: controller,
          duration: duration,
          builderAnimated: (AnimationController controller, DrawerState state,
              Function toggle) {
            return RenderDefault(
              builderMain: mainScreen,
              builderMenu: menuScreen,
              controller: controller,
              drawerState: state,
              toggle: toggle,
            );
          },
        );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return renderLayout();
  }
}

class AnimatedDrawerWidget extends StatefulWidget {
  final Color backgroundColor;
  final bool showShadow;
  final Curve openCurve;
  final Curve closeCurve;
  final double angle;
  final double slideWidth;
  final double slideHeight;
  final double borderRadius;
  AnimatedDrawerWidget({
    Key key,
    this.controller,
    this.duration,
    this.angle = -12.0,
    this.slideWidth = 275.0,
    this.slideHeight = 0.0,
    this.borderRadius = 16.0,
    this.backgroundColor = Colors.white,
    this.showShadow = false,
    this.openCurve,
    this.closeCurve,
    @required this.builderAnimated,
  }) : assert(angle <= 0.0 && angle >= -30.0);

  final ZoomDrawerController controller;
  final Duration duration;
  // final Widget Function()

  final Widget Function(
          AnimationController controller, DrawerState state, Function toggle)
      builderAnimated;

  @override
  _AnimatedWidgetState createState() => _AnimatedWidgetState();

  static _AnimatedWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<State<AnimatedDrawerWidget>>();
  }

}

class _AnimatedWidgetState extends State<AnimatedDrawerWidget>
    with SingleTickerProviderStateMixin {
  // static const Cubic slowMiddle = Cubic(0.19, 1, 0.22, 1);
  AnimationController _animationController;

  DrawerState _state = DrawerState.closed;
  /// Open drawer
  open() {
    _animationController.forward();
  }

  /// Close drawer
  close() {
    _animationController.reverse();
  }

  AnimationController get animationController => _animationController;

  toggle() {
    if (_state == DrawerState.open) {
      close();
    } else if (_state == DrawerState.closed) {
      open();
    }
  }

  bool isOpen() =>
      _state == DrawerState.open /* || state == DrawerState.opening*/;

  ValueNotifier<DrawerState> stateNotifier;

  @override
  void initState() {
    super.initState();

    stateNotifier = ValueNotifier(_state);

    /// Initialize the animation controller
    /// add status listener to update the menuStatus
    _animationController = AnimationController(
        vsync: this,
        duration: widget.duration is Duration
            ? widget.duration
            : Duration(milliseconds: 250))
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = DrawerState.opening;
            _updateStatusNotifier();
            break;
          case AnimationStatus.reverse:
            _state = DrawerState.closing;
            _updateStatusNotifier();
            break;
          case AnimationStatus.completed:
            _state = DrawerState.open;
            _updateStatusNotifier();
            break;
          case AnimationStatus.dismissed:
            _state = DrawerState.closed;
            _updateStatusNotifier();
            break;
        }
      });
    /// assign controller function to the widget methods
    if (widget.controller != null) {
      widget.controller.open = open;
      widget.controller.close = close;
      widget.controller.toggle = toggle;
      widget.controller.isOpen = isOpen;
      widget.controller.stateNotifier = stateNotifier;
    }
  }

  _updateStatusNotifier() {
    stateNotifier.value = _state;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// Detecting the slide amount to close the drawer in RTL & LTR
      onPanUpdate: (details) {
        if (_state == DrawerState.open && details.delta.dx < -6 ||
            details.delta.dx < 6) {
          toggle();
        }
      },
      child: widget.builderAnimated(
        _animationController,
        _state,
        toggle,
      ),
    );
  }
}
