import 'package:changweiba/api/graphql.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

import '../model/base.dart';
import '../model/post.dart';

Future<BaseResponse<AllPosts>> getMyPosts(
    int page, int pageSize, bool pin) async {
  const getPostsStr = r'''
    query GetPosts($page:Int!,$pageSize:Int!,$isPin:Boolean!){
      action: posts(page:$page,pageSize:$pageSize,isPin:$isPin){
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
          pinStatus
        }
        totalCount
      }
    }
    ''';
  final QueryOptions options = QueryOptions(
      document: gql(getPostsStr),
      variables: <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
        'isPin': pin,
      },
      fetchPolicy: FetchPolicy.networkOnly);
  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.query(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", AllPosts());
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
    resp.data = AllPosts.fromJson(result.data!["action"]);
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

Future<BaseResponse<int>> newPost(String title, String content) async {
  const newPostStr = r'''
    mutation NewPost($title:String!,$content:String!){
      action: newPost(input:{title:$title,content:$content})
    }
    ''';
  final MutationOptions options =
      MutationOptions(document: gql(newPostStr), variables: <String, String>{
    'title': title,
    'content': content,
  });

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.mutate(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", 0);
  if (result.hasException) {
    debugPrint("new post exception: $result");
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

Future<BaseResponse<bool>> pinPost(int id, bool isPin) async {
  const newPostStr = r'''
    mutation PinPost($id:Int!,$pinStatus:Int!){
      action: pinPost(input:{id:$id,pinStatus:$pinStatus})
    }
    ''';
  final MutationOptions options =
      MutationOptions(document: gql(newPostStr), variables: <String, int>{
    'id': id,
    'pinStatus': isPin ? 1 : 0,
  });

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.mutate(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", false);
  if (result.hasException) {
    debugPrint("new post exception: $result");
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

Future<BaseResponse<int>> newComment(int postId, String content) async {
  const newCommentStr = r'''
    mutation NewComment($postId:Int!,$content:String!){
      action: newComment(input:{postId:$postId,content:$content})
    }
    ''';
  final MutationOptions options = MutationOptions(
      document: gql(newCommentStr),
      variables: <String, dynamic>{
        'postId': postId,
        'content': content,
      });

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.mutate(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", 0);
  if (result.hasException) {
    debugPrint("new comment exception: $result");
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

Future<BaseResponse<Post>> getPostDetail(
    int postId, int page, int pageSize) async {
  const getPostDetailStr = r'''
    query GetPostDetail($postId:Int!,$page:Int!,$pageSize:Int!){
      action: post(postId:$postId){
        id
        title
        content
        updatedAt
        createdAt
        comments(page:$page,pageSize:$pageSize){
          nodes{
            postId
            id
            content
            postId
            floor
            createdAt
            user{
      		    id
      		    name
      		    avatar
      		  }
            replies(page: 1, pageSize: 100) {
              nodes {
                id
                content
                createdAt
                user {
                  id
                  name
                  avatar
                }
              }
            }
          }
          totalCount
        }
        user{
          id
          name
          avatar
        }
      }
    }
    ''';
  final QueryOptions options = QueryOptions(
      document: gql(getPostDetailStr),
      variables: <String, int>{
        'postId': postId,
        'page': page,
        'pageSize': pageSize,
      },
      fetchPolicy: FetchPolicy.networkOnly);
  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.query(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", Post());
  if (result.hasException) {
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
    resp.data = Post.fromJson(result.data!["action"]);
  }
  return resp;
}

Future<BaseResponse<AllPosts>> getAllPosts(int page, int pageSize) async {
  const getPostsStr = r'''
    query GetAllPosts($page:Int!,$pageSize:Int!){
      action: allPosts(page:$page,pageSize:$pageSize){
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
          pinStatus
        }
        totalCount
      }
    }
    ''';
  final QueryOptions options = QueryOptions(
      document: gql(getPostsStr),
      variables: <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      },
      fetchPolicy: FetchPolicy.networkOnly);
  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.query(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(200, "", AllPosts());
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
    resp.data = AllPosts.fromJson(result.data!["action"]);
  }
  return resp;
}

Future<BaseResponse<int>> newReply(
    int postId, int commentId, String content, int parentId) async {
  const newReplyStr = r'''
    mutation NewReply($postId:Int!,$commentId:Int!,$content:String!,$parentId:Int){
      action: newReply(input:{postId:$postId,commentId:$commentId,content:$content,parentId:$parentId})
    }
    ''';
  final MutationOptions options =
      MutationOptions(document: gql(newReplyStr), variables: <String, dynamic>{
    'postId': postId,
    'content': content,
    'commentId': commentId,
    'parentId': parentId,
  });

  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.mutate(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(0, "", 0);
  if (result.hasException) {
    debugPrint("new comment exception: $result");
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
    resp.code = 200;
    resp.data = result.data!["action"];
  }
  return resp;
}

Future<BaseResponse<Replies>> getReplies(int commentId) async {
  const getPostsStr = r'''
    query GetReplies($commentId:Int!){
      action: replies(commentId: $commentId,page:1,pageSize:100) {
        nodes {
          id
          content
          createdAt
          user{
            id
            name
            avatar
          }
        }
        totalCount
      }
    }
    ''';
  final QueryOptions options = QueryOptions(
      document: gql(getPostsStr),
      variables: <String, dynamic>{
        'commentId': commentId,
      },
      fetchPolicy: FetchPolicy.networkOnly);
  var gqlClient = GetIt.I.get<GQLClient>();
  final QueryResult result = await gqlClient.query(
    options,
    onTimeout: () => throw Exception("request timeout"),
  );

  var resp = BaseResponse(0, "", Replies());
  if (result.hasException) {
    debugPrint("getReplies exception: $result");
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
    resp.code = 200;
    resp.data = Replies.fromJson(result.data!["action"]);
  }
  return resp;
}
