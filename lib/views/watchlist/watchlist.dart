import 'dart:math';

import 'package:changweiba/models/stock.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/pull_load.dart';
import '../../widget/pull_load_widget.dart';
import 'stock_item.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  ///控制列表滚动和监听
  final ScrollController scrollController = ScrollController();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  var controller = PullLoadWidgetControl();

  @override
  void dispose() {
    debugPrint("dispose");
    super.dispose();
    Get.delete<PullLoadWidgetControl>(tag: "watchlist");
  }

  @override
  void initState() {
    super.initState();

    List<StockItem> testData = [
      StockItem("华钰矿业", "SH600221",
          latestPrice: 1.56, riseFallRate: 1, bull: -2),
      StockItem("大唐发电", "SH601123",
          latestPrice: 12.56, riseFallRate: -1, bull: -2),
      // StockItem("国电电力", "SH300103", 12.56, 3.9, 2),
      // StockItem("锦江酒店", "SZ300323", 12.56, -3.9, 1),
      // StockItem("中青旅", "SH300123", 120.56, -3.9, 0),
      // StockItem("三变科技", "SH300123", 12.16, -3.9, 1),
      // StockItem("中国国航", "SZ310113", 2.56, -3.9, -2),
      // StockItem("春秋航空", "SH320123", 12.56, -3.9, -1),
      // StockItem("中国核电", "SH300123", 12.56, -3.9, 1),
      // StockItem("360", "SH300123  ", 12.56, 0, 0),
      // StockItem("华钰矿业", "SH600221", 12.56, -3.9, -2),
      // StockItem("大唐发电", "SH601123", 12.56, -3.9, -1),
      // StockItem("国电电力", "SH300103", 12.56, 3.9, 2),
      // StockItem("锦江酒店", "SZ300323", 12.56, -3.9, 1),
      // StockItem("中青旅", "SH300123", 120.56, -3.9, 2),
      // StockItem("三变科技", "SH300123", 12.16, -3.9, -1),
      // StockItem("中国国航", "SZ310113", 2.56, -3.9, 0),
      // StockItem("春秋航空", "SH320123", 12.56, -3.9, -2),
      // StockItem("中国核电", "SH300123", 12.56, -3.9, 1),
      // StockItem("360", "SH300123  ", 12.56, 0, 2),
    ];

    controller.addList(testData);
  }

  ///下拉刷新数据
  Future<void> requestRefresh() async {
    final _random = Random();
    int next(int min, int max) => min + _random.nextInt(max - min);
    var index = next(0, 1);
    var num = next(1, 100);
    controller.dataList[index] = StockItem("name", "symbol",
        latestPrice: 13.4 + num, riseFallRate: 0.3, bull: 2);
    controller.addList([
      StockItem("360", "SH300123  ",
          latestPrice: 12.56, riseFallRate: 0, bull: -2)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    PullLoadWidgetControl c = Get.put(controller, tag: "watchlist");
    return PullLoadWidget(
      control: c,
      itemBuilder: (context, index) {
        return Obx(() => StockItemCard(
              c.dataList[index],
            ));
      },
      onRefresh: requestRefresh,
    );

    // return PullLoadWidget(
    //   control: controller,
    //   itemBuilder: (context, index) {
    //     return StockItemCard(
    //       controller.dataList[index],
    //     );
    //   },
    //   onRefresh: requestRefresh,
    // );
  }
}
