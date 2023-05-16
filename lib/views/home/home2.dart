import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:changweiba/widget/rolling_nav_bar.dart';

double scaledHeight(BuildContext context, double baseSize) {
  return baseSize * (MediaQuery.of(context).size.height / 800);
}

double scaledWidth(BuildContext context, double baseSize) {
  return baseSize * (MediaQuery.of(context).size.width / 375);
}

class HomePage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color logoColor = Colors.red[600]!;
  int activeIndex = 0;

  final _pageController = PageController();

  var iconData = <IconData>[
    Icons.home,
    Icons.people,
    Icons.account_circle,
    // Icons.chat,
    // Icons.settings,
  ];

  // var badges = <int>[0, 0, 0];

  var iconText = <Widget>[
    Text('Home', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Friends', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Account', style: TextStyle(color: Colors.grey, fontSize: 12)),
    // Text('Chat', style: TextStyle(color: Colors.grey, fontSize: 12)),
    // Text('Settings', style: TextStyle(color: Colors.grey, fontSize: 12)),
  ];

  var indicatorColors = <Color>[
    Colors.red,
    Colors.orange,
    Colors.green,
    // Colors.blue,
    // Colors.purple,
  ];

  // List<Widget?> get badgeWidgets => indexed(badges)
  //     .map((Indexed indexed) => indexed.value > 0
  //         ? Text(indexed.value.toString(),
  //             style: TextStyle(
  //               color: indexed.index == activeIndex
  //                   ? indicatorColors[indexed.index]
  //                   : Colors.white,
  //             ))
  //         : null)
  //     .toList();

  // void incrementIndex() {
  //   setState(() {
  //     activeIndex = activeIndex < (iconData.length - 1) ? activeIndex + 1 : 0;
  //   });
  // }

  // _onAnimate(AnimationUpdate update) {
  //   setState(() {
  //     logoColor = update.color;
  //   });
  // }

  _onTap(int index) {
    activeIndex = index;
    setState(() {});
    _pageController.jumpToPage(activeIndex);
  }

  List<Widget> _pageList = [
    PageDetails(title: '首页'),
    PageDetails(title: '消息'),
    PageDetails(title: '我的'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[100],
      ),
      home: Builder(
        builder: (BuildContext context) {
          double largeIconHeight = MediaQuery.of(context).size.width;
          double navBarHeight = scaledHeight(context, 55);
          double topOffset = (MediaQuery.of(context).size.height -
                  largeIconHeight -
                  MediaQuery.of(context).viewInsets.top -
                  (navBarHeight * 2)) /
              2;
          return Scaffold(
            // drawer: ,
            appBar: AppBar(
              title: Text('Rolling Nav Bar: Tab ${activeIndex + 1}'),
            ),
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) => print(index),
              children: _pageList,
            ),

            bottomNavigationBar: SizedBox(
              height: navBarHeight,
              width: MediaQuery.of(context).size.width,
              // Option 1: Recommended
              child: RollingNavBar.iconData(
                activeBadgeColors: <Color>[
                  Colors.white,
                ],
                activeIndex: activeIndex,
                animationCurve: Curves.linear,
                animationType: AnimationType.spinOutIn,
                baseAnimationSpeed: 300,
                // badges: badgeWidgets,
                iconData: iconData,
                iconColors: <Color>[Colors.grey[800]!],
                iconText: iconText,
                indicatorColors: indicatorColors,
                iconSize: 25,
                indicatorRadius: scaledHeight(context, 30),
                // onAnimate: _onAnimate,
                onTap: _onTap,
              ),
            ),
          );
        },
      ),
    );
  }
}

class PageDetails extends StatefulWidget {
  PageDetails({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _PageDetailsState createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    // 这里的打印可以记录一下，后面会用到
    print('PageDetails build title:${widget.title}');
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          count += 1;
          setState(() {});
        },
        child: Center(
          child: Text('${widget.title} count:$count'),
        ),
      ),
    );
  }
}
