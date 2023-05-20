import 'package:changweiba/api/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/stock.dart';

Future<SearchStockResponse?> searchStock(String keyword) async {
  var cookie = await getXqCookie();
  if (cookie == null) {
    return null;
  }
  debugPrint("cookie: $cookie");
  String url =
      "https://xueqiu.com/query/v1/suggest_stock.json?q=$keyword&count=5";
  SearchStockResponse? data;
  onSuccess(resp) {
    data = SearchStockResponse.fromJson(resp);
  }

  onError(code, msg) {
    data = SearchStockResponse(code: code, message: msg);
  }

  await HttpClient().requestNetwork(
    Method.get,
    url,
    onSuccess: onSuccess,
    onError: onError,
    options: Options(headers: {"cookie": cookie}),
  );
  debugPrint("search stock data: ${data?.toJson().toString()}");
  return data;

  // await getXqHeaders();
}

Future<String?> getXqCookie() async {
  String url = "https://xueqiu.com";
  var resp = await HttpClient().rawRequest(Method.get, url);
  try {
    var cookie = "";
    var headers = resp.headers;
    for (var item in headers["set-cookie"]) {
      item.split(";").forEach((element) {
        if (element.contains("xq_a_token")) {
          cookie = element;
          return;
        }
      });
    }
    return cookie;
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}
