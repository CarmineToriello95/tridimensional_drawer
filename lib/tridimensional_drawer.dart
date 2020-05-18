library tridimensional_drawer;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tridimensional_drawer/tridimensional_drawer_controller.dart';
export 'tridimensional_drawer_controller.dart';

class TridimensionalDrawer extends StatefulWidget {
  final Widget drawer;
  final Widget mainPage;
  final Widget backgroundPage;
  final TridimensionalDrawerController controller;
  final double maxSlide;
  final double dragFromLeftEdge;
  final double dragFromRightEdge;
  final Duration duration;

  TridimensionalDrawer({
    Key key,
    @required this.drawer,
    @required this.mainPage,
    @required this.backgroundPage,
    TridimensionalDrawerController controller,
    this.maxSlide = 250.0,
    this.dragFromLeftEdge = 50.0,
    this.dragFromRightEdge = 250.0,
    this.duration = const Duration(milliseconds: 250),
  })  : assert(drawer != null),
        assert(mainPage != null),
        assert(backgroundPage != null),
        controller = controller ?? TridimensionalDrawerController(),
        super(key: key);

  @override
  _TridimensionalDrawerState createState() => _TridimensionalDrawerState();
}

class _TridimensionalDrawerState extends State<TridimensionalDrawer>
    with TickerProviderStateMixin {
  bool _isDraggable;
  AnimationController _animationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    widget.controller.animation = _animationController;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: <Widget>[
              widget.backgroundPage,
              Transform.translate(
                offset: Offset(
                    -MediaQuery.of(context).size.width +
                        widget.maxSlide * (_animationController.value),
                    0),
                child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(
                        math.pi / 2 * (1 - _animationController.value),
                      ),
                    alignment: Alignment.centerRight,
                    child: widget.drawer),
              ),
              Transform.translate(
                offset: Offset(widget.maxSlide * _animationController.value, 0),
                child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi / 2 * _animationController.value),
                    alignment: Alignment.centerLeft,
                    child: widget.mainPage),
              )
            ],
          );
        },
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < widget.dragFromLeftEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > widget.dragFromRightEdge;
    _isDraggable = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isDraggable) {
      double delta = details.primaryDelta / widget.maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= MediaQuery.of(context).size.width) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value > 0.5) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
