import 'package:flutter/cupertino.dart';

class OverlayDragController extends ChangeNotifier {
  AnimationController _animationController;
  bool gotoBottom = false;
  Widget mainButton;
  List<Widget> children;

  OverlayDragController({
    this.mainButton,
    this.children,
  });

  void setAnimationController(AnimationController controller) {
    _animationController = controller;
  }

  void updateMainButton(Widget ui) {
    mainButton = ui;
    notifyListeners();
  }

  void updateChildren(List<Widget> children) {
    this.children = children;
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
