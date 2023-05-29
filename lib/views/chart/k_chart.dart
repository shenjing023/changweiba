import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/chart_data.dart';
import 'k_line_chart.dart';

class KChartPage extends StatefulWidget {
  String? symbol, name;
  KChartPage({Key? key}) : super(key: key) {
    symbol = Get.arguments['symbol'];
    name = Get.arguments['name'];
  }

  @override
  _KChartPageState createState() => _KChartPageState();
}

class _KChartPageState extends State<KChartPage> {
  List datas = [];
  List klineDatas = [];

  @override
  void initState() {
    // getData();
    // getMockMinuteData();
    getMockKlineData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.name ?? "")),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 80,
            margin: const EdgeInsets.all(8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.name!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "短期趋势：${widget.symbol}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ]),
          ),
          const Divider(
            height: 15,
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
      setState(() {});
    });
  }
}
