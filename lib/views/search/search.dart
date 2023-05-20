import 'package:changweiba/api/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../models/pull_load.dart';
import '../../models/stock.dart';
import '../../widget/pull_load_widget.dart';
import 'search_bar.dart';
import 'search_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var controller = PullLoadWidgetControl();

  @override
  void initState() {
    super.initState();
    // List<StockItem> testData = [
    //   StockItem("华钰矿业", "SH600221", 12.56, -3.9, -1),
    //   // StockItem("大唐发电", "SH601123", 12.56, -3.9, -2),
    //   // StockItem("国电电力", "SH300103", 12.56, 3.9, 2),
    //   // StockItem("锦江酒店", "SZ300323", 12.56, -3.9, 1),
    // ];
    // // List<StockItem> testData = [];

    // controller.dataList.addAll(testData);
    controller.needEmpty = false;
  }

  onSearch(String text) async {
    SmartDialog.showLoading();
    try {
      var resp = await searchStock(text);
      SmartDialog.dismiss();
      // List<StockItem> testData = [
      //   StockItem("华钰矿业1", "SH6010221"),
      //   // StockItem("大唐发电", "SH601123", 12.56, -3.9, -2),
      //   // StockItem("国电电力", "SH300103", 12.56, 3.9, 2),
      //   // StockItem("锦江酒店", "SZ300323", 12.56, -3.9, 1),
      // ];
      // // List<StockItem> testData = [];
      // controller.addList(testData);
      controller.clear();
      if (resp != null) {
        if (resp.code == 200) {
          if (resp.data != null) {
            if (resp.data!.isNotEmpty) {
              controller
                  .add(StockItem(resp.data![0].query!, resp.data![0].code!));
            } else {
              SmartDialog.showToast("暂无数据");
            }
          } else {
            SmartDialog.showToast("暂无数据");
          }
        } else {
          SmartDialog.showToast(resp.message!);
        }
      }
    } catch (e) {
      SmartDialog.dismiss();
      debugPrint(e.toString());
      SmartDialog.showToast("internal server or network error");
    }
  }

  @override
  Widget build(BuildContext context) {
    PullLoadWidgetControl c = Get.put(controller, tag: "search");
    return Container(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarSearch(
          hintText: "输入股票名称或代码",
          onSearch: onSearch,
        ),
        body: PullLoadWidget(
          control: c,
          itemBuilder: (context, index) {
            return Obx(() => SearchItemWidget(
                  data: c.dataList.toList()[index],
                ));
          },
        ),
      ),
    );
  }
}
