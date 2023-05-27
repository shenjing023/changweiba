import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../api/post.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({
    Key? key,
  }) : super(key: key);

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  bool sendSuccess = false; //是否发布成功

  TextEditingController titleController = TextEditingController(); //输入的标题控制器
  FocusNode titleFocus = FocusNode(); //标题输入框的focus控制器
  TextEditingController tipController = TextEditingController(); //输入的正文控制器
  FocusNode tipFocus = FocusNode(); //正文输入框的focus控制器
  ScrollController listviewController = ScrollController();

  _send() async {
    String title = titleController.text;
    String content = tipController.text;
    if (title.isEmpty || content.isEmpty) {
      SmartDialog.showToast("标题或正文不能为空");
      return;
    }

    var resp = await newPost(title, content);
    if (resp.code == 200) {
      SmartDialog.showToast("发帖成功");
      sendSuccess = true;
      titleController.clear();
      tipController.clear();
    } else {
      SmartDialog.showToast(resp.message);
    }
  }

  @override
  void initState() {
    // tip_controller.addListener(() {
    //   setState(() {
    //     tip_controller_offset = tip_controller.selection.base.offset;
    //   });
    // });
    // tip_focus.addListener(() {
    //   if (tip_focus.hasFocus) {
    //     pop_section = false;
    //     title_focus.unfocus();
    //   }
    //   setState(() {});
    // });
    // title_focus.addListener(() {
    //   if (title_focus.hasFocus) {
    //     pop_section = false;
    //     tip_focus.unfocus();
    //     setState(() {});
    //   }
    // });
    super.initState();
  }

  Widget _buildSendBtn() {
    return GestureDetector(
      onTap: () => _send(),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 10, top: 14, bottom: 14),
        child: Container(
          width: 60,
          height: 25,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: const Center(
            child: Text(
              "发布",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F4F8),
        elevation: 0,
        title: const Text(
          "发帖",
          style: TextStyle(fontSize: 16, color: Color(0xFF2E2E2E)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2E2E2E)),
          onPressed: () => Get.back(result: sendSuccess),
        ),
        actions: [
          _buildSendBtn(),
        ],
      ),
      body: Container(
        color: const Color(0xFFF1F4F8),
        child: Stack(
          children: [
            Positioned(
              child: ListView(
                //physics: BouncingScrollPhysics(),
                controller: listviewController,
                children: [
                  TitleInput(
                    titleController: titleController,
                    titleFocus: titleFocus,
                  ),
                  Container(),
                  ContInput(
                    tipController: tipController,
                    tipFocus: tipFocus,
                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContInput extends StatefulWidget {
  final TextEditingController tipController;
  final FocusNode tipFocus;
  const ContInput({
    Key? key,
    required this.tipController,
    required this.tipFocus,
  }) : super(key: key);

  @override
  State<ContInput> createState() => _ContInputState();
}

class _ContInputState extends State<ContInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
      child: TextField(
        keyboardAppearance: Brightness.light,
        controller: widget.tipController,
        focusNode: widget.tipFocus,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        cursorColor: Colors.green,
        style: const TextStyle(
          height: 1.8,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 200, top: 10),
          border: InputBorder.none,
          hintStyle: TextStyle(
            height: 1.8,
            color: Color(0xFFA3A3A3),
          ),
          hintText: "说点什么吧…",
        ),
      ),
    );
  }
}

class TitleInput extends StatelessWidget {
  const TitleInput({
    Key? key,
    required this.titleController,
    required this.titleFocus,
  }) : super(key: key);

  final TextEditingController titleController;
  final FocusNode titleFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TextField(
        keyboardAppearance: Brightness.light,
        controller: titleController,
        focusNode: titleFocus,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        // cursorColor: Provider.of<ColorProvider>(context).isDark
        //     ? os_dark_back
        //     : os_white,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 2,
              color: Colors.greenAccent,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 2,
              color: Colors.black38,
              style: BorderStyle.solid,
            ),
          ),
          hintStyle: TextStyle(
            fontSize: 17,
            color: Color(0xFFA3A3A3),
          ),
          hintText: "请输入帖子的标题",
        ),
      ),
    );
  }
}
