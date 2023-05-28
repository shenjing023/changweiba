import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../utils/time.dart';
import '../../widget/niw.dart';

class CommentCard extends StatefulWidget {
  Comment data;
  CommentCard(this.data, {Key? key}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  List<Widget> _buildReplies() {
    List<Text> replies = [];
    widget.data.replies?.nodes?.forEach((reply) {
      replies.add(
        Text(
          "${reply.user!.nickname}: ${reply.content}",
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      );
    });
    return replies;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 头像
              GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(widget.data.user?.avatar ??
                                "https://tse3-mm.cn.bing.net/th/id/OIP.iJyZTWUQ41RGdoVYjU-ARAHaE7?w=262&h=180&c=7&o=5&pid=1.7"),
                            fit: BoxFit.cover)),
                  ),
                  // child: CachedNetworkImage(
                  //   width: 30,
                  //   height: 30,
                  //   fit: BoxFit.cover,
                  //   imageUrl: widget.data!["userAvatar"],
                  //   placeholder: (context, url) => Container(
                  //       color: Provider.of<ColorProvider>(context).isDark
                  //           ? os_dark_white
                  //           : os_grey),
                  //   errorWidget: (context, url, error) =>
                  //       Icon(Icons.error),
                  // ),
                ),
              ),
              // 右边部分
              SizedBox(
                width: MediaQuery.of(context).size.width - 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 昵称一栏
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 昵称
                          Row(children: [
                            Text(
                              widget.data.user?.nickname ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ]),
                          // 右边更多
                          Row(
                            children: [
                              MyInkWell(
                                tap: () {},
                                color: Colors.transparent,
                                widget: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(
                                    Icons.more_horiz_sharp,
                                    size: 18,
                                    color: Color(0xFF585858),
                                  ),
                                ),
                                radius: 10,
                              ),
                            ],
                          ),
                        ]),
                    // 回复内容
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(
                        widget.data.content ?? "",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Row(children: [
                      Text(
                        "第${widget.data.floor}楼",
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: Color(0xFFAAAAAA),
                        ),
                      ),
                      Container(
                        width: 5,
                      ),
                      Text(
                        RelativeDateFormat.format(
                            DateTime.fromMillisecondsSinceEpoch(
                                widget.data.createdAt! * 1000)),
                        style: const TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 12,
                        ),
                      ),
                    ]),
                    // 评论内容
                    widget.data.replies != null
                        ? ((widget.data.replies?.totalCount != 0)
                            ? Transform.translate(
                                offset: const Offset(-7, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 75,
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: const BoxDecoration(
                                    color: Color(0x09000000),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _buildReplies(),
                                  ),
                                ),
                              )
                            : Container())
                        : Container(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
