import 'package:flutter/material.dart';

import '../../constants.dart' as consts;
import '../../models/stock.dart';

class StockItemCard extends StatelessWidget {
  final StockItem data;
  final Function(String, String)? onTap;
  final Function(String, String)? onLongPress;

  StockItemCard(this.data, {this.onLongPress, this.onTap});

  @override
  Widget build(BuildContext context) {
    Color rateColor = Colors.grey;
    if (data.riseFallRate! > 0) {
      rateColor = Colors.red;
    } else if (data.riseFallRate! < 0) {
      rateColor = Colors.green;
    }
    Color bullColor = Colors.grey;
    if (data.bull! > 0) {
      bullColor = Colors.red;
    } else if (data.bull! < 0) {
      bullColor = Colors.green;
    }
    return GestureDetector(
      onLongPress: () {
        onLongPress?.call(data.symbol, data.name);
      },
      onTap: () {
        onTap?.call(data.symbol, data.name);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.symbol,
                  style: const TextStyle(
                    color: Color.fromRGBO(69, 73, 86, 1),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 30,
                  child: Text(
                    '${consts.bull[data.bull]}',
                    style: TextStyle(
                      fontSize: 15,
                      color: bullColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 30,
                  child: Text(
                    '${data.latestPrice}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 30,
                  color: rateColor,
                  child: Text(
                    '${data.riseFallRate}%',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
