import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../utils/time.dart';
import '../../widget/niw.dart';
import '../../widget/show_action.dart';
import '../../widget/svg.dart';

class Topic extends StatefulWidget {
  PostData data;
  double? top;
  double? bottom;
  bool? blackOccu;
  bool? hideColumn;
  bool? isLeftNaviUI;
  bool? removeMargin;
  bool? hidePicture;
  Color? backgroundColor;

  final Function(int)? onDelete;
  final Function(int, bool)? onPin;
  final Function(int)? onTap;

  Topic({
    Key? key,
    required this.data,
    this.top,
    this.bottom,
    this.blackOccu,
    this.hideColumn,
    this.isLeftNaviUI,
    this.removeMargin,
    this.hidePicture,
    this.backgroundColor,
    this.onDelete,
    this.onPin,
    this.onTap,
  }) : super(key: key);

  @override
  _TopicState createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  // bool isBlack = false;
  // String? blackKeyWord = "";

  @override
  void initState() {
    super.initState();
  }

  // _feedbackSuccess() async {
  //   showToast(
  //     context: context,
  //     type: XSToast.success,
  //     txt: "已举报",
  //   );
  // }

  // _feedback() async {
  //   String txt = "";
  //   showPop(context, [
  //     Container(height: 30),
  //     Text(
  //       "请输入举报内容",
  //       style: TextStyle(
  //         fontSize: 20,
  //         fontWeight: FontWeight.bold,
  //         color: Provider.of<ColorProvider>(context, listen: false).isDark
  //             ? os_dark_white
  //             : os_black,
  //       ),
  //     ),
  //     Container(height: 10),
  //     Container(
  //       height: 60,
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 15,
  //       ),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(15)),
  //         color: Provider.of<ColorProvider>(context, listen: false).isDark
  //             ? os_white_opa
  //             : os_grey,
  //       ),
  //       child: Center(
  //         child: TextField(
  //           keyboardAppearance:
  //               Provider.of<ColorProvider>(context, listen: false).isDark
  //                   ? Brightness.dark
  //                   : Brightness.light,
  //           onChanged: (e) {
  //             txt = e;
  //           },
  //           style: TextStyle(
  //             color: Provider.of<ColorProvider>(context, listen: false).isDark
  //                 ? os_dark_white
  //                 : os_black,
  //           ),
  //           cursorColor: os_deep_blue,
  //           decoration: InputDecoration(
  //               hintText: "请输入",
  //               border: InputBorder.none,
  //               hintStyle: TextStyle(
  //                 color:
  //                     Provider.of<ColorProvider>(context, listen: false).isDark
  //                         ? os_dark_dark_white
  //                         : os_deep_grey,
  //               )),
  //         ),
  //       ),
  //     ),
  //     Container(height: 10),
  //     Row(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(right: 10),
  //           child: myInkWell(
  //             tap: () {
  //               Navigator.pop(context);
  //             },
  //             color: Provider.of<ColorProvider>(context, listen: false).isDark
  //                 ? os_white_opa
  //                 : Color(0x16004DFF),
  //             widget: Container(
  //               width: (MediaQuery.of(context).size.width -
  //                           MinusSpace(context) -
  //                           60) /
  //                       2 -
  //                   5,
  //               height: 40,
  //               child: Center(
  //                 child: Text(
  //                   "取消",
  //                   style: TextStyle(
  //                     color: Provider.of<ColorProvider>(context, listen: false)
  //                             .isDark
  //                         ? os_dark_dark_white
  //                         : os_deep_blue,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             radius: 12.5,
  //           ),
  //         ),
  //         Container(
  //           child: myInkWell(
  //             tap: () async {
  //               await Api().user_report({
  //                 "idType": "thread",
  //                 "message": txt,
  //                 "id": widget.data!["topic_id"]
  //               });
  //               Navigator.pop(context);
  //               _feedbackSuccess();
  //             },
  //             color: os_deep_blue,
  //             widget: Container(
  //               width: (MediaQuery.of(context).size.width -
  //                           MinusSpace(context) -
  //                           60) /
  //                       2 -
  //                   5,
  //               height: 40,
  //               child: Center(
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.done, color: os_white, size: 18),
  //                     Container(width: 5),
  //                     Text(
  //                       "完成",
  //                       style: TextStyle(
  //                         color: os_white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             radius: 12.5,
  //           ),
  //         ),
  //       ],
  //     ),
  //   ]);
  // }

  _moreAction() async {
    var options = ["删除此贴", "置顶此贴"];
    var icons = [Icons.delete_sharp, Icons.arrow_upward];
    if (widget.data!.pin == 1) {
      options[1] = "取消置顶";
      icons[1] = Icons.arrow_downward;
    }
    showAction(
      context: context,
      options: options,
      icons: icons,
      tap: (res) async {
        switch (res) {
          case "删除此贴":
            Navigator.pop(context);
            await widget.onDelete?.call(widget.data!.id);
            break;
          case "置顶此贴":
            Navigator.pop(context);
            await widget.onPin?.call(widget.data!.id, true);
            break;
          case "取消置顶":
            Navigator.pop(context);
            await widget.onPin?.call(widget.data!.id, false);
          default:
            break;
        }
      },
    );
  }

  // _setHistory() async {
  //   var history_data = await getStorage(key: "history", initData: "[]");
  //   List history_arr = jsonDecode(history_data);
  //   bool flag = false;
  //   for (int i = 0; i < history_arr.length; i++) {
  //     var ele = history_arr[i];
  //     if (ele["userAvatar"] == widget.data!["userAvatar"] &&
  //         ele["title"] == widget.data!["title"] &&
  //         ele["subject"] ==
  //             ((widget.data!["summary"] ?? widget.data!["subject"]) ?? "")) {
  //       history_arr.removeAt(i);
  //     }
  //   }
  //   List tmp_list_history = [
  //     {
  //       "userAvatar": widget.data!["userAvatar"],
  //       "title": widget.data!["title"],
  //       "subject": (widget.data!["summary"] ?? widget.data!["subject"]) ?? "",
  //       "time": widget.data!["last_reply_date"],
  //       "topic_id": (widget.data!["source_id"] ?? widget.data!["topic_id"]),
  //     }
  //   ];
  //   tmp_list_history.addAll(history_arr);
  //   setStorage(key: "history", value: jsonEncode(tmp_list_history));
  // }

  // Widget _blackCont() {
  //   //拉黑的状态
  //   return Container(
  //     child: (widget.blackOccu ?? false)
  //         ? Padding(
  //             padding: EdgeInsets.fromLTRB(
  //               os_edge,
  //               widget.top ?? 10,
  //               os_edge,
  //               widget.bottom ?? 0,
  //             ),
  //             child: myInkWell(
  //               color: Provider.of<ColorProvider>(context).isDark
  //                   ? os_light_dark_card
  //                   : os_white,
  //               radius: 10,
  //               widget: Padding(
  //                 padding: const EdgeInsets.all(15),
  //                 child: Text(
  //                   "此贴已被你屏蔽，屏蔽关键词为:" + blackKeyWord!,
  //                   style: TextStyle(
  //                     color: os_deep_grey,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         : Container(),
  //   );
  // }

  //卡片图案
  // Widget _getTopicCardImg() {
  //   double img_size = (MediaQuery.of(context).size.width - 55) / 3 - 3.3;
  //   img_size = img_size > 150 ? 150 : img_size;
  //   // print(widget.data["imageList"]);
  //   if (widget.data != null &&
  //       widget.data!["imageList"] != null &&
  //       widget.data!["imageList"].length != 0) {
  //     int splitCount = isDesktop() ? 2 : 3;
  //     if (widget.data!["imageList"].length > splitCount)
  //       widget.data!["imageList"] =
  //           widget.data!["imageList"].sublist(0, splitCount);
  //     List<Widget> _getImg(List? a) {
  //       List<Widget> t = [];
  //       for (int i = 0; i < widget.data!["imageList"].length; i++) {
  //         var url = widget.data!["imageList"][i];
  //         t.add(ConstrainedBox(
  //           constraints: BoxConstraints(
  //             maxHeight: img_size,
  //             maxWidth: img_size,
  //           ),
  //           child: GestureDetector(
  //             onTap: () {
  //               fadeWidget(
  //                 newPage: PhotoPreview(
  //                   isSmallPic: true,
  //                   galleryItems: widget.data!["imageList"],
  //                   defaultImage: i,
  //                 ),
  //                 context: context,
  //               );
  //             },
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(2.5),
  //               child: CachedNetworkImage(
  //                 imageUrl: url,
  //                 maxHeightDiskCache: 800,
  //                 maxWidthDiskCache: 800,
  //                 memCacheWidth: 800,
  //                 memCacheHeight: 800,
  //                 width: img_size,
  //                 height: img_size,
  //                 filterQuality: FilterQuality.low,
  //                 fit: BoxFit.cover,
  //                 errorWidget: (context, url, error) => Container(
  //                   child: Icon(
  //                     Icons.image,
  //                     size: 40,
  //                     color: Provider.of<ColorProvider>(context).isDark
  //                         ? Color(0x22ffffff)
  //                         : os_middle_grey,
  //                   ),
  //                   color: Provider.of<ColorProvider>(context).isDark
  //                       ? os_white_opa
  //                       : os_grey,
  //                 ),
  //                 placeholder: (context, url) => Container(
  //                   child: Icon(
  //                     Icons.image,
  //                     size: 40,
  //                     color: Provider.of<ColorProvider>(context).isDark
  //                         ? Color(0x22ffffff)
  //                         : os_middle_grey,
  //                   ),
  //                   color: Provider.of<ColorProvider>(context).isDark
  //                       ? os_white_opa
  //                       : os_grey,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ));
  //         if (i != 2) {
  //           t.add(Container(width: 5));
  //         }
  //       }
  //       return t;
  //     }

  //     return Container(
  //       height: img_size,
  //       width: MediaQuery.of(context).size.width,
  //       child: Row(
  //         children: _getImg(widget.data!["imageList"]),
  //       ),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

  Widget _topicCont() {
    //帖子卡片正文内容
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: widget.data?.pin == 0 ? Colors.black : Colors.green,
          width: widget.data?.pin == 0 ? 1 : 3,
        ),
      ),
      child: Padding(
        // padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
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
                                  image: NetworkImage(widget
                                          .data?.user?.avatar ??
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
                          widget.data.user!.nickname,
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
                                  widget.data.updatedAt * 1000)),
                          style: const TextStyle(
                            color: Color(0xFFAAAAAA),
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    MyInkWell(
                      tap: () {
                        _moreAction();
                      },
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
                              color: Color(0xFF585858),
                            ),
                          ],
                        ),
                      ),
                      radius: 100,
                    ),
                    Container(width: 16),
                  ],
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(4)),
            //中部区域：标题
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(widget.data!.title,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 17,
                    letterSpacing: 0.5,
                    color: Colors.black,
                  )),
            ),
            const Padding(padding: EdgeInsets.all(3)),
            //中部区域：正文
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                widget.data.content,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF999999),
                ),
              ),
            ),
            Container(width: 16),
            const Padding(padding: EdgeInsets.all(1.5)),
            //浏览量 评论数 点赞数 - 专栏按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(width: 20),
                    SvgWidget(
                      path: "assets/images/topic_component_comment.svg",
                      width: 20,
                      height: 20,
                    ),
                    Container(width: 5),
                    Text(
                      "${widget.data.replyCount}",
                      style: const TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 12,
                      ),
                    ),
                    Container(width: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _tapWidget() async {
    // int tid = (widget.data!["source_id"] ?? widget.data!["topic_id"]);
    // // if (Platform.isWindows &&
    // //     (widget.data["board_name"] == "视觉艺术" ||
    // //         widget.data["board_name"] == "镜头下的成电")) {
    // //   showModal(
    // //       context: context,
    // //       title: "请确认",
    // //       cont: "即将在浏览器中打开此帖子",
    // //       confirmTxt: "确认",
    // //       cancelTxt: "取消",
    // //       confirm: () {
    // //         xsLanuch(
    // //           url: "https://bbs.uestc.edu.cn/forum.php?mod=viewthread&tid=$tid",
    // //         );
    // //       });
    // //   return;
    // // }
    // String info_txt = await getStorage(key: "myinfo", initData: "");
    // _setHistory();
    // if (info_txt == "") {
    //   Navigator.pushNamed(context, "/login", arguments: 0);
    // } else {
    //   Navigator.pushNamed(
    //     context,
    //     "/topic_detail",
    //     arguments: (widget.data!["source_id"] ?? widget.data!["topic_id"]),
    //   );
    // }
    widget.onTap!(widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
      child: MyInkWell(
        color: Colors.white,
        tap: () => _tapWidget(),
        widget: _topicCont(),
        radius: 10,
      ),
    );
  }
}
