import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String? title;

  final IconData? iconData;

  final ValueChanged? onRightIconPressed;

  final bool needRightLocalIcon;

  final Widget? rightWidget;

  final GlobalKey rightKey = GlobalKey();

  TitleBar(this.title,
      {super.key,
      this.iconData,
      this.onRightIconPressed,
      this.needRightLocalIcon = false,
      this.rightWidget});

  @override
  Widget build(BuildContext context) {
    Widget? widget = rightWidget;
    if (rightWidget == null) {
      widget = (needRightLocalIcon)
          ? IconButton(
              icon: Icon(
                iconData,
                key: rightKey,
                size: 19.0,
              ),
              onPressed: () {
                // RenderBox renderBox2 =
                //     rightKey.currentContext?.findRenderObject() as RenderBox;
                // var position = renderBox2.localToGlobal(Offset.zero);
                // var size = renderBox2.size;
                // var centerPosition = Offset(
                //   position.dx + size.width / 2,
                //   position.dy + size.height / 2,
                // );
                onRightIconPressed?.call(context);
              })
          : new Container();
    }
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        widget!
      ],
    );
  }
}
