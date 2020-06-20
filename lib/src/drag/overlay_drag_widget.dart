part of '../overlay.dart';

class OverlayDragWidget extends StatefulWidget {
  final DragMainButton child;
  final double initOffsetX;
  final double initOffsetY;
  final List<Widget> items;
  final OverlayDragController dragController;

  OverlayDragWidget({
    Key key,
    this.child,
    this.initOffsetX,
    this.initOffsetY,
    this.items = const [],
    this.dragController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OverlayDragState();
  }
}

class _OverlayDragState extends State<OverlayDragWidget> with TickerProviderStateMixin {
  AnimationController _movingHorizontalAnimController;
  AnimationController _movingVerticalAnimController;
  AnimationController _scaleItemAnimController;

  double top = 0.0;
  double left = 0.0;
  Size size;

  final double childWidth = 76.0;
  final double childHeight = 76.0;
  final double itemHeight = 50.0;
  final double spaceItem = 8.0;

//  bool gotoBottom = false;
  bool dragging = false;

  @override
  void initState() {
    super.initState();
    left = widget.initOffsetX ?? 0.0;
    top = widget.initOffsetY ?? 0.0;

    _movingHorizontalAnimController = AnimationController(
      vsync: this,
      upperBound: 1.0,
      lowerBound: 0.0,
      duration: Duration(milliseconds: 200),
    );

    _movingVerticalAnimController = AnimationController(
      vsync: this,
      upperBound: 1.0,
      lowerBound: 0.0,
      duration: Duration(milliseconds: 200),
    );

    _scaleItemAnimController = AnimationController(
      vsync: this,
      upperBound: 1.0,
      lowerBound: 0.0,
      duration: Duration(milliseconds: 200),
    );

    widget.dragController.setAnimationController(_scaleItemAnimController);
  }

  @override
  void dispose() {
    _movingHorizontalAnimController.dispose();
    _movingVerticalAnimController.dispose();
    _scaleItemAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size;
      if (left > size.width / 2) {
        left = size.width - childWidth;
      } else {
        left = 0.0;
      }
    }
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: _movingHorizontalAnimController,
          builder: (context, childHorizontal) {
            return AnimatedBuilder(
              animation: _movingVerticalAnimController,
              builder: (context, childVertical) {
                return Transform.translate(
                  offset: Offset(calculateX(), standardTop(calculateY())),
                  child: Column(
                    children: [
                      Draggable<Color>(
                        child: GestureDetector(
                          onTap: () async {
                            if (widget.items == null || widget.items.isEmpty) {
                              return;
                            }
                            if (widget.dragController.gotoBottom) {
                              widget.dragController.gotoBottom = false;
                              _scaleItemAnimController.reverse().whenComplete(
                                    () => _movingVerticalAnimController.reverse(),
                                  );
                            } else {
                              widget.dragController.gotoBottom = true;
                              _movingVerticalAnimController.forward(from: 0.0);
                              _scaleItemAnimController.forward();
                            }
                          },
                          child: widget.dragController.mainButton ?? widget.child,
                        ),
                        feedback: widget.child,
                        childWhenDragging: Container(),
                        onDragStarted: () {
                          _movingHorizontalAnimController.reset();
                          _movingVerticalAnimController.reset();
                          setState(() {
                            dragging = true;
                          });
                        },
                        onDragEnd: (detail) {
                          top = detail.offset.dy;
                          left = detail.offset.dx;
                          _movingHorizontalAnimController.forward(from: 0.0);
                          _movingVerticalAnimController.forward(from: 0.0);
                          setState(() {
                            dragging = false;
                          });
                        },
                      ),
                      !widget.dragController.gotoBottom
                          ? SizedBox.shrink()
                          : (dragging
                              ? SizedBox.shrink()
                              : AnimatedBuilder(
                                  animation: _scaleItemAnimController,
                                  builder: (context, childScale) {
                                    return Transform.scale(
                                      scale: (_scaleItemAnimController.value),
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: widget.dragController.children ?? widget.items,
                                      ),
                                    );
                                  },
                                )),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  double calculateX() {
    return left + (childWidth / 2) < (size.width / 2)
        ? (1 - _movingHorizontalAnimController.value) * left
        : left + ((size.width - left - childWidth) * _movingHorizontalAnimController.value);
  }

  double calculateY() {
    double fullItems = childHeight + spaceItem + (widget.items.length * itemHeight - widget.items.length * spaceItem);
    if (top + fullItems > size.height) {
      if (widget.dragController.gotoBottom) {
        return top +
            ((size.height - top - childHeight - (widget.items.length * itemHeight - widget.items.length * spaceItem)) *
                _movingVerticalAnimController.value);
      } else {
        return top;
      }
    }

    if (top + childHeight > size.height) {
      return top + ((size.height - top - childHeight) * _movingVerticalAnimController.value);
    }

    return top;
  }

  double standardTop(double top) {
    if (top < 0.0) {
      return 0.0;
    }

    if (top > size.height - childHeight) {
      return size.height - childHeight;
    }
    return top;
  }
}
