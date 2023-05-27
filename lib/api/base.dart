import 'package:get_it/get_it.dart';
import 'graphql.dart';

const String domain = "http://localhost:8020/graphql";

void initNetwork(Map<String, String> headers) {
  const String uri = "http://172.20.211.254:8020/graphql";
  // const String uri = "http://192.168.137.1:8020/graphql";
  // const String uri = "http://localhost:8020/graphql";

  GetIt.I.registerLazySingleton<GQLClient>(
      () => GQLClient(uri: uri, header: headers));
}
