import 'package:changweiba/models/auth.dart';
import 'package:flutter/foundation.dart';

import 'graphql.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

// class AuthGQLClient {
//   late GraphQLClient client;
//   late HttpLink http
//   late AuthLink authLink;
//   late ErrorLink errorLink;

//   AuthGQLClient._internal() {
//     httpLink = HttpLink(domain);
//     errorLink = ErrorLink(
//       onGraphQLError: onGraphQLError,
//       onException: onException,
//     );
//     client = GraphQLClient(
//       link: Link.from([
//         DedupeLink(), // 请求去重
//         errorLink,
//         // authLink,
//         httpLink,
//       ]),
//       cache: GraphQLCache(),
//     );
//   }

//   factory AuthGQLClient() => _instance;

//   static final AuthGQLClient _instance = AuthGQLClient._internal();

//   // GraphqlError
//   Stream<Response> onGraphQLError(
//     Request req,
//     Stream<Response> Function(Request) _,
//     Response res,
//   ) {
//     // 处理返回错误
//     for (var error in res.errors!) {
//       print("gqlerror $error.message");
//     }
//     return _(req);
//   }

//   Future<AuthResponse> signUp(String username, String password) async {
//     const signUpStr = r'''
//     mutation SignUp($username:String!,$password:String!){
//       action: signUp(input:{name:$username,password:$password}){
//         accessToken,
//         refreshToken
//       }
//     }
//   ''';
//   final MutationOptions options =
//       MutationOptions(
//         document: gql(signUpStr),
//         variables: <String, String>{
//           'username': username,
//           'password': password,
//         },
//         onError: (error) => print(error),
//   );

//   final QueryResult result = await client.mutate(options);

//   if (result.hasException) {
//     SmartDialog.showToast('test toast');
//     print("exception1 $result.exception.toString()");
//     return;
//   }

//   return result;
//   }
// }

Future<AuthResponse?> signUp(String username, String password) async {
  const signUpStr = r'''
    mutation SignUp($username:String!,$password:String!){
      action: signUp(input:{name:$username,password:$password}){
        accessToken,
        refreshToken
      }
    }
  ''';
  AuthResponse authResponse = AuthResponse(200, "", null);
  final MutationOptions options = MutationOptions(
    document: gql(signUpStr),
    variables: <String, String>{
      'username': username,
      'password': password,
    },
    // onError: (error) => {
    //   for (var e in error!.graphqlErrors)
    //     {
    //       authResponse!.code = e.extensions!["code"],
    //       authResponse.message = e.message
    //     }
    // },
  );

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.client.mutate(options);

  if (result.hasException) {
    for (var e in result.exception!.graphqlErrors) {
      authResponse.code = e.extensions!["code"];
      authResponse.message = e.message;
    }
  } else {
    authResponse.data = {
      "accessToken": result.data!["action"]["accessToken"],
      "refreshToken": result.data!["action"]["refreshToken"],
    };
  }
  return authResponse;
}

Future<AuthResponse?> signIn(String username, String password) async {
  const signInStr = r'''
    mutation SignIn($username:String!,$password:String!){
      action: signIn(input:{name:$username,password:$password}){
        accessToken,
        refreshToken
      }
    }
  ''';
  AuthResponse authResponse = AuthResponse(200, "", null);
  final MutationOptions options = MutationOptions(
    document: gql(signInStr),
    variables: <String, String>{
      'username': username,
      'password': password,
    },
  );

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.client.mutate(options);

  if (result.hasException) {
    for (var e in result.exception!.graphqlErrors) {
      authResponse.code = e.extensions!["code"];
      authResponse.message = e.message;
    }
  } else {
    authResponse.data = {
      "accessToken": result.data!["action"]["accessToken"],
      "refreshToken": result.data!["action"]["refreshToken"],
    };
  }
  return authResponse;
}

Future<AuthResponse?> getAccessToken(String refreshToken) async {
  const getAccessTokenStr = r'''
    mutation GetAccessToken($refreshToken:String!){
      action: getAccessToken(input:{name:$refreshToken})
    }
  ''';
  AuthResponse authResponse = AuthResponse(200, "", null);
  final MutationOptions options = MutationOptions(
    document: gql(getAccessTokenStr),
    variables: <String, String>{
      'refreshToken': refreshToken,
    },
  );

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.client.mutate(options);

  if (result.hasException) {
    for (var e in result.exception!.graphqlErrors) {
      authResponse.code = e.extensions!["code"];
      authResponse.message = e.message;
    }
  } else {
    authResponse.data = {
      "accessToken": result.data!["action"]["accessToken"],
      "refreshToken": result.data!["action"]["refreshToken"],
    };
  }
  return authResponse;
}
