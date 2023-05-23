class StockItem {
  final String name;
  final String symbol;
  // 最新价
  double? latestPrice;
  // 涨幅
  double? riseFallRate;
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

  set price(double value) {
    latestPrice = value;
  }

  set fallRate(double value) {
    riseFallRate = value;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['label'] = label;
    data['query'] = query;
    data['state'] = state;
    data['stock_type'] = stockType;
    data['type'] = type;
    return data;
  }
}

class SubscribedStocks {
  List<SubscribedStocksNodes>? nodes;
  int? totalCount;

  SubscribedStocks({this.nodes, this.totalCount});

  SubscribedStocks.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = <SubscribedStocksNodes>[];
      json['nodes'].forEach((v) {
        nodes!.add(SubscribedStocksNodes.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nodes != null) {
      data['nodes'] = nodes!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }
}

class SubscribedStocksNodes {
  int? id;
  String? symbol;
  String? name;
  int? bull;

  SubscribedStocksNodes({this.id, this.symbol, this.name, this.bull});

  SubscribedStocksNodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    bull = json['bull'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['bull'] = bull;
    return data;
  }
}

// 雪球股票行情的数据
class XQStock {
  List<XQStockData>? data;
  int? errorCode;
  String? errorDescription;

  XQStock({this.data, this.errorCode, this.errorDescription});

  XQStock.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <XQStockData>[];
      json['data'].forEach((v) {
        data!.add(XQStockData.fromJson(v));
      });
    }
    errorCode = json['error_code'];
    errorDescription = json['error_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error_code'] = errorCode;
    data['error_description'] = errorDescription;
    return data;
  }
}

class XQStockData {
  String? symbol;
  double? current;
  double? percent; //涨跌幅
  double? chg;
  int? timestamp;
  int? volume;
  double? turnoverRate; //换手率
  double? amplitude; //振幅
  double? open;
  double? lastClose;
  double? high;
  double? low;

  XQStockData(
      {this.symbol,
      this.current,
      this.percent,
      this.chg,
      this.timestamp,
      this.volume,
      this.turnoverRate,
      this.amplitude,
      this.open,
      this.lastClose,
      this.high,
      this.low});

  XQStockData.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    current = json['current'];
    percent = json['percent'];
    chg = json['chg'];
    timestamp = json['timestamp'];
    volume = json['volume'];
    turnoverRate = json['turnover_rate'];
    amplitude = json['amplitude'];
    open = json['open'];
    lastClose = json['last_close'];
    high = json['high'];
    low = json['low'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['current'] = current;
    data['percent'] = percent;
    data['chg'] = chg;
    data['timestamp'] = timestamp;
    data['volume'] = volume;
    data['turnover_rate'] = turnoverRate;
    data['amplitude'] = amplitude;
    data['open'] = open;
    data['last_close'] = lastClose;
    data['high'] = high;
    data['low'] = low;
    return data;
  }
}
