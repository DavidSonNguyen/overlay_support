import 'package:flutter/cupertino.dart';

class OverlayDragController {
  AnimationController _animationController;

  void setAnimationController(AnimationController controller) {
    _animationController = controller;
  }

  void close() {
    _animationController.reverse();
  }

  void open() {
    _animationController.forward();
  }
}
