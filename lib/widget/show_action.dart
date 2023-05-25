import 'package:flutter/material.dart';

import 'show_pop.dart';

Widget _optionBar(String txt, IconData? icon, BuildContext context) {
  return Container(
    height: 50,
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon == null
            ? Container()
            : Icon(
                icon,
                color: Colors.black,
              ),
        icon == null ? Container() : Container(width: 15),
        txt == null
            ? Container()
            : Text(txt,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                )),
      ],
    ),
  );
}

showAction({
  required List<String> options,
  List<IconData>? icons,
  Function? tap,
  required BuildContext context,
}) {
  assert(((options).length == (icons ?? []).length) || icons!.isEmpty);
  List<Widget> _buildOptions() {
    List<Widget> tmp = [];
    if (icons!.isNotEmpty) {
      for (var i = 0; i < options.length; i++) {
        String option = options[i];
        IconData icon = icons[i];
        tmp.add(
          GestureDetector(
            onTap: () {
              if (tap != null) tap(option);
            },
            child: _optionBar(option, icon, context),
          ),
        );
      }
    } else {
      for (var i = 0; i < options.length; i++) {
        String option = options[i];
        tmp.add(
          GestureDetector(
            onTap: () {
              if (tap != null) tap(i);
            },
            child: _optionBar(option, null, context),
          ),
        );
      }
    }
    return tmp;
  }

  showPopWithHeight(
    context,
    [
      Center(
        child: Container(
          width: 30,
          height: 5,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFD3D3D3),
          ),
        ),
      ),
      ..._buildOptions(),
      Container(
        height: 1,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey,
        margin: const EdgeInsets.symmetric(vertical: 10),
      ),
      GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: _optionBar("取消", null, context)),
    ],
    (70 + (options.length + 1) * 60).toDouble(),
  );
}
