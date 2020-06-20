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
  OnListening _newListener;
  Set<OnListening> listeners = Set();

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
    this._newListener = onListening;
    this.listeners.add(_newListener);
  }

  void sendEvent(BuildContext context, DragType type, {int index}) {
    if (this._newListener != null) {
      this._newListener(context, type, index ?? 0);
    }
  }

  void removeEvent(OnListening onListening) {
    this.listeners.remove(onListening);
    _newListener = this.listeners.last;
  }

//  void backEvent() {
//    this.listeners.remove(_newListener);
//    this._newListener = this.listeners.last;
//  }

  void clear() {
    this.listeners.clear();
  }

  void open() {
    gotoBottom = true;
    notifyListeners();
    _animationController.forward();
  }
}

mixin DragEventListenerMixin {
  OnListening get dragListener;
}
