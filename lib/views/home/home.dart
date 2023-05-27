/// home page

import 'package:changweiba/routes.dart';
import 'package:changweiba/views/drawer/home_drawer.dart';
import 'package:changweiba/widget/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:changweiba/widget/rolling_nav_bar.dart';
import 'package:get/get.dart';

import '../../widget/404.dart';
import '../post/post.dart';
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
  late WatchlistPage page1;
  late List<Widget> _pageList;

  final _pageController = PageController();

  var iconData = <IconData>[
    Icons.home,
    Icons.catching_pokemon_sharp,
    Icons.do_not_disturb,
  ];

  var indicatorColors = <Color>[
    Colors.red,
    Colors.orange,
    Colors.green,
  ];

  var iconText = const <Widget>[
    Text('Home', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Posts', style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text('Notfound', style: TextStyle(color: Colors.grey, fontSize: 12)),
  ];

  _onTap(int index) {
    activeIndex = index;
    setState(() {});
    _pageController.jumpToPage(activeIndex);
  }

  @override
  void initState() {
    super.initState();
    page1 = WatchlistPage();
    _pageList = [
      page1,
      PostPage(),
      Page404(),
    ];
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
            onRightIconPressed: (context) =>
                Get.toNamed(Routes.search)!.then((value) {
                  if (activeIndex == 0) {
                    page1.getState().requestRefresh();
                  }
                })),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) => {},
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
