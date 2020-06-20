import 'package:flutter/cupertino.dart';

class OverlayDragController extends ChangeNotifier {
  AnimationController _animationController;

  bool gotoBottom = false;

  void setAnimationController(AnimationController controller) {
    _animationController = controller;
  }

  void close() {
    gotoBottom = false;
    notifyListeners();
    _animationController.reverse();
  }

  void open() {
    gotoBottom = true;
    notifyListeners();
    _animationController.forward();
  }
}
