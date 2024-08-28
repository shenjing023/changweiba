import 'package:flutter/material.dart';
import '../widget/btn_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home.g.dart';

class MainState {
  ///选择index
  late int selectedIndex;

  ///Navigation的item信息
  late List<BtnInfo> sideItems;

  ///PageView页面
  late List<Widget> pageList;
  late PageController pageController;

  MainState({
    required this.pageController,
    required this.sideItems,
    required this.pageList,
    this.selectedIndex = 0,
  }) {
    //item栏目
    sideItems = [
      BtnInfo(
        title: "谈笑风生",
        icon: const Icon(Icons.home),
      ),
      BtnInfo(
        title: "赌场",
        icon: const Icon(Icons.trending_up_rounded),
      ),
      BtnInfo(
        title: "设置",
        icon: const Icon(Icons.settings),
      ),
    ];
  }
}

@Riverpod(keepAlive: true)
class IsSidebarOpen extends _$IsSidebarOpen {
  @override
  bool build() => false;

  void change() {
    state = !state;
  }
}
