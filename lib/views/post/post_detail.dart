import 'dart:async';
import 'dart:io';
import 'package:changweiba/models/post.dart';
import 'package:changweiba/views/post/post_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../models/auth.dart';
import '../../utils/time.dart';
import '../../widget/niw.dart';
import '../../widget/totop.dart';
import 'post_richinput.dart';

class PostDetail extends StatefulWidget {
  int? postID;
  PostDetail({Key? key}) : super(key: key) {
    postID = Get.arguments;
  }

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late PostData data;
  List<dynamic>? comment = [];
  bool? load_done = false;
  var loading = false;
  var showBackToTop = false;
  int? total_num = 0; //评论总数
  String uploadFileAid = "";
  var replyId = 0;
  int stick_num = 0;
  double bottom_safeArea = 10;
  bool editing = false; //是否处于编辑状态
  bool isBlack = false;
  bool isInvalid = false; //帖子是否失效
  bool isNoAccess = false; //帖子是否没有访问权限
  bool isDispose = false; //是否释放了页面
  bool sending = false; //是否正在发送
  String placeholder = "请在此编辑回复";

  String? blackKeyWord = "";
  ScrollController _scrollController = ScrollController();
  TextEditingController _txtController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  double getBottomSafeArea() {
    return MediaQuery.of(context).padding.bottom;
  }

  Future _getData() async {
    data = PostData(
        widget.postID!,
        "title11是否应当看到就开了阿萨大大1111",
        "content12爱神的箭阿三法语考试的话饭卡上的还得看哦i是肯定看哈上课的哈萨克返还借款撒谎客户公司就看到过撒娇或多个撒娇的国际化31231231",
        5,
        1685022720,
        1685022720,
        0,
        user: User("nickname", 8, "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg"),
        comments: [
          CommentData(
              2, widget.postID!, 2, "啊的客服就丢掉疯狂的麻痹u阿哥撒旦吉萨利空打击案例大赛", 1685022720,
              user: User(
                  "nickname", 8, "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg"),
              replies: [
                ReplyData(
                    2, widget.postID!, 2, 1, "contentsadasdad", 1685022720,
                    user: User("nickname", 8,
                        "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg")),
                ReplyData(
                    3, widget.postID!, 2, 2, "contentsadasdad", 1685022720,
                    user: User("nickname", 8,
                        "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg")),
              ]),
          CommentData(
              3, widget.postID!, 3, "conten设计的凯撒巨大石块角度考虑阿松大t22321", 1685022720,
              user: User(
                  "nickname", 8, "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg"),
              replies: [
                ReplyData(4, widget.postID!, 3, 1, "时间快速发撒大家", 1685022720,
                    user: User("nickname", 8,
                        "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg")),
                ReplyData(5, widget.postID!, 3, 2, "是的客服的劳动力肯德基的浮动空间看看手机打开手机",
                    1685022720,
                    user: User("nickname", 8,
                        "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg")),
              ]),
          CommentData(
            4,
            widget.postID!,
            4,
            "设计的凯撒巨大石块角度考虑321",
            1685022720,
            user: User(
                "nickname", 8, "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg"),
          ),
          CommentData(
              5, widget.postID!, 5, "conten设计的凯撒巨大石块角度考虑阿松大t22321", 1685022720,
              user: User(
                  "nickname", 8, "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg"),
              replies: [
                ReplyData(6, widget.postID!, 5, 1, "时sdsad间快速发撒大家", 1685022720,
                    user: User("nickname", 8,
                        "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg")),
                ReplyData(7, widget.postID!, 5, 2, "是的客服的劳动力肯德基的浮动空间看看手机打开手机",
                    1685022720,
                    user: User("nickname", 8,
                        "https://s1.ax1x.com/2023/05/26/p9qEobn.jpg")),
              ]),
        ]);
  }

  void _getComment() async {
    if (loading || load_done!) return; //控制因为网络过慢反复请求问题
    loading = true;
    setState(() {});
    loading = false;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  bool vibrate = false;

  @override
  void initState() {
    _getData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < -100) {
        if (!vibrate) {
          vibrate = true; //不允许再震动
        }
      }
      if (_scrollController.position.pixels >= 0) {
        vibrate = false; //允许震动
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getComment();
      }
      if (_scrollController.position.pixels > 1000 && !showBackToTop) {
        setState(() {
          showBackToTop = true;
        });
      }
      if (_scrollController.position.pixels < 1000 && showBackToTop) {
        setState(() {
          showBackToTop = false;
        });
      }
    });
  }

  _reply_comment(int i) async {
    //回复某人的评论
  }

  Widget _buildTop() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //顶部区域：左边：头像、昵称、时间 右边：更多按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
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
                                  image: NetworkImage(data.user?.avatar ??
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
                    const Padding(padding: EdgeInsets.all(4)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.user!.nickname,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(height: 1),
                        Text(
                          RelativeDateFormat.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  data.updatedAt * 1000)),
                          style: const TextStyle(
                            color: Color(0xFFAAAAAA),
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(4)),
            //中部区域：标题
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(data.title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 20,
                      letterSpacing: 0.5,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            const Padding(padding: EdgeInsets.all(3)),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                data.content,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ));
  }

  List<Widget> _buildWidget() {
    //对整个页面的组件流进行整合
    List<Widget> tmp = [];
    tmp = [
      //渲染顶部标题
      _buildTop(),
      // Container(
      //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text(
      //         """${RelativeDateFormat.format(DateTime.fromMillisecondsSinceEpoch(data.updatedAt * 1000)).split(" ")[0]}
      //           · 总回复${data.replyCount}""",
      //         style: const TextStyle(
      //           fontSize: 13.5,
      //           color: Color(0xFFAAAAAA),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // //渲染帖子正文内容
      // Container(
      //   padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      //   child: Text(
      //     data.content,
      //     style: const TextStyle(color: Colors.grey, fontSize: 12),
      //   ),
      // ),
      // Container(height: 5),
      Divider(color: Colors.grey.shade300),
    ];
    tmp.add(data.comments!.isEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: const Text(
              "暂无评论",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        : Container());
    for (var i = 0; i < data.comments!.length; i++) {
      tmp.add(CommentCard(
        data.comments![i],
      ));
    }
    tmp.addAll([
      // BottomLoading(
      //   color: Colors.transparent,
      //   txt: "加载剩余10条评论…",
      // ),
      Container(
        height: editing
            ? 250
            : 60 + (Platform.isIOS ? bottom_safeArea : getBottomSafeArea()),
      )
    ]);
    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: const Center(
          child: Text(
            "肠胃吧",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        // title: Text(""),
        actions: [
          // PostDetailHead(data: data.user!),
          MyInkWell(
            tap: () {},
            color: Colors.transparent,
            widget: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.more_horiz_sharp,
                    size: 24,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            radius: 1,
          ),
          const SizedBox(width: 10),
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: RefreshIndicator(
              backgroundColor: Colors.white,
              color: const Color(0xFF0092FF),
              onRefresh: () async {
                // await _getData();
                // vibrate = false;
                // return;
              },
              child: BackToTop(
                  bottom: 115,
                  show: showBackToTop,
                  animation: true,
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _buildWidget().length,
                    itemBuilder: (context, index) {
                      return _buildWidget()[index];
                    },
                  )),
            ),
          ),
          editing //编辑回复框
              ? RichInput(
                  sending: sending,
                  placeholder: placeholder,
                  controller: _txtController,
                  focusNode: _focusNode,
                  cancel: () {
                    _focusNode.unfocus();
                    _txtController.clear();
                    placeholder = ("请在此编辑回复");
                    editing = false;
                    setState(() {});
                  },
                  send: (String content) async {
                    SmartDialog.showToast(content);
                    //完成发表评论
                    setState(() {
                      editing = false;
                      _focusNode.unfocus();
                      _txtController.clear();
                      placeholder = ("请在此编辑回复");
                    });
                    await Future.delayed(const Duration(milliseconds: 30));
                    await _getData();
                  },
                )
              : DetailFixBottom(
                  bottom: getBottomSafeArea(),
                  tapEdit: () {
                    _focusNode.requestFocus();
                    editing = true;
                    setState(() {});
                  },
                )
        ],
      ),
    );
  }
}

//分割线
// class Divider extends StatelessWidget {
//   const Divider({
//     Key? key,
//     required this.context,
//   }) : super(key: key);

//   final BuildContext context;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 10,
//       decoration: const BoxDecoration(
//         // color: Color(0xFFF6F6F6),
//         color: Colors.black,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//     );
//   }
// }

//加载动画
class BottomLoading extends StatefulWidget {
  Color? color;
  String? txt;
  BottomLoading({
    Key? key,
    this.color,
    this.txt,
  }) : super(key: key);

  @override
  _BottomLoadingState createState() => _BottomLoadingState();
}

class _BottomLoadingState extends State<BottomLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color ?? Colors.transparent,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Color(0xFFAAAAAA),
                strokeWidth: 2.5,
              ),
            ),
            Container(width: 10),
            Text(widget.txt ?? "加载中…",
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// 楼主名字头像
class PostDetailHead extends StatelessWidget {
  const PostDetailHead({
    Key? key,
    required this.data,
  }) : super(key: key);

  final User data;

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
        tap: () {},
        color: Colors.transparent,
        widget: Container(
          margin: const EdgeInsets.fromLTRB(5, 12, 5, 12),
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 23,
                    height: 23,
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(data.avatar ??
                                "https://tse3-mm.cn.bing.net/th/id/OIP.iJyZTWUQ41RGdoVYjU-ARAHaE7?w=262&h=180&c=7&o=5&pid=1.7"),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(3)),
              Text(
                data.nickname,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.all(3)),
              MyInkWell(
                tap: () {},
                color: Colors.transparent,
                widget: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.more_horiz_sharp,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                radius: 1,
              ),
              const Padding(padding: EdgeInsets.all(3)),
            ],
          ),
        ),
        radius: 100);
  }
}
