import 'package:changweiba/models/auth.dart';

class PostData {
  late int id;
  late String title;
  late String content;
  late int replyCount;
  late int createdAt;
  late int updatedAt;
  late int pin;
  String? tag;
  User? user;
  List<CommentData>? comments;

  PostData(this.id, this.title, this.content, this.replyCount, this.createdAt,
      this.updatedAt, this.pin,
      {this.tag, this.user, this.comments});

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    replyCount = json['replyNum'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    pin = json['pinStatus'];
    tag = json['tag'] ?? "";
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['comments'] != null) {
      comments = <CommentData>[];
      json['replies'].forEach((v) {
        comments!.add(CommentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['reply_count'] = replyCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['tag'] = tag;
    data['pinStatus'] = pin;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  @override
  String toString() {
    return """PostData: {id: $id, title: $title, content: $content, 
      replyCount: $replyCount, createdAt: $createdAt, updatedAt: $updatedAt, 
      pin: $pin,tag: $tag, user: $user, comments: $comments}""";
  }
}

class CommentData {
  late int id;
  late int postId;
  late int floor;
  late String content;
  late int createdAt;
  User? user;
  List<ReplyData>? replies;

  CommentData(this.id, this.postId, this.floor, this.content, this.createdAt,
      {this.user, this.replies});

  CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    floor = json['floor'];
    content = json['content'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['replies'] != null) {
      replies = <ReplyData>[];
      json['replies'].forEach((v) {
        replies!.add(ReplyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post_id'] = postId;
    data['floor'] = floor;
    data['content'] = content;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return """CommentData{id: $id, postId: $postId, floor: $floor, 
      content: $content, createdAt: $createdAt, user: $user, replies: $replies}""";
  }
}

class ReplyData {
  late int id;
  late int postId;
  late int commentId;
  late int floor;
  late String content;
  late int createdAt;
  User? user;

  ReplyData(this.id, this.postId, this.commentId, this.floor, this.content,
      this.createdAt,
      {this.user});

  /// fromjson
  ReplyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    commentId = json['comment_id'];
    floor = json['floor'];
    content = json['content'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post_id'] = postId;
    data['comment_id'] = commentId;
    data['floor'] = floor;
    data['content'] = content;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return """ReplyData: {id: $id, postId: $postId, commentId: $commentId, 
      floor: $floor, content: $content, createdAt: $createdAt, user: $user}""";
  }
}

class Posts {
  List<PostData>? nodes;
  int? totalCount;

  Posts({this.nodes, this.totalCount});

  Posts.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = <PostData>[];
      json['nodes'].forEach((v) {
        nodes!.add(PostData.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nodes != null) {
      data['nodes'] = nodes!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }

  @override
  String toString() {
    return 'Posts{nodes: $nodes, totalCount: $totalCount}';
  }
}
