import 'dart:async';

import 'package:changweiba/models/post.dart';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../api/post.dart';
import '../../models/pull_load.dart';
import '../../widget/pull_load_widget.dart';
import 'post_item.dart';

class PostPage extends StatefulWidget {
  PostPage({super.key});

  late _PostPageState postPageState;

  @override
  _PostPageState createState() {
    postPageState = _PostPageState();
    return postPageState;
  }

  _PostPageState getState() => postPageState;
}

class _PostPageState extends State<PostPage> {
  ///控制列表滚动和监听
  final ScrollController scrollController = ScrollController();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  var controller = PullLoadWidgetControl();

  int totalPostCount = 0;
  int currentPage = 1;

  @override
  void dispose() {
    debugPrint("dispose postpage");
    // 取消定时器
    super.dispose();
    Get.delete<PullLoadWidgetControl>(tag: "post");
  }

  @override
  void initState() {
    super.initState();
    // controller.needLoadMore = false;
    manuallyUpdateData();
  }

  Future<void> manuallyUpdateData() async {
    currentPage = 1;
    controller.needLoadMore = true;
    SmartDialog.showLoading();
    var items = await getMyPosts(currentPage, 10);
    if (items.isEmpty) {
      SmartDialog.dismiss();
      return;
    }
    SmartDialog.dismiss();
    controller.clear();
    controller.addList(items);
    currentPage = 2;
  }

  Future<List<PostData>> getMyPosts(int page, int pageSize) async {
    List<PostData> items = [];
    try {
      var resp = await getPosts(page, pageSize);
      if (resp.code == 200) {
        if (resp.data.nodes != null) {
          if (resp.data.nodes!.isNotEmpty) {
            for (var item in resp.data.nodes!) {
              items.add(PostData(item.id, item.title, item.content,
                  item.replyCount, item.createdAt, item.updatedAt,
                  tag: item.tag,
                  user: item.user,
                  comment: item.comment,
                  reply: item.reply));
            }
          }
          totalPostCount = resp.data.totalCount!;
        }
      } else {
        SmartDialog.showToast(resp.message);
      }
    } catch (e) {
      debugPrint(e.toString());
      SmartDialog.showToast("internal server or network error");
    }
    if (currentPage * 10 >= totalPostCount) {
      controller.needLoadMore = false;
    }

    return items;
  }

  // 刷新stock实时数据
  Future<void> refreshPostData() async {
    //test
    // final _random = Random();
    // int next(int min, int max) => min + _random.nextInt(max - min);
    // var index = next(0, controller.dataList.length);
    // var num = next(-10, 10);
    // controller.dataList[index].price = 13.4 + num;
    // controller.dataList[index].fallRate = 0.1 + num;
    // controller.update();
    // TODO:
  }

  ///下拉刷新数据
  Future<void> requestRefresh() async {
    await manuallyUpdateData();
  }

  Future<void> onLoadMore() async {
    var items = await getMyPosts(currentPage, 10);
    if (items.isNotEmpty) {
      controller.addList(items);
    }
    currentPage++;
  }

  Future<void> onDeletePost(int id) async {
    var resp = await deletePost(id);
    if (resp.code == 200) {
      SmartDialog.showToast("删帖成功");
    } else {
      SmartDialog.showToast(resp.message);
    }
    await manuallyUpdateData();
  }

  @override
  Widget build(BuildContext context) {
    PullLoadWidgetControl c = Get.put(controller, tag: "post");
    return Scaffold(
      body: PullLoadWidget(
        control: c,
        itemBuilder: (context, index) {
          return Obx(() => Topic(
                data: c.dataList[index],
                onDelete: onDeletePost,
              ));
        },
        onRefresh: requestRefresh,
        onLoadMore: onLoadMore,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
    // return PullLoadWidget(
    //   control: c,
    //   itemBuilder: (context, index) {
    //     return Obx(() => Topic(
    //           data: c.dataList[index],
    //           onDelete: onDeletePost,
    //         ));
    //   },
    //   onRefresh: requestRefresh,
    //   onLoadMore: onLoadMore,
    // );
  }
}