import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWidget extends StatefulWidget {
  final bool? show;
  double? size;
  final double? width;
  final double? height;
  final double? radius;
  String? path;
  SvgWidget({
    Key? key,
    this.size,
    this.path,
    this.width,
    this.height,
    this.show,
    this.radius,
  }) : super(key: key);
  @override
  _SvgWidgetState createState() => _SvgWidgetState();
}

class _SvgWidgetState extends State<SvgWidget> {
  @override
  Widget build(BuildContext context) {
    return (widget.show == null || widget.show!)
        ? SvgPicture.asset(
            widget.path ?? 'assets/images/logo.svg',
            width: widget.size ?? (widget.width ?? 40),
            height: widget.size ?? (widget.height ?? 40),
            placeholderBuilder: (BuildContext context) =>
                const CircularProgressIndicator(),
          )
        : Container();
  }
}
