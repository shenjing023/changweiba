import 'graphql.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

Future<void> signUp(String username, String password) async {
  const signUpStr = r'''
    mutation SignUp($username:String!,$password:String!){
      action: signUp(input:{name:$username,password:$password}){
        accessToken,
        refreshToken
      }
    }
  ''';
  final MutationOptions options =
      MutationOptions(document: gql(signUpStr), variables: <String, String>{
    'username': username,
    'password': password,
  });

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.client.mutate(options);

  if (result.hasException) {
    print(result.exception.toString());
    return;
  }

  print(result);
}

Future<void> httpTest() async {
  final dio = Dio();
  final response = await dio.post("http://localhost:8020/graphql", data: {
    "query":
        "mutation{\n  signIn(input:{name:\"admin\",password:\"admin\"}){\n    accessToken,\n    refreshToken\n  }\n}"
  });
  print(response.toString());
}

Future<void> httpTest2() async {
  final dio = Dio();
  final response = await dio.get("http://localhost:8020/ping");
  print(response);
}
