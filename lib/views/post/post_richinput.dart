import 'package:flutter/material.dart';

import '../../widget/niw.dart';

class RichInput extends StatefulWidget {
  double? bottom;
  TextEditingController controller;
  FocusNode focusNode;
  Function cancel;
  Function send;
  String placeholder;
  bool sending;
  RichInput({
    Key? key,
    this.bottom,
    required this.controller,
    required this.focusNode,
    required this.cancel,
    required this.send,
    required this.placeholder,
    required this.sending,
  }) : super(key: key);

  @override
  _RichInputState createState() => _RichInputState();
}

class _RichInputState extends State<RichInput> with TickerProviderStateMixin {
  late AnimationController controller; //动画控制器
  late Animation<double> animation;
  double popHeight = 0;

  _foldPop() async {
    controller.reverse();
    setState(() {});
  }

  // @override
  // void onKeyboardChanged(bool isShow) {
  //   // final viewInsets = EdgeInsets.fromViewPadding(
  //   //   View.of(context).viewInsets,
  //   //   View.of(context).devicePixelRatio,
  //   // );
  //   // debugPrint("viewInsets2: ${viewInsets.bottom}");
  //   // setState(() {
  //   //   popSection = isShow;
  //   // });
  // }

  @override
  void initState() {
    super.initState();
    // widget.controller.addListener(() {
    //   inserting_num = widget.controller.selection.base.offset;
    // });
    // widget.focusNode.addListener(() {
    //   if (widget.focusNode.hasFocus) {
    //     _foldPop();
    //   }
    // });
    // controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );
    // animation = Tween(begin: 0.0, end: 300.0).animate(CurvedAnimation(
    //   parent: controller,
    //   curve: Curves.easeInOut,
    // ))
    //   ..addListener(() {
    //     setState(() {
    //       popHeight = animation.value;
    //     });
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 110,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                  width: 1, color: Color.fromARGB(255, 231, 227, 227))),
          boxShadow: [],
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 15),
            // 输入框
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width) * 0.7,
                  height: 90,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    minLines: 4,
                    maxLines: null,
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.multiline,
                    cursorColor: Colors.green,
                    showCursor: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: widget.placeholder,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (v) {},
                  ),
                ),
                Container(),
              ],
            ),
            // 取消发送按钮
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyInkWell(
                  color: Colors.transparent,
                  tap: () {
                    widget.cancel();
                  },
                  widget: SizedBox(
                    width: (MediaQuery.of(context).size.width) * 0.25,
                    height: 40,
                    child: const Center(
                      child: Text(
                        "取消",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF656565),
                        ),
                      ),
                    ),
                  ),
                  radius: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: MyInkWell(
                    tap: () {
                      if (!widget.sending) {
                        widget.send(widget.controller.text);
                      }
                    },
                    color: const Color(0xFF004DFF),
                    widget: SizedBox(
                      width: (MediaQuery.of(context).size.width) * 0.2,
                      height: 40,
                      child: Center(
                        child: widget.sending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "发送",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                      ),
                    ),
                    radius: 5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailFixBottom extends StatefulWidget {
  double? bottom;
  Function? tapEdit;
  DetailFixBottom({
    Key? key,
    this.tapEdit,
    this.bottom,
  }) : super(key: key);

  @override
  _DetailFixBottomState createState() => _DetailFixBottomState();
}

class _DetailFixBottomState extends State<DetailFixBottom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        height: 62 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.fromLTRB(
            7, 7, 7, 7 + MediaQuery.of(context).padding.bottom),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyInkWell(
              tap: () {
                widget.tapEdit!();
              },
              radius: 10,
              color: Colors.transparent,
              widget: SizedBox(
                width: MediaQuery.of(context).size.width - 156,
                height: 47,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 200,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mode_edit,
                          color: Color(0xFFBBBBBB),
                          size: 18,
                        ),
                        Container(width: 5),
                        const Text(
                          "我一出口就是神回复",
                          style: TextStyle(color: Color(0xFF8B8B8B)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Row(
            //   children: [
            //     SizedBox(
            //       height: 47,
            //       child: Center(
            //         child: MyInkWell(
            //             tap: () {},
            //             color: Colors.transparent,
            //             widget: Center(
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Container(width: 5),
            //                   Transform.rotate(
            //                     angle: 3.14,
            //                     child: SvgWidget(
            //                       path:
            //                           "assets/images/topic_component_comment.svg",
            //                       width: 25,
            //                       height: 25,
            //                     ),
            //                   ),
            //                   const Padding(padding: EdgeInsets.all(1)),
            //                   // Text(
            //                   //   "${widget.replyCount}",
            //                   //   style: const TextStyle(
            //                   //     color: Color(0xFFB1B1B1),
            //                   //   ),
            //                   // ),
            //                   Container(width: 5),
            //                 ],
            //               ),
            //             ),
            //             radius: 10),
            //       ),
            //     ),
            //     Container(width: 5),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
