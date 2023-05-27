import 'package:flutter/material.dart';

import 'niw.dart';

class BackToTop extends StatefulWidget {
  ScrollController? controller;
  Widget? child;
  bool show;
  double? bottom;
  bool? animation;
  bool? attachBtn;
  Function? tap;
  Function? refresh;
  Widget? widget;
  Color? color;
  BackToTop({
    Key? key,
    this.child,
    required this.show,
    this.color,
    this.controller,
    this.bottom,
    this.animation,
    this.attachBtn,
    this.widget,
    this.tap,
    this.refresh,
  }) : super(key: key);

  @override
  _BackToTopState createState() => _BackToTopState();
}

class _BackToTopState extends State<BackToTop> with TickerProviderStateMixin {
  late AnimationController controller; //动画控制器
  late Animation<double> animation;
  double _right = -200;
  @override
  void initState() {
    super.initState();
    widget.controller!.addListener(() {
      if (widget.show) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween(begin: -200.0, end: 20.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {
          _right = animation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: widget.child ?? Container(),
        ),
        Container(),
        widget.attachBtn == null
            ? Container()
            : Positioned(
                right: 20,
                bottom: (widget.bottom ?? 25) + (_right + 200) / 3.5 + 10,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 10,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: MyInkWell(
                    tap: () {
                      if (widget.tap != null) widget.tap!();
                    },
                    color: widget.color ?? Colors.lightBlue,
                    widget: const SizedBox(
                      width: 55,
                      height: 55,
                      child: Center(
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    radius: 100,
                  ),
                )),
        Positioned(
            right: _right,
            bottom: widget.bottom ?? 20,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: MyInkWell(
                tap: () {
                  widget.controller!.animateTo(
                    0,
                    duration: Duration(
                        milliseconds: (widget.animation ?? true ? 500 : 1)),
                    curve: Curves.ease,
                  );
                  widget.show = false;
                  setState(() {});
                },
                color: widget.color ?? Colors.lightBlue,
                widget: SizedBox(
                  width: 55,
                  height: 55,
                  // padding: EdgeInsets.all(20),
                  child: widget.widget ??
                      const Icon(
                        Icons.arrow_drop_up,
                        size: 25,
                        color: Colors.white,
                      ),
                ),
                radius: 100,
              ),
            )),
      ],
    );
  }
}
