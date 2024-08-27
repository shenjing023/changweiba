import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

class GQLClient {
  // final String source;
  final String uri;
  // final String token;
  late final Map<String, String>? header;

  late HttpLink httpLink;
  late AuthLink authLink;
  late ErrorLink errorLink;

  late GraphQLClient client;

  String authHeaderKey = 'token';
  String sourceKey = 'source';

  GQLClient({
    // required this.source,
    required this.uri,
    //this.token,
    // this.header,
  }) {
    // 设置url，复写传入header
    // httpLink = HttpLink(uri, defaultHeaders: {
    //   sourceKey: source,
    //   ...header,
    // });
    header = {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*",
    };
    if (header != null) {
      httpLink = HttpLink(uri, defaultHeaders: header!);
    } else {
      httpLink = HttpLink(uri);
    }

    // 通过复写getToken动态设置auth
    //authLink = AuthLink(getToken: getToken, headerKey: authHeaderKey);
    // 错误拦截
    errorLink = ErrorLink(
      onGraphQLError: onGraphQLError,
      onException: onException,
    );

    client = GraphQLClient(
      link: Link.from([
        DedupeLink(), // 请求去重
        errorLink,
        // authLink,
        httpLink,
      ]),
      cache: GraphQLCache(),
    );
  }

  // LinkError处理函数
  Stream<Response> onException(
    Request req,
    Stream<Response> Function(Request) _,
    LinkException exception,
  ) {
    if (exception is ServerException) {
      // 服务端错误
      debugPrint("server exception: $exception");
      // _errorsLoger(exception.parsedResponse?.errors);
    }

    if (exception is NetworkException) {
      // 网络错误
      debugPrint("network exception: $exception");
    }

    if (exception is HttpLinkParserException) {
      // http解析错误
      debugPrint("http exception: $exception");
    }

    return _(req);
  }

  // GraphqlError
  Stream<Response> onGraphQLError(
    Request req,
    Stream<Response> Function(Request) _,
    Response res,
  ) {
    // 处理返回错误
    for (var error in res.errors!) {
      debugPrint("gqlerror $error.message");
    }
    return _(req);
  }

  Future<QueryResult> mutate(MutationOptions options,
      {int timeout = 10,
      FutureOr<QueryResult<Object?>> Function()? onTimeout}) async {
    if (timeout > 0) {
      return await client
          .mutate(options)
          .timeout(Duration(seconds: timeout), onTimeout: onTimeout);
    }
    return await client.mutate(options);
  }

  Future<QueryResult> query(QueryOptions options,
      {int timeout = 10,
      FutureOr<QueryResult<Object?>> Function()? onTimeout}) async {
    if (timeout > 0) {
      return await client
          .query(options)
          .timeout(Duration(seconds: timeout), onTimeout: onTimeout);
    }
    return await client.query(options);
  }

  void setHeader(String key, String value) {
    httpLink = HttpLink(uri, defaultHeaders: {key: value});
    client = GraphQLClient(
      link: Link.from([
        DedupeLink(),
        errorLink,
        httpLink,
      ]),
      cache: GraphQLCache(),
    );
  }
}
