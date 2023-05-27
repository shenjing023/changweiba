import 'dart:async';
import 'dart:math';

import 'package:changweiba/models/stock.dart';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../api/stock.dart';
import '../../models/pull_load.dart';
import '../../widget/pull_load_widget.dart';
import 'stock_item.dart';
import '../../utils/common_utils.dart';

class WatchlistPage extends StatefulWidget {
  WatchlistPage({super.key});

  late _WatchlistPageState watchlistPageState;

  @override
  _WatchlistPageState createState() {
    watchlistPageState = _WatchlistPageState();
    return watchlistPageState;
  }

  _WatchlistPageState getState() => watchlistPageState;
}

class _WatchlistPageState extends State<WatchlistPage> {
  ///控制列表滚动和监听
  final ScrollController scrollController = ScrollController();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  var controller = PullLoadWidgetControl();

  Timer? timer;

  @override
  void dispose() {
    debugPrint("dispose");
    // 取消定时器
    timer?.cancel();
    super.dispose();
    Get.delete<PullLoadWidgetControl>(tag: "watchlist");
  }

  @override
  void initState() {
    super.initState();

    // List<StockItem> testData = [
    //   StockItem("华钰矿业", "SH600221",
    //       latestPrice: 1.56, riseFallRate: 1, bull: -2),
    //   StockItem("大唐发电", "SH601123",
    //       latestPrice: 12.56, riseFallRate: -1, bull: -2),
    // ];

    // controller.addList(testData);

    manuallyUpdateData();

    // 设置定时器，每隔30秒刷新数据
    timer = Timer.periodic(
        const Duration(seconds: 30), (Timer t) => automaticallyUpdateData());

    controller.needLoadMore = false;
  }

  Future<XQStockData?> _getStockQuoteData(String symbol) async {
    try {
      var resp = await getStockQuoteData(symbol);
      if (resp != null) {
        if (resp.errorCode == 0) {
          if (resp.data != null) {
            return resp.data![0];
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      SmartDialog.showToast("internal server or network error");
    }
    return null;
  }

  Future<void> automaticallyUpdateData() async {
    if (!CommonUtils.isBetweenNineThirtyAndFifteen()) {
      return;
    }
    for (var item in controller.dataList) {
      var xqsd = await _getStockQuoteData(item.symbol);
      if (xqsd != null) {
        item.latestPrice = xqsd.current;
        item.riseFallRate = xqsd.percent;
      } else {
        return;
      }
    }
    controller.update();
  }

  Future<void> manuallyUpdateData() async {
    SmartDialog.showLoading();
    var items = await getSubscribedStocks2();
    if (items.isEmpty) {
      SmartDialog.dismiss();
      return;
    }
    for (var item in items) {
      var xqsd = await _getStockQuoteData(item.symbol);
      if (xqsd != null) {
        item.latestPrice = xqsd.current;
        item.riseFallRate = xqsd.percent;
      } else {
        debugPrint("xqsd is null");
        SmartDialog.dismiss();
        return;
      }
    }
    SmartDialog.dismiss();
    controller.clear();
    controller.addList(items);
  }

  Future<List<StockItem>> getSubscribedStocks2() async {
    List<StockItem> items = [];
    try {
      var resp = await subscribedStocks();
      if (resp.code == 200) {
        if (resp.data.nodes != null) {
          if (resp.data.nodes!.isNotEmpty) {
            for (var item in resp.data.nodes!) {
              items.add(StockItem(item.name!, item.symbol!,
                  latestPrice: 0, riseFallRate: 0, bull: item.bull!));
            }
          }
        }
      } else {
        SmartDialog.showToast(resp.message);
      }
    } catch (e) {
      debugPrint(e.toString());
      SmartDialog.showToast("internal server or network error");
    }
    return items;
  }

  // 刷新stock实时数据
  Future<void> refreshStockData() async {
    //test
    final _random = Random();
    int next(int min, int max) => min + _random.nextInt(max - min);
    var index = next(0, controller.dataList.length);
    var num = next(-10, 10);
    controller.dataList[index].price = 13.4 + num;
    controller.dataList[index].fallRate = 0.1 + num;
    controller.update();
    // TODO:
  }

  // Future<void> getSubcribedStocks() async {
  //   SmartDialog.showLoading();
  //   try {
  //     var resp = await subscribedStocks();
  //     SmartDialog.dismiss();
  //     if (resp.code == 200) {
  //       if (resp.data.nodes != null) {
  //         if (resp.data.nodes!.isNotEmpty) {
  //           controller.clear();
  //           List<StockItem> items = [];
  //           for (var item in resp.data.nodes!) {
  //             items.add(StockItem(item.name!, item.symbol!,
  //                 latestPrice: 0, riseFallRate: 0, bull: item.bull!));
  //           }
  //           controller.addList(items);
  //         } else {
  //           SmartDialog.showToast("暂无数据");
  //         }
  //       } else {
  //         SmartDialog.showToast("暂无数据");
  //       }
  //     } else {
  //       SmartDialog.showToast(resp.message);
  //     }
  //   } catch (e) {
  //     SmartDialog.dismiss();
  //     debugPrint(e.toString());
  //     SmartDialog.showToast("internal server or network error");
  //   }
  // }

  ///下拉刷新数据
  Future<void> requestRefresh() async {
    await manuallyUpdateData();
  }

  Future<void> onItemLongPress(String symbol, String name) async {
    var isDelete = await SmartDialog.show(builder: (_) {
      return AlertDialog(
          title: Text(name),
          content: const Text("取消订阅该股票?"),
          actions: [
            TextButton(
              onPressed: () => SmartDialog.dismiss(result: false),
              child: const Text("否"),
            ),
            TextButton(
              child: const Text("是"),
              onPressed: () => SmartDialog.dismiss(result: true),
            )
          ]);
    });
    if (isDelete) {
      try {
        var resp = await unsubscribeStock(symbol);
        SmartDialog.dismiss();
        if (resp.code == 200) {
          if (resp.data) {
            // SmartDialog.showToast("订阅成功");
            await manuallyUpdateData();
          } else {
            SmartDialog.showToast("取消订阅失败");
          }
        } else {
          SmartDialog.showToast(resp.message);
        }
      } catch (e) {
        SmartDialog.dismiss();
        debugPrint(e.toString());
        SmartDialog.showToast("internal server or network error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PullLoadWidgetControl c = Get.put(controller, tag: "watchlist");
    return PullLoadWidget(
      control: c,
      itemBuilder: (context, index) {
        return Obx(() => StockItemCard(
              c.dataList[index],
              onLongPress: onItemLongPress,
            ));
      },
      onRefresh: requestRefresh,
    );
  }
}
