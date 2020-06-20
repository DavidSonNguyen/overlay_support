import 'package:flutter/cupertino.dart';

class OverlayDragController extends ChangeNotifier {
  AnimationController _animationController;
  bool gotoBottom = false;
  Widget mainButton;

  OverlayDragController({
    this.mainButton,
  });

  void setAnimationController(AnimationController controller) {
    _animationController = controller;
  }

  void updateMainButton(Widget ui) {
    mainButton = ui;
    notifyListeners();
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
