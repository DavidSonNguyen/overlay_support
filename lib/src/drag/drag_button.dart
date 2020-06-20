import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DragMainButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback onTap;

  DragMainButton({
    Key key,
    @required this.child,
    this.onTap,
  }) {
    assert(child != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.0,
      height: 76.0,
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: child,
      ),
    );
  }
}

class DragItemButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback onTap;

  DragItemButton({
    Key key,
    @required this.child,
    this.onTap,
  }) {
    assert(child != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: child,
      ),
    );
  }
}
