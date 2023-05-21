import 'package:changweiba/api/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

import '../models/base.dart';
import '../models/stock.dart';
import 'graphql.dart';

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

Future<BaseResponse<bool>> subscribeStock(String symbol, String name) async {
  const subscribeStr = r'''
    mutation SubscribeStock($symbol:String!,$name:String!){
      action: subscribeStock(input:{symbol:$symbol,name:$name})
    }
    ''';
  final MutationOptions options =
      MutationOptions(document: gql(subscribeStr), variables: <String, String>{
    'symbol': symbol,
    'name': name,
  });

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.mutate(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", false);
  if (result.hasException) {
    debugPrint("subscribeStock exception: $result");
    if (result.exception!.graphqlErrors.isEmpty) {
      resp.code = 500;
      resp.message = "server internal error";
    } else {
      for (var e in result.exception!.graphqlErrors) {
        resp.code = e.extensions!["code"];
        resp.message = e.message;
      }
    }
  } else {
    resp.data = result.data!["action"];
  }
  return resp;
}

Future<BaseResponse<SubscribedStocks>> subscribedStocks() async {
  const subscribedStockStr = r'''
    query SubscribedStocks(){
      action: subscribedStocks(){
        nodes{
          id
          symbol
          name
          bull
        }
        totalCount
      }
    }
    ''';
  final QueryOptions options = QueryOptions(
      document: gql(subscribedStockStr), fetchPolicy: FetchPolicy.networkOnly);

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.query(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", SubscribedStocks());
  if (result.hasException) {
    debugPrint("subscribeStock exception: $result");
    if (result.exception!.graphqlErrors.isEmpty) {
      resp.code = 500;
      resp.message = "server internal error";
    } else {
      for (var e in result.exception!.graphqlErrors) {
        resp.code = e.extensions!["code"];
        resp.message = e.message;
      }
    }
  } else {
    resp.data = SubscribedStocks.fromJson(result.data!["action"]);
  }
  return resp;
}
