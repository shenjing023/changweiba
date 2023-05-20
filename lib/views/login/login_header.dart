import 'package:changweiba/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: defaultPadding),
        const Text(
          "消灭权限暴政，世界属于肠胃",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 3,
              child: SvgPicture.asset(
                "assets/icons/login.svg",
                height: 300,
                width: 300,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
