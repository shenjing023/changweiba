import 'package:changweiba/models/auth.dart';

class PostData {
  late int id;
  late String title;
  late String content;
  late int replyCount;
  late int createdAt;
  late int updatedAt;
  String? tag;
  User? user;
  CommentData? comment;
  ReplyData? reply;

  PostData(this.id, this.title, this.content, this.replyCount, this.createdAt,
      this.updatedAt,
      {this.tag, this.user, this.comment, this.reply});

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    replyCount = json['replyNum'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tag = json['tag'] ?? "";
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    comment =
        json['comment'] != null ? CommentData.fromJson(json['comment']) : null;
    reply = json['reply'] != null ? ReplyData.fromJson(json['reply']) : null;
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
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (comment != null) {
      data['comment'] = comment!.toJson();
    }
    if (reply != null) {
      data['reply'] = reply!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return """PostData: {id: $id, title: $title, content: $content, 
      replyCount: $replyCount, createdAt: $createdAt, updatedAt: $updatedAt, 
      tag: $tag, user: $user, comment: $comment, reply: $reply}""";
  }
}

class CommentData {
  late int id;
  late int postId;
  late int floor;
  late String content;
  late int createdAt;
  User? user;
  ReplyData? reply;

  CommentData(this.id, this.postId, this.floor, this.content, this.createdAt,
      {this.user, this.reply});

  CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    floor = json['floor'];
    content = json['content'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    reply = json['reply'] != null ? ReplyData.fromJson(json['reply']) : null;
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
    if (reply != null) {
      data['reply'] = reply!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return """CommentData{id: $id, postId: $postId, floor: $floor, 
      content: $content, createdAt: $createdAt, user: $user, reply: $reply}""";
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
