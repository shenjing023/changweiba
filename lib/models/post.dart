import 'package:changweiba/models/auth.dart';

class AllPosts {
  List<Post>? nodes;
  int? totalCount;

  AllPosts({this.nodes, this.totalCount});

  AllPosts.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = <Post>[];
      json['nodes'].forEach((v) {
        nodes!.add(Post.fromJson(v));
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

class Post {
  int? id;
  String? title;
  String? content;
  int? updatedAt;
  int? createdAt;
  int? pin;
  String? tag;
  Comments? comments;
  User? user;
  int? replyCount;

  Post(
      {this.id,
      this.title,
      this.content,
      this.updatedAt,
      this.createdAt,
      this.pin,
      this.tag,
      this.comments,
      this.user,
      this.replyCount});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    pin = json['pinStatus'];
    tag = json['tag'];
    comments =
        json['comments'] != null ? Comments.fromJson(json['comments']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    replyCount = json['replyNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['pinStatus'] = pin;
    data['tag'] = tag;
    if (comments != null) {
      data['comments'] = comments!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['replyNum'] = replyCount;
    return data;
  }

  @override
  String toString() {
    return """Post{id: $id, title: $title, content: $content, 
      updatedAt: $updatedAt, createdAt: $createdAt, pin: $pin, tag: $tag, 
      comments: $comments, user: $user, replyCount: $replyCount}""";
  }
}

class Comments {
  List<Comment>? nodes;
  int? totalCount;

  Comments({this.nodes, this.totalCount});

  Comments.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = <Comment>[];
      json['nodes'].forEach((v) {
        nodes!.add(Comment.fromJson(v));
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
    return 'Comments{nodes: $nodes, totalCount: $totalCount}';
  }
}

class Comment {
  int? id;
  String? content;
  int? createdAt;
  User? user;
  int? floor;
  Replies? replies;
  int? postId;

  Comment(
      {this.id,
      this.content,
      this.createdAt,
      this.user,
      this.floor,
      this.replies,
      this.postId});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['createdAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    floor = json['floor'];
    replies =
        json['replies'] != null ? Replies.fromJson(json['replies']) : null;
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['createdAt'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['floor'] = floor;
    if (replies != null) {
      data['replies'] = replies!.toJson();
    }
    data['post_id'] = postId;
    return data;
  }

  @override
  String toString() {
    return """Comment{id: $id, content: $content, createdAt: $createdAt,
      user: $user, floor: $floor, replies: $replies, postId: $postId}""";
  }
}

class Reply {
  int? id;
  String? content;
  int? createdAt;
  User? user;
  Reply? parent;
  int? floor;
  int? commentId;

  Reply(
      {this.id,
      this.content,
      this.createdAt,
      this.user,
      this.parent,
      this.floor,
      this.commentId});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['createdAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    parent = json['parent'] != null ? Reply.fromJson(json['parent']) : null;
    floor = json['floor'];
    commentId = json['comment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['createdAt'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    data['floor'] = floor;
    data['comment_id'] = commentId;
    return data;
  }

  @override
  String toString() {
    return """Reply{id: $id, content: $content, createdAt: $createdAt, 
      user: $user, parent: $parent, floor: $floor, commentId: $commentId}""";
  }
}

class Replies {
  List<Reply>? nodes;
  int? totalCount;

  Replies({this.nodes, this.totalCount});

  Replies.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = <Reply>[];
      json['nodes'].forEach((v) {
        nodes!.add(Reply.fromJson(v));
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
    return 'Replies{nodes: $nodes, totalCount: $totalCount}';
  }
}
