import 'dart:math';

import 'package:changweiba/model/auth.dart';
import 'package:changweiba/model/post.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';

import '../../constant/style.dart';
import '../../util/time.dart';

String Content =
    "连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i \n  连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i  \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送isadasdasdasd \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i \n  连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i  \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送isadasdasdasd \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i \n  连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i  \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送isadasdasdasd";

final ShotContent = "asdsad手打收到u发客户就卡死风格和";

class PostDetailScreen extends StatefulWidget {
  int? postID;
  PostDetailScreen({Key? key}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<Widget?> dataWidget = [];

  int currentPage = 1;
  int itemsPerPage = 10;
  int totalComments = 55; // 总评论数

  late Post data;

  List<CommentItem> commentItems = [];

  @override
  void initState() {
    super.initState();
    initData();
    // 模拟获取评论数据
    // fetchComments(currentPage);
    dataWidget.add(PostTitle(title: data.title));
    dataWidget.add(PostContent(
        content: data.content!, user: data.user!, createdAt: data.createdAt!));
    dataWidget.addAll(commentItems);
  }

  void initData() {
    data = Post(
        id: 111,
        title: "测试标题",
        content: Content,
        user: User("测试用户", 11,
            "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        comments: Comments(nodes: [
          Comment(
            id: 1,
            floor: 2,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            content:
                "技部三六九等拉克丝建档立卡速度加啊送i \n  连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i  \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等",
            user: User("评论用户1", 11,
                "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
          ),
          Comment(
              id: 11,
              floor: 3,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              content: "评论内容1",
              user: User("评论用户1", 11,
                  "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
              replies: Replies(nodes: [
                Reply(
                  id: 1111,
                  content: "回复内容1",
                  user: User("回复用户1", 11,
                      "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                ),
              ])),
          Comment(
              id: 11,
              floor: 3,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              content: "评论内容1",
              user: User("评论用户1", 11,
                  "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
              replies: Replies(nodes: [
                Reply(
                  id: 1111,
                  content: "去年赢过，单纯直接打穿，不知道为啥kin去了g赢过",
                  user: User("回复用户1", 11,
                      "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                ),
                Reply(
                  id: 1111,
                  content:
                      "去年赢过，单纯直接打穿，不知道为啥kin去了g赢过，去年赢过，单纯直接打穿，不知道为啥kin去了g赢过，去年赢过，单纯直接打穿，不知道为啥kin去了g赢过",
                  user: User("回复用户1", 11,
                      "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                ),
              ])),
          Comment(
            id: 1,
            floor: 2,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            content:
                "技部三六九等拉克丝建档立卡速度加啊送i \n  连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等拉克丝建档立卡速度加啊送i  \n 连多兰都打不过，但是打lpl那几个就是手到擒来暗杀是客户的电脑卡上的卡号打开睡了多久啊是快乐到家啊是假的啦设计大赛就离开洒家离开东京按理说发生发撒科技部三六九等",
            user: User("评论用户1", 11,
                "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586"),
          ),
        ]));

    if (data.comments != null) {
      for (var item in data.comments!.nodes!) {
        List<ReplyItem> replies = [];
        if (item.replies != null) {
          for (var item2 in item.replies!.nodes!) {
            replies.add(ReplyItem(
              username: item2.user!.nickname,
              content: item2.content!,
              time: item2.createdAt!,
              avatar: item2.user!.avatar,
            ));
          }
        }
        commentItems.add(CommentItem(
          floor: item.floor!,
          username: item.user!.nickname,
          content: item.content!,
          avatar: item.user!.avatar,
          time: item.createdAt!,
          replies: replies,
        ));
      }
    }
  }

  Future<void> fetchComments(int page) async {
    // 模拟网络请求延迟
    await Future.delayed(Duration(seconds: 1));

    // 生成假数据
    List<Map<String, dynamic>> fetchedComments =
        generateFakeComments(page, itemsPerPage, totalComments);

    print(fetchedComments.length);

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

  void _nextPage() {
    if ((currentPage * itemsPerPage) < totalComments) {
      setState(() {
        currentPage++;
        fetchComments(currentPage);
      });
    }
  }

  void _previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        fetchComments(currentPage);
      });
    }
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
              itemCount: dataWidget.length, // 添加分页控件
              itemBuilder: (context, index) {
                return dataWidget[index];
                // if (index == 0) {
                //   return PostTitle(title: data.title);
                // } else if (index == 1) {
                //   // return PostContent(
                //   //     content: data.content!,
                //   //     user: data.user!,
                //   //     createdAt: data.createdAt!);
                //   return dataWidget[index - 1];
                // } else {
                //   // return Padding(
                //   //   padding: const EdgeInsets.all(16.0),
                //   //   child: Row(
                //   //     mainAxisAlignment: MainAxisAlignment.center,
                //   //     children: [
                //   //       IconButton(
                //   //         icon: Icon(Icons.arrow_back),
                //   //         onPressed: _previousPage,
                //   //       ),
                //   //       Text('第 $currentPage 页'),
                //   //       IconButton(
                //   //         icon: Icon(Icons.arrow_forward),
                //   //         onPressed: _nextPage,
                //   //       ),
                //   //     ],
                //   //   ),
                //   // );
                // }
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
        ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: ConstrainedBox(
    //       constraints: const BoxConstraints(maxWidth: 800),
    //       child: ListView.separated(
    //         itemCount: dataWidget.length, // 添加分页控件
    //         itemBuilder: (context, index) {
    //           return dataWidget[index];
    //           // if (index == 0) {
    //           //   return PostTitle(title: data.title);
    //           // } else if (index == 1) {
    //           //   // return PostContent(
    //           //   //     content: data.content!,
    //           //   //     user: data.user!,
    //           //   //     createdAt: data.createdAt!);
    //           //   return dataWidget[index - 1];
    //           // } else {
    //           //   // return Padding(
    //           //   //   padding: const EdgeInsets.all(16.0),
    //           //   //   child: Row(
    //           //   //     mainAxisAlignment: MainAxisAlignment.center,
    //           //   //     children: [
    //           //   //       IconButton(
    //           //   //         icon: Icon(Icons.arrow_back),
    //           //   //         onPressed: _previousPage,
    //           //   //       ),
    //           //   //       Text('第 $currentPage 页'),
    //           //   //       IconButton(
    //           //   //         icon: Icon(Icons.arrow_forward),
    //           //   //         onPressed: _nextPage,
    //           //   //       ),
    //           //   //     ],
    //           //   //   ),
    //           //   // );
    //           // }
    //         },
    //         separatorBuilder: (context, index) => const Divider(
    //           height: 0,
    //           thickness: 1,
    //         ),
    //       ),
    //     ),
    //   ),
    //   bottomNavigationBar: Container(
    //     padding: const EdgeInsets.all(16),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         ElevatedButton(
    //           onPressed: currentPage > 1 ? _previousPage : null,
    //           child: const Text('上一页'),
    //         ),
    //         Text('第 $currentPage 页'),
    //         ElevatedButton(
    //           onPressed: (currentPage * itemsPerPage) < totalComments
    //               ? _nextPage
    //               : null,
    //           child: const Text('下一页'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
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
                // avatar:
                //     'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586',
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
                      constraints: const BoxConstraints(minHeight: 200),
                      child: ExtendedText(
                        content,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        RelativeDateFormat.timeStamp2Str(createdAt),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '1楼',
                        style: TextStyle(color: Colors.grey),
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

// class CommentsList extends StatefulWidget {
//   List<CommentItem> items;

//   CommentsList({
//     super.key,
//     required this.items,
//   });
//   @override
//   _CommentsListState createState() => _CommentsListState();
// }

// class _CommentsListState extends State<CommentsList>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Expanded(
//         child: Column(children: widget.items

//             // CommentItem(
//             //   floor: '2楼',
//             //   username: 'kiyomiycc',
//             //   content: '打多兰有赢有输，打kin目前有赢过吗',
//             //   avatar:
//             //       'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.c7f86e2f.mkzYJ2PFCZDlnds15AqQMQ?t=1556797369',
//             //   time: '2024-08-05 10:34',
//             //   ipLocation: '浙江',
//             //   replies: [
//             //     ReplyItem(
//             //       username: '奇骨大魔王乔恩琼斯',
//             //       content: '去年赢过，单纯直接打穿，不知道为啥kin去了g赢过，',
//             //       time: '2024-8-5 10:36',
//             //     ),
//             //   ],
//             // ),
//             // ],
//             ));
//     // return Column(
//     //   children: [
//     //     CommentItem(
//     //       floor: '2楼',
//     //       username: 'kiyomiycc',
//     //       content: '打多兰有赢有输，打kin目前有赢过吗',
//     //       avatar:
//     //           'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.c7f86e2f.mkzYJ2PFCZDlnds15AqQMQ?t=1556797369',
//     //       time: '2024-08-05 10:34',
//     //       ipLocation: '浙江',
//     //       replies: [
//     //         ReplyItem(
//     //           username: '奇骨大魔王乔恩琼斯',
//     //           content: '去年赢过，单纯直接打穿，不知道为啥kin去了g赢过，',
//     //           time: '2024-8-5 10:36',
//     //         ),
//     //       ],
//     //     ),
//     //   ],
//     // );
//   }
// }

class CommentItem extends StatefulWidget {
  final int floor;
  final String username;
  final String content;
  final String? avatar;
  final int time;
  final List<ReplyItem> replies;

  const CommentItem({
    super.key,
    required this.floor,
    required this.username,
    required this.content,
    required this.avatar,
    required this.time,
    this.replies = const [],
  });

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem>
    with AutomaticKeepAliveClientMixin {
  bool isExpanded = false;

  @override
  bool get wantKeepAlive => true;

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
                avatar: widget.avatar ??
                    "https://img.zcool.cn/community/012e805a0eaa25a80121985cdaec9b.jpg@2o.jpg",
                username: widget.username,
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
                      constraints: const BoxConstraints(minHeight: 150),
                      child: ExtendedText(
                        widget.content,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Text(RelativeDateFormat.timeStamp2Str(widget.time),
                          style: commentTimeStyle),
                      const SizedBox(width: 8),
                      Text('${widget.floor}楼', style: commentTimeStyle),
                      const SizedBox(width: 8),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Text(
                            isExpanded
                                ? '收起回复'
                                : '回复${widget.replies.isNotEmpty ? '(${widget.replies.length})' : ''}',
                            style: const TextStyle(color: Colors.blue),
                          ),
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  if (isExpanded)
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                  AnimatedContainer(
                    constraints: const BoxConstraints(
                      maxHeight: 400,
                    ),
                    duration: const Duration(milliseconds: 300),
                    height: isExpanded ? widget.replies.length * 70 : 0,
                    child: ListView(
                      children: widget.replies.map((reply) => reply).toList(),
                    ),
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

class ReplyItem extends StatelessWidget {
  final String username;
  final String content;
  final int time;
  final String? avatar;

  const ReplyItem({
    super.key,
    required this.username,
    required this.content,
    required this.time,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F8FA),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
              child: Image.network(
                avatar ??
                    "https://img.zcool.cn/community/012e805a0eaa25a80121985cdaec9b.jpg@2o.jpg",
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: ExtendedRichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: username,
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        TextSpan(text: ": $content")
                      ]),
                    )),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          RelativeDateFormat.timeStamp2Str(time),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: const Text(
                              "回复",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
                            ),
                            onTap: () {
                              print("object");
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> generateFakeComments(
    int page, int itemsPerPage, int totalComments) {
  final random = Random();
  final List<String> authors = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];
  final List<String> contents = [
    'Hello, world!',
    'Flutter is awesome!',
    'Dart is a great language.',
    'Mobile development is fun!',
    'Learning Flutter is rewarding.'
  ];
  final List<String> avatars = [
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.7b6bd638.8RguHecVQPgJ7-sFdko6sQ?t=1633259905',
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.fb35b2a2.JhmaphYoWJySiF4Tu6x-yw?t=1586289123',
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.d0652a2e.DzE0ZDnup9Z6rfLMqvjSXg?t=1717806111',
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.43bde2c9.0RtX8gu1_avsgSCYqzoqqQ?t=1684009793',
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.16be06ae.obeb_CVyMn-W2SgELW3POg?t=1492740074'
  ];
  final List<String> ipLocations = ['北京', '上海', '广州', '深圳', '杭州'];

  List<Map<String, dynamic>> fakeComments = [];

  int startIndex = (page - 1) * itemsPerPage;
  int endIndex = min(startIndex + itemsPerPage, totalComments);

  for (int i = startIndex; i < endIndex; i++) {
    fakeComments.add({
      'floor': '${i + 1}楼',
      'username': authors[random.nextInt(authors.length)],
      'content': contents[random.nextInt(contents.length)],
      'avatar': avatars[random.nextInt(avatars.length)],
      'time': DateTime.now()
          .subtract(Duration(days: random.nextInt(30)))
          .toString(),
      'ipLocation': ipLocations[random.nextInt(ipLocations.length)],
      'replies': [],
    });
  }

  return fakeComments;
}
