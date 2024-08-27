//空页面

import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: const <Widget>[
            Image(
                image: AssetImage("assets/images/empty.jpg"),
                width: 200.0,
                height: 200.0),
            Text(
              "目前什么都没有",
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
