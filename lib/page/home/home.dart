import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../state/home.dart';
import '../navigation/side.dart';
import '../post/post_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final navItems = [
    SideNavigationItem(icon: Icons.home, title: '谈笑风生'),
    SideNavigationItem(icon: Icons.trending_up_rounded, title: '赌场'),
    SideNavigationItem(icon: Icons.settings, title: '设置'),
  ];
  final PageController pageController = PageController();
  final List<Widget> pageList = [
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 800,
          minWidth: 600,
        ),
        child: PostList(),
      ),
    ),
    const Center(
      child: Text('第二页'),
    ),
    const Center(
      child: Text('第三页'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: ref.watch(isSidebarOpenProvider) ? 120 : 0,
              child: SideNavigation(
                items: navItems,
                onItemSelected: (index) {
                  pageController.jumpToPage(index);
                },
              )),
          // 主要内容
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // 顶部栏
                  SizedBox(
                    height: 30,
                    // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            size: 15,
                          ),
                          onPressed: () {
                            ref.read(isSidebarOpenProvider.notifier).change();
                          },
                          // iconSize: 15,
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              '',
                              // style: TextStyle(
                              //   fontSize: 20,
                              //   fontWeight: FontWeight.bold,
                              // ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          iconSize: 15,
                          onPressed: () {
                            // TODO: 实现设置功能
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pageList.length,
                      itemBuilder: (context, index) => pageList[index],
                      controller: pageController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 实现新任务创建功能
          SmartDialog.showToast("请登录");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
