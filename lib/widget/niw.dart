import 'package:flutter/material.dart';

class MyInkWell extends StatefulWidget {
  final Widget widget;
  final double? width;
  final double? height;
  final double radius;
  final Color? highlightColor;
  final Color? splashColor;
  final Color? color;
  final Function? tap;
  final Function? longPress;

  const MyInkWell({
    Key? key,
    required this.widget,
    required this.radius,
    this.width,
    this.height,
    this.highlightColor,
    this.splashColor,
    this.tap,
    this.color,
    this.longPress,
  }) : super(key: key);
  @override
  _myInkWellState createState() => _myInkWellState();
}

class _myInkWellState extends State<MyInkWell> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: widget.color ?? Colors.white,
        ),
        width: widget.width,
        height: widget.height,
        child: widget.longPress == null
            ? InkWell(
                splashFactory: InkSparkle.splashFactory,
                highlightColor: widget.highlightColor,
                splashColor: widget.splashColor,
                onTap: () {
                  if (widget.tap != null) {
                    widget.tap!();
                  }
                },
                borderRadius: BorderRadius.circular(widget.radius),
                child: widget.widget,
              )
            : InkWell(
                splashFactory: InkSparkle.splashFactory,
                highlightColor: widget.highlightColor,
                splashColor: widget.splashColor,
                onTap: () {
                  if (widget.tap != null) {
                    widget.tap!();
                  }
                },
                onLongPress: () {
                  widget.longPress!();
                },
                borderRadius: BorderRadius.circular(widget.radius),
                child: widget.widget,
              ),
      ),
    );
  }
}
