import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DragMainButton extends StatelessWidget {
  final Widget child;

  DragMainButton({
    Key key,
    @required this.child,
  }) {
    assert(child != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      child: child,
    );
  }
}

class DragItemButton extends StatelessWidget {
  final Widget child;

  DragItemButton({
    Key key,
    @required this.child,
  }) {
    assert(child != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      child: child,
    );
  }
}
