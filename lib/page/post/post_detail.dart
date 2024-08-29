import 'package:changweiba/model/auth.dart';
import 'package:changweiba/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../api/post.dart';
import '../../constant/style.dart';
import '../../util/shared_preferences.dart';
import '../../util/time.dart';
import '../../widget/text_editor.dart';
import '../login/login.dart';
import 'comment.dart';

class PostDetailScreen extends StatefulWidget {
  final int postID;
  PostDetailScreen({Key? key, required this.postID}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<Widget?> dataWidget = [];

  int currentPage = 1;
  int itemsPerPage = 100;
  int totalComments = 0; // 总评论数

  late Post data;

  List<CommentItem> commentItems = [];

  @override
  void initState() {
    super.initState();
    // initData();
    fetchData();
    // 模拟获取评论数据
    // fetchComments(currentPage);
    // dataWidget.add(PostTitle(title: data.title));
    // dataWidget.add(PostContent(
    //     content: data.content!, user: data.user!, createdAt: data.createdAt!));
    // dataWidget.addAll(commentItems);
  }

  Future<void> fetchData() async {
    data = await _fetchData();
    if (data.id == 0) {
      return;
    }
    commentItems.clear();
    if (data.comments != null) {
      totalComments = data.comments!.totalCount!;
      if (data.comments!.nodes != null) {
        for (var item in data.comments!.nodes!) {
          List<ReplyItem> replies = [];
          if (item.replies != null) {
            if (item.replies!.nodes != null) {
              for (var item2 in item.replies!.nodes!) {
                replies.add(ReplyItem(
                  username: item2.user!.nickname,
                  content: item2.content!,
                  time: item2.createdAt!,
                  avatar: item2.user!.avatar,
                ));
              }
            }
          }
          commentItems.add(CommentItem(
            floor: item.floor!,
            username: item.user!.nickname,
            content: item.content!,
            avatar: item.user!.avatar,
            time: item.createdAt!,
            replies: replies,
            postID: item.postId!,
            id: item.id!,
          ));
        }
      }
    }

    setState(() {
      dataWidget.clear();
      dataWidget.add(PostTitle(title: data.title));
      if (currentPage == 1) {
        dataWidget.add(PostContent(
            content: data.content!,
            user: data.user!,
            createdAt: data.createdAt!));
      }
      dataWidget.addAll(commentItems);
    });
  }

  Future<Post> _fetchData() async {
    SmartDialog.showLoading();
    Post result = Post();
    try {
      var resp = await getPostDetail(widget.postID, currentPage, itemsPerPage);
      if (resp.code == 200) {
        if (resp.data.id != 0) {
          result = resp.data;
        } else {
          SmartDialog.showToast("internal server or network error");
        }
      } else {
        SmartDialog.showToast("internal server or network error");
      }
    } catch (e) {
      debugPrint(e.toString());
      SmartDialog.showToast("internal server or network error");
    } finally {
      SmartDialog.dismiss();
    }

    return result;
  }

  // void initData() {
  //   data = Post(
  //       id: 111,
  //       title: "测试标题",
  //       content: Content,
  //       user: User("测试用户", 11,
  //           "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
  //       createdAt: DateTime.now().millisecondsSinceEpoch,
  //       updatedAt: DateTime.now().millisecondsSinceEpoch,
  //       comments: Comments(nodes: [
  //         Comment(
  //           id: 1,
  //           floor: 2,
  //           createdAt: DateTime.now().millisecondsSinceEpoch,
  //           content:
  //               "技部三六九等拉克丝建档立卡速度加啊送i \n  连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i  \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等",
  //           user: User("评论用户1", 11,
  //               "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
  //         ),
  //         Comment(
  //             id: 11,
  //             floor: 3,
  //             createdAt: DateTime.now().millisecondsSinceEpoch,
  //             content: "评论内容1",
  //             user: User("评论用户1", 11,
  //                 "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
  //             replies: Replies(nodes: [
  //               Reply(
  //                 id: 1111,
  //                 content: "回复内容1",
  //                 user: User("回复用户1", 11,
  //                     "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
  //                 createdAt: DateTime.now().millisecondsSinceEpoch,
  //               ),
  //             ])),
  //         Comment(
  //             id: 11,
  //             floor: 3,
  //             createdAt: DateTime.now().millisecondsSinceEpoch,
  //             content: "评论内容1",
  //             user: User("评论用户1", 11,
  //                 "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
  //             replies: Replies(nodes: [
  //               Reply(
  //                 id: 1111,
  //                 content: "去年赢过，单纯直接打穿，不知道为啥kin去了g赢过",
  //                 user: User("回复用户1", 11,
  //                     "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
  //                 createdAt: DateTime.now().millisecondsSinceEpoch,
  //               ),
  //               Reply(
  //                 id: 1111,
  //                 content:
  //                     "去年赢过，单纯直接打穿，不知道为啥kin去了g赢过，去年赢过，单纯直接打穿，不知道为啥kin去了g赢过，去年赢过，单纯直接打穿，不知道为啥kin去了g赢过",
  //                 user: User("回复用户1", 11,
  //                     "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
  //                 createdAt: DateTime.now().millisecondsSinceEpoch,
  //               ),
  //             ])),
  //         Comment(
  //           id: 1,
  //           floor: 2,
  //           createdAt: DateTime.now().millisecondsSinceEpoch,
  //           content:
  //               "技部三六九等拉克丝建档立卡速度加啊送i \n  连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i  \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等",
  //           user: User("评论用户1", 11,
  //               "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
  //         ),
  //       ]));

  //   if (data.comments != null) {
  //     for (var item in data.comments!.nodes!) {
  //       List<ReplyItem> replies = [];
  //       if (item.replies != null) {
  //         for (var item2 in item.replies!.nodes!) {
  //           replies.add(ReplyItem(
  //             username: item2.user!.nickname,
  //             content: item2.content!,
  //             time: item2.createdAt!,
  //             avatar: item2.user!.avatar,
  //           ));
  //         }
  //       }
  //       commentItems.add(CommentItem(
  //         floor: item.floor!,
  //         username: item.user!.nickname,
  //         content: item.content!,
  //         avatar: item.user!.avatar,
  //         time: item.createdAt!,
  //         replies: replies,
  //       ));
  //     }
  //   }
  // }

  Future<void> fetchComments(int page) async {
    // 模拟网络请求延迟
    await Future.delayed(Duration(seconds: 1));

    // 生成假数据
    // List<Map<String, dynamic>> fetchedComments =
    //     generateFakeComments(page, itemsPerPage, totalComments);

    // print(fetchedComments.length);

    // List<CommentItem> commentItems = fetchedComments
    //     .map((comment) => CommentItem(
    //           floor: comment['floor'],
    //           username: comment['username'],
    //           content: comment['content'],
    //           avatar: comment['avatar'],
    //           time: comment['time'],
    //           replies: comment['replies'],
    //         ))
    //     .toList();

    // if (data.comments != null) {
    //   for (var item in data.comments!.nodes!) {
    //     List<ReplyItem> replies = [];
    //     if (item.replies != null) {
    //       for (var item2 in item.replies!.nodes!) {
    //         replies.add(ReplyItem(
    //           username: item2.user!.nickname,
    //           content: item2.content!,
    //           time: item2.createdAt!,
    //           avatar: item2.user!.avatar,
    //         ));
    //       }
    //     }
    //     commentItems.add(CommentItem(
    //       floor: item.floor!,
    //       username: item.user!.nickname,
    //       content: item.content!,
    //       avatar: item.user!.avatar,
    //       time: item.createdAt!,
    //       replies: replies,
    //     ));
    //   }
    // }

    // setState(() {
    //   dataWidget.clear();
    //   dataWidget.add(PostTitle());
    //   dataWidget.add(PostContent(content: Content));
    //   // dataWidget.add(CommentsList(items: items));
    //   // dataWidget.addAll(fetchedComments
    //   //     .map((comment) => CommentItem(
    //   //           floor: comment['floor'],
    //   //           username: comment['username'],
    //   //           content: comment['content'],
    //   //           avatar: comment['avatar'],
    //   //           time: comment['time'],
    //   //           ipLocation: comment['ipLocation'],
    //   //           replies: comment['replies'],
    //   //         ))
    //   //     .toList());
    // });

    // data = Post(id: 111, title: "");
  }

  Future<void> addComment(String content) async {
    try {
      var resp = await newComment(widget.postID, content);
      if (resp.code == 200) {
        SmartDialog.showToast("评论成功");
        fetchData();
      } else {
        SmartDialog.showToast("评论失败");
      }
    } catch (e) {
      debugPrint(e.toString());
      SmartDialog.showToast("评论失败");
    }
  }

  void _nextPage() {
    if ((currentPage * itemsPerPage) < totalComments) {
      setState(() {
        currentPage++;
        fetchData();
      });
    }
  }

  void _previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        fetchData();
      });
    }
  }

  Future<void> _showCreateCommentDialog() async {
    await showLoginDialog();
    bool isAuthenticated = Storage().prefs.getBool("isAuthenticated") ?? false;
    if (!isAuthenticated) {
      return;
    }
    SmartDialog.show(builder: (_) {
      return LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1000,
              maxHeight: 500,
            ),
            child: TextEditor(
              onCreated: (result) {
                SmartDialog.dismiss();
                addComment(result['content']);
              },
              needTitleBar: false,
              title: "创建新评论",
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 800,
          minWidth: 600,
        ),
        child: Scaffold(
          body: Center(
            child: ListView.separated(
              itemCount: dataWidget.length,
              itemBuilder: (context, index) {
                return dataWidget[index];
              },
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                thickness: 1,
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentPage > 1 ? _previousPage : null,
                  child: const Text('上一页'),
                ),
                Text('第 $currentPage 页'),
                ElevatedButton(
                  onPressed: (currentPage * itemsPerPage) < totalComments
                      ? _nextPage
                      : null,
                  child: const Text('下一页'),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showCreateCommentDialog();
            },
            mini: true,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class PostTitle extends StatelessWidget {
  final String? title;
  const PostTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: Text(
        title ?? '',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class PostContent extends StatelessWidget {
  final String content;
  final User user;
  final int createdAt;

  const PostContent(
      {super.key,
      required this.content,
      required this.user,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFFFBFBFD),
              padding: const EdgeInsets.all(16),
              child: UserInfo(
                username: user.nickname,
                avatar: user.avatar!,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 200,
                      maxHeight: 800,
                    ),
                    child: ScrollConfiguration(
                      behavior: NoScrollbarBehavior(), // 自定义滚动行为
                      child: SelectionArea(
                        child: SingleChildScrollView(
                          // 添加 SingleChildScrollView
                          child: MarkdownBody(data: content),
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        RelativeDateFormat.timeStamp2Str(createdAt),
                        style: commentTimeStyle,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '1楼',
                        style: commentTimeStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child; // 返回子部件，不包含滚动条
  }
}

class UserInfo extends StatelessWidget {
  final String avatar;
  final String username;

  const UserInfo({
    super.key,
    required this.avatar,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(avatar),
          radius: 40,
        ),
        const SizedBox(height: 20),
        Flexible(
          child: Text(
            username,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
