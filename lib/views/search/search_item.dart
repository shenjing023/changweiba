import 'package:flutter/material.dart';

import '../../models/stock.dart';

class SearchItemWidget extends StatelessWidget {
  final StockItem data;

  const SearchItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.moving),
        title: Text(data.name),
        onTap: () {},
        trailing: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(Icons.add),
            onPressed: () {}));
  }
}
