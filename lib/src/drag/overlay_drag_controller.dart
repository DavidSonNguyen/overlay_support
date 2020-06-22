import 'package:flutter/cupertino.dart';

enum DragType {
  main,
  item,
}

typedef OnListening = Function(DragType type, int index);

class OverlayDragController extends ChangeNotifier {
  AnimationController _animationController;
  bool gotoBottom = false;
  Widget mainButton;
  List<Widget> children = [];
  Map<String, OnListening> _mapListeners = {};
  String _currentKey = '';

  OverlayDragController({
    this.mainButton,
    this.children,
  }) {
    this.children ??= [];
  }

  void setAnimationController(AnimationController controller) {
    _animationController = controller;
  }

  Future<void> updateMainButton(Widget ui) async {
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

  void setOnListener(String key, OnListening onListening) {
    this._mapListeners[key] = onListening;
    this._currentKey = key;
  }

  void sendEvent(DragType type, {int index}) {
    if (this._mapListeners[_currentKey] != null) {
      this._mapListeners[_currentKey](type, index ?? 0);
    }
  }

  void removeEvent(String key) {
    this._mapListeners.remove(key);
    this._currentKey = this._mapListeners.keys.last ?? '';
  }

//  void backEvent() {
//    this.listeners.remove(_newListener);
//    this._newListener = this.listeners.last;
//  }

  void clear() {
    this._mapListeners.clear();
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
