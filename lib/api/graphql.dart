import 'package:graphql/client.dart';

class GQLClient {
  // final String source;
  final String uri;
  // final String token;
  final Map<String, String> header;

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
    this.header = const {},
  }) {
    // 设置url，复写传入header
    // httpLink = HttpLink(uri, defaultHeaders: {
    //   sourceKey: source,
    //   ...header,
    // });
    httpLink = HttpLink(uri);
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

  void _errorsLoger(List<GraphQLError>? errors) {
    for (var error in errors!) {
      print(error.message);
    }
  }

  // LinkError处理函数
  Stream<Response> onException(
    Request req,
    Stream<Response> Function(Request) _,
    LinkException exception,
  ) {
    if (exception is ServerException) {
      // 服务端错误
      print(exception);
      _errorsLoger(exception.parsedResponse?.errors);
    }

    if (exception is NetworkException) {
      // 网络错误
      print(exception.toString());
    }

    if (exception is HttpLinkParserException) {
      // http解析错误
      print(exception.originalException);
      print(exception.response);
    }

    return _(req);
  }

  // GraphqlError
  Stream<Response> onGraphQLError(
    Request req,
    Stream<Response> Function(Request) _,
    Response res,
  ) {
    // print(res.errors);
    _errorsLoger(res.errors); // 处理返回错误
    return _(req);
  }
}
