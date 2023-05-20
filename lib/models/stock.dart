class StockItem {
  final String name;
  final String symbol;
  // 最新价
  final double? latestPrice;
  // 涨幅
  final double? riseFallRate;
  // 持仓建议
  final int? bull;

  StockItem(this.name, this.symbol,
      {this.latestPrice, this.riseFallRate, this.bull});

  Map<String, dynamic> toJson() => {
        'name': name,
        'symbol': symbol,
        'latestPrice': latestPrice,
        'riseFallRate': riseFallRate,
        'bull': bull
      };

  @override
  String toString() {
    return 'StockItem: {name: $name, symbol: $symbol, latestPrice: $latestPrice, riseFallRate: $riseFallRate, bull: $bull}';
  }
}

class SearchStockResponse {
  int? code;
  List<Data>? data;
  String? message;

  SearchStockResponse({this.code, this.data, this.message});

  SearchStockResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? code;
  String? label;
  String? query;
  int? state;
  int? stockType;
  int? type;

  Data(
      {this.code,
      this.label,
      this.query,
      this.state,
      this.stockType,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    label = json['label'];
    query = json['query'];
    state = json['state'];
    stockType = json['stock_type'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['label'] = label;
    data['query'] = query;
    data['state'] = state;
    data['stock_type'] = stockType;
    data['type'] = type;
    return data;
  }
}
