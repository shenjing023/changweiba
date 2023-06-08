import 'dart:convert';

import 'package:changweiba/api/stock.dart';
import 'package:changweiba/models/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../utils/chart_data.dart';
import 'k_line_chart.dart';
import '../../constants.dart' as consts;

class ChartPage extends StatefulWidget {
  StockItem? data;
  ChartPage({Key? key}) : super(key: key) {
    data = Get.arguments["data"];
  }

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  // List datas = [];
  List klineDatas = [];
  String bullRate = "0.0";

  @override
  void initState() {
    // getData();
    // getMockKlineData();
    getTradeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.data!.name)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          )
        ],
      ),
      body: klineDatas.isEmpty
          ? const Center(
              child: Text(
              "暂无数据",
              style: TextStyle(fontSize: 20),
            ))
          : ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 100,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(children: [
                          const TextSpan(
                              text: "持仓建议: ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                          TextSpan(
                            text: consts.bull[widget.data!.bull],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])),
                        Text.rich(TextSpan(children: [
                          const TextSpan(
                              text: "短期趋势: ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                            text: widget.data!.short,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                        ])),
                        Text.rich(TextSpan(children: [
                          const TextSpan(
                              text: "胜率: ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                          TextSpan(
                            text: "$bullRate%",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])),
                      ]),
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                KLineChart(
                  datas: klineDatas,
                ),
                const Divider(
                  height: 15,
                  color: Colors.grey,
                ),
              ],
            ),
    );
  }

  // getMockMinuteData() {
  //   rootBundle
  //       .loadString('lib/hb_kline_chart/mock_data/minute_line.json')
  //       .then((result) {
  //     List dataList = jsonDecode(result);
  //     List newData = [];
  //     double maxPrice = 0, minPrice = double.infinity;
  //     double sumPirce = 0;
  //     double avePirce = 0;
  //     int maxv = 0;
  //     for (var i = 0; i < dataList.length; i++) {
  //       double prePrice =
  //           ChartDataUtil.valueToNum(i == 0 ? "0" : dataList[i - 1]["price"])
  //               .toDouble();
  //       double price =
  //           ChartDataUtil.valueToNum(dataList[i]["price"]).toDouble();
  //       int vol = ChartDataUtil.valueToNum(dataList[i]["vol"]).toInt();
  //       // //涨跌状态
  //       bool upDown = price > prePrice;
  //       sumPirce += price;
  //       avePirce = sumPirce / (i + 1);
  //       if (price > maxPrice) {
  //         maxPrice = price;
  //       }
  //       if (price < minPrice) {
  //         minPrice = price;
  //       }
  //       if (vol > maxv) {
  //         maxv = vol;
  //       }
  //       Map m = {
  //         "price": price,
  //         "vol": vol,
  //         "time": dataList[i]["time"],
  //         "upDown": upDown,
  //         "ave": avePirce
  //       };
  //       newData.add(m);
  //     }
  //     datas = newData;
  //     setState(() {});
  //   });
  // }

  getMockKlineData() async {
    rootBundle.loadString('assets/k_line.json').then((result) {
      List dataList = jsonDecode(result);
      List data = [];
      for (var i = 0; i < dataList.length; i++) {
        Map m = dataList[i];
        Map newMap = {
          "open": ChartDataUtil.valueToNum(m["open"]).toDouble(),
          "high": ChartDataUtil.valueToNum(m["high"]).toDouble(),
          "low": ChartDataUtil.valueToNum(m["low"]).toDouble(),
          "close": ChartDataUtil.valueToNum(m["close"]).toDouble(),
          "vol": ChartDataUtil.valueToNum(m["vol"]).toDouble(),
          "date": m["date"],
          "bull": ChartDataUtil.valueToNum(m["bull"]).toDouble(),
        };
        data.add(newMap);
      }
      klineDatas = data;
      //计算各种指标
      ChartDataUtil.calculate(klineDatas);
      calculateBullRate();
      setState(() {});
    });
  }

  getTradeData() async {
    SmartDialog.showLoading();
    List data = [];
    try {
      var resp = await stockTrades(widget.data!.id!);
      if (resp.code == 200) {
        if (resp.data.nodes != null) {
          if (resp.data.nodes!.isNotEmpty) {
            for (var item in resp.data.nodes!) {
              data.add(<String, dynamic>{
                "open": ChartDataUtil.valueToNum(item.open).toDouble(),
                "close": ChartDataUtil.valueToNum(item.close).toDouble(),
                "high": ChartDataUtil.valueToNum(item.max).toDouble(),
                "low": ChartDataUtil.valueToNum(item.min).toDouble(),
                "vol": ChartDataUtil.valueToNum(item.volume).toDouble(),
                "date": item.date,
                "bull": ChartDataUtil.valueToNum(item.bull).toDouble()
              });
            }
            klineDatas = data;
          }
        }
      } else {
        SmartDialog.showToast(resp.message);
      }
    } catch (e) {
      debugPrintStack(label: e.toString());
      SmartDialog.showToast("internal server or network error");
    }
    SmartDialog.dismiss();
    if (klineDatas.isEmpty) {
      return;
    }
    ChartDataUtil.calculate(klineDatas);
    calculateBullRate();
    setState(() {});
  }

  // 计算持仓建议的胜率
  void calculateBullRate() {
    if (klineDatas.isEmpty) {
      return;
    }
    int numerator = 0;
    int denominator = klineDatas.length;
    for (var item in klineDatas) {
      // 涨跌幅
      var open = item["open"];
      var close = item["close"];
      var bull = item["bull"];
      double rate = (close - open) / open;
      if (rate.abs() <= 0.5 && bull == 0) {
        // 观望
        numerator++;
      } else if (rate > 0.5 && bull >= 1) {
        // 增持或买入
        numerator++;
      } else if (rate < -0.5 && bull <= -1) {
        // 减持或卖出
        numerator++;
      }
    }
    bullRate = ((numerator / denominator) * 100).toStringAsFixed(2);
  }
}
