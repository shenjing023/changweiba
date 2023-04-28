import 'package:get_it/get_it.dart';
import 'graphql.dart';

void initNetwork() {
  final String uri = "http://localhost:8020/graphql";

  GetIt.I.registerLazySingleton<GQLClient>(() => GQLClient(uri: uri));
}
