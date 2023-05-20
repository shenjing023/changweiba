import 'package:get_it/get_it.dart';
import 'graphql.dart';

const String domain = "http://localhost:8020/graphql";

void initNetwork() {
  const String uri = "http://172.20.211.254:8020/graphql";

  GetIt.I.registerLazySingleton<GQLClient>(() => GQLClient(uri: uri));
}
