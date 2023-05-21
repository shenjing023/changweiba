import 'package:flutter/material.dart';

import '../../models/stock.dart';

class SearchItemWidget extends StatelessWidget {
  final StockItem data;

  void Function(String, String)? onPressed;

  SearchItemWidget({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.moving),
        title: Text(data.name),
        onTap: () {
          debugPrint("onTap");
        },
        trailing: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              debugPrint("onPressed");
              if (onPressed != null) {
                onPressed!(data.symbol, data.name);
              }
            }));
  }
}
