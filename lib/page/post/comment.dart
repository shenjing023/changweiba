import 'package:changweiba/api/post.dart';
import 'package:changweiba/model/post.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../constant/style.dart';
import '../../util/shared_preferences.dart';
import '../../util/time.dart';
import '../login/login.dart';
import 'post_detail.dart';

class CommentItem extends StatefulWidget {
  final int floor;
  final String username;
  final String content;
  final String? avatar;
  final int time;
  List<ReplyItem> replies;
  final int postID;
  final int id;

  CommentItem({
    super.key,
    required this.floor,
    required this.username,
    required this.content,
    required this.avatar,
    required this.time,
    required this.postID,
    required this.id,
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

  Future<void> addReply(String content) async {
    try {
      var resp = await newReply(widget.postID, widget.id, content, 0);
      if (resp.code == 200) {
        SmartDialog.showToast("评论成功");
      } else {
        SmartDialog.showToast("评论失败");
      }
    } catch (e) {
      debugPrint(e.toString());
      SmartDialog.showToast("评论失败");
    }
  }

  Future<void> fetchReplyData() async {
    Replies data = await _fetchReplyData();
    if (data.totalCount == 0) {
      return;
    }

    List<ReplyItem> replyItems = [];
    if (data.nodes != null) {
      for (var item in data.nodes!) {
        replyItems.add(ReplyItem(
          username: item.user!.nickname,
          content: item.content!,
          time: item.createdAt!,
          avatar: item.user!.avatar,
        ));
      }
    }
    widget.replies = replyItems;
    setState(() {});
  }

  Future<Replies> _fetchReplyData() async {
    SmartDialog.showLoading();
    Replies result = Replies();
    try {
      var resp = await getReplies(widget.id);
      if (resp.code == 200) {
        result = resp.data;
      } else {
        SmartDialog.showToast("获取回复失败");
      }
    } catch (e) {
      debugPrint(e.toString());
      SmartDialog.showToast("internal server or network error");
    } finally {
      SmartDialog.dismiss();
    }

    return result;
  }

  Future<void> _showCreateReplyDialog() async {
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
              maxWidth: 400,
              maxHeight: 180,
            ),
            child: ReplyEditor(
              onCreated: (content) async {
                SmartDialog.dismiss();
                await addReply(content);
                fetchReplyData();
              },
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    "https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.b76c4090.oObStJYFWjUrtGciolLY8w?t=1620484586",
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
                    constraints: const BoxConstraints(
                      minHeight: 150,
                      maxHeight: 400,
                    ),
                    child: ScrollConfiguration(
                      behavior: NoScrollbarBehavior(), // 自定义滚动行为
                      child: SelectionArea(
                        child: SingleChildScrollView(
                          // 添加 SingleChildScrollView
                          child: MarkdownBody(data: widget.content),
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: const Text(
                            "回复",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () {
                            _showCreateReplyDialog();
                          },
                        ),
                      ),
                      const Spacer(),
                      Text(RelativeDateFormat.timeStamp2Str(widget.time),
                          style: commentTimeStyle),
                      const SizedBox(width: 8),
                      Text('${widget.floor}楼', style: commentTimeStyle),
                      const SizedBox(width: 8),
                      if (widget.replies.isNotEmpty)
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: Text(
                              isExpanded
                                  ? '收起回复'
                                  : '回复(${widget.replies.length})',
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

class ReplyEditor extends StatelessWidget {
  final Function(String) onCreated;
  final TextEditingController _contentController = TextEditingController();

  ReplyEditor({
    super.key,
    required this.onCreated,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('创建新回复'),
          actions: [
            TextButton(
              onPressed: () {
                onCreated(_contentController.text);
              },
              child: const Text(
                '发布',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _contentController,
            style: const TextStyle(color: Colors.blue),
            maxLines: 3,
            cursorColor: Colors.green,
            // cursorRadius: const Radius.circular(3),
            // cursorWidth: 5,
            // showCursor: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: "请输入...",
              border: OutlineInputBorder(),
            ),
            onChanged: (v) {},
            maxLength: 50,
          ),
        ));
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

  void _showCreateReplyDialog() {
    SmartDialog.show(builder: (_) {
      return LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
              maxHeight: 180,
            ),
            child: ReplyEditor(
              onCreated: (result) {
                SmartDialog.dismiss();
                print(result);
              },
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F8FA),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 40,
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
                        // MouseRegion(
                        //   cursor: SystemMouseCursors.click,
                        //   child: GestureDetector(
                        //     child: const Text(
                        //       "回复",
                        //       style:
                        //           TextStyle(color: Colors.blue, fontSize: 12),
                        //     ),
                        //     onTap: () {
                        //       _showCreateReplyDialog();
                        //     },
                        //   ),
                        // ),
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
