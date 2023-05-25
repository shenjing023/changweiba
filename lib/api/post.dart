import 'package:changweiba/api/graphql.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

import '../models/base.dart';
import '../models/post.dart';

Future<BaseResponse<Posts>> getPosts(int page, int pageSize) async {
  const getPostsStr = r'''
    query GetPosts($page:Int!,$pageSize:Int!){
      action: posts(page:$page,pageSize:$pageSize){
        nodes{
          id
          user{
            id
            name
            avatar
          }
          title
          content
          replyNum
          updatedAt
          createdAt
        }
        totalCount
      }
    }
    ''';
  final QueryOptions options = QueryOptions(
      document: gql(getPostsStr),
      variables: <String, int>{
        'page': page,
        'pageSize': pageSize,
      },
      fetchPolicy: FetchPolicy.networkOnly);
  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.query(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", Posts());
  if (result.hasException) {
    debugPrint("getPosts exception: $result");
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
    resp.data = Posts.fromJson(result.data!["action"]);
  }
  return resp;
}

Future<BaseResponse<bool>> deletePost(int id) async {
  const deletePostStr = r'''
    mutation DeletePost($id:Int!){
      action: deletePost(input:$id)
    }
    ''';
  final MutationOptions options =
      MutationOptions(document: gql(deletePostStr), variables: <String, int>{
    'id': id,
  });

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.mutate(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", false);
  if (result.hasException) {
    debugPrint("delete post exception: $result");
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
