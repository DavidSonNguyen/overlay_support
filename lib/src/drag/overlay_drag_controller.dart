import 'package:flutter/cupertino.dart';

enum DragType {
  main,
  item,
}

typedef OnListening = Function(BuildContext context, DragType type, int index);

class OverlayDragController extends ChangeNotifier {
  AnimationController _animationController;
  bool gotoBottom = false;
  Widget mainButton;
  List<Widget> children;
  OnListening _onListening;

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

  void setOnListener(OnListening onListening) {
    this._onListening = onListening;
  }

  void sendEvent(BuildContext context, DragType type, {int index}) {
    if (this._onListening != null) {
      this._onListening(context, type, index ?? 0);
    }
  }

  void open() {
    gotoBottom = true;
    notifyListeners();
    _animationController.forward();
  }
}
