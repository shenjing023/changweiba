/// home page

import 'package:changweiba/routes.dart';
import 'package:changweiba/views/drawer/home_drawer.dart';
import 'package:changweiba/widget/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:changweiba/widget/rolling_nav_bar.dart';
import 'package:get/get.dart';

import '../../widget/never_overscroll_indicator.dart';
import '../search/search.dart';
import '../watchlist/watchlist.dart';

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
  ];

  var indicatorColors = <Color>[
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  var iconText = const <Widget>[
    Text('Home', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Friends', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Account', style: TextStyle(color: Colors.grey, fontSize: 12)),
  ];

  List<Widget> _pageList = [
    WatchlistPage(),
    PageDetails(title: '消息'),
    PageDetails(title: '我的'),
  ];

  _onTap(int index) {
    activeIndex = index;
    setState(() {});
    _pageController.jumpToPage(activeIndex);
  }

  @override
  Widget build(BuildContext context) {
    double navBarHeight = scaledHeight(context, 55);
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: TitleBar('肠胃吧',
            iconData: Icons.search_outlined,
            needRightLocalIcon: true,
            onRightIconPressed: (context) => Get.toNamed(Routes.search)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) => print(index),
        children: _pageList,
      ),
      bottomNavigationBar: SizedBox(
        height: navBarHeight,
        width: MediaQuery.of(context).size.width,
        // Option 1: Recommended
        child: RollingNavBar.iconData(
          // activeBadgeColors: <Color>[
          //   Color.fromARGB(255, 22, 21, 21),
          // ],
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
