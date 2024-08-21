import 'package:changweiba/model/auth.dart';
import 'package:flutter/material.dart';

import 'graphql.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

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

  final QueryResult result = await gqlClient.mutate(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  if (result.hasException) {
    debugPrint("exception: $result");
    if (result.exception!.graphqlErrors.isEmpty) {
      authResponse.code = 500;
      authResponse.message = "server internal error";
    } else {
      for (var e in result.exception!.graphqlErrors) {
        authResponse.code = e.extensions!["code"];
        authResponse.message = e.message;
      }
    }
  } else {
    authResponse.data = {
      "accessToken": result.data!["action"]["accessToken"],
      "refreshToken": result.data!["action"]["refreshToken"],
    };
    gqlClient.setHeader("auth", result.data!["action"]["accessToken"]);
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
  final QueryResult result = await gqlClient.mutate(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  if (result.hasException) {
    debugPrint("exception: $result");
    if (result.exception!.graphqlErrors.isEmpty) {
      authResponse.code = 500;
      authResponse.message = "server internal error";
    } else {
      for (var e in result.exception!.graphqlErrors) {
        authResponse.code = e.extensions!["code"];
        authResponse.message = e.message;
      }
    }
  } else {
    authResponse.data = {
      "accessToken": result.data!["action"]["accessToken"],
      "refreshToken": result.data!["action"]["refreshToken"],
    };
    gqlClient.setHeader("auth", result.data!["action"]["accessToken"]);
  }
  return authResponse;
}

Future<AuthResponse?> refreshAuthToken(String refreshToken) async {
  const refreshAuthTokenStr = r'''
    mutation RefreshAuthToken($refreshToken:String!){
      action: refreshAuthToken(input:$refreshToken){
        accessToken,
        refreshToken
      }
    }
  ''';
  AuthResponse authResponse = AuthResponse(200, "", null);
  final MutationOptions options = MutationOptions(
    document: gql(refreshAuthTokenStr),
    variables: <String, String>{
      'refreshToken': refreshToken,
    },
  );

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.client.mutate(options);

  if (result.hasException) {
    debugPrint("exception: $result");
    if (result.exception!.graphqlErrors.isEmpty) {
      authResponse.code = 500;
      authResponse.message = "server internal error";
    } else {
      for (var e in result.exception!.graphqlErrors) {
        authResponse.code = e.extensions!["code"];
        authResponse.message = e.message;
      }
    }
  } else {
    authResponse.data = {
      "accessToken": result.data!["action"]["accessToken"],
      "refreshToken": result.data!["action"]["refreshToken"],
    };
    gqlClient.setHeader("auth", result.data!["action"]["accessToken"]);
  }
  return authResponse;
}
