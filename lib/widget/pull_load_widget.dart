import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/style.dart';
import '../models/pull_load.dart';
import 'flare_pull_controller.dart';

class PullLoadWidget extends StatefulWidget {
  ///item渲染
  final IndexedWidgetBuilder itemBuilder;

  ///加载更多回调
  final RefreshCallback? onLoadMore;

  ///下拉刷新回调
  final RefreshCallback? onRefresh;

  final ScrollController? scrollController;

  ///控制器，比如数据和一些配置
  final PullLoadWidgetControl control;

  ///刷新key
  final Key? refreshKey;

  PullLoadWidget(
      {Key? key,
      required this.itemBuilder,
      required this.control,
      this.onLoadMore,
      this.onRefresh,
      this.scrollController,
      this.refreshKey})
      : super(key: key);

  @override
  _PullLoadWidgetState createState() => _PullLoadWidgetState();
}

class _PullLoadWidgetState extends State<PullLoadWidget>
    with FlarePullController {
  bool isRefreshing = false;

  bool isLoadMoring = false;

  ScrollController? _scrollController;

  @override
  ValueNotifier<bool> isActive = ValueNotifier<bool>(true);

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();

    ///增加滑动监听
    _scrollController!.addListener(() {
      ///判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController!.position.pixels ==
          _scrollController!.position.maxScrollExtent) {
        if (widget.control.needLoadMore) {
          handleLoadMore();
        }
      }
    });

    widget.control.addListener(() {
      setState(() {});
      try {
        Future.delayed(const Duration(seconds: 2), () {
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          _scrollController!.notifyListeners();
        });
      } catch (e) {
        print(e);
      }
    });
    super.initState();
  }

  _lockToAwait() async {
    ///if loading, lock to await
    doDelayed() async {
      await Future.delayed(const Duration(seconds: 1)).then((_) async {
        if (widget.control.isLoading) {
          return await doDelayed();
        } else {
          return null;
        }
      });
    }

    await doDelayed();
  }

  @protected
  Future<void> handleRefresh() async {
    if (widget.control.isLoading) {
      if (isRefreshing) {
        return;
      }

      ///if loading, lock to await
      await _lockToAwait();
    }
    widget.control.isLoading = true;
    isRefreshing = true;
    await widget.onRefresh?.call();
    isRefreshing = false;
    widget.control.isLoading = false;
    return;
  }

  @protected
  Future<void> handleLoadMore() async {
    debugPrint("handleLoadMore");
    if (widget.control.isLoading) {
      if (isLoadMoring) {
        return;
      }

      ///if loading, lock to await
      await _lockToAwait();
    }
    isLoadMoring = true;
    widget.control.isLoading = true;
    await widget.onLoadMore?.call();
    isLoadMoring = false;
    widget.control.isLoading = false;
    return;
  }

  ///根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    if (widget.control.dataList.isEmpty) {
      ///如果数据为0，渲染空页面
      return _buildEmpty();
    }
    if (widget.control.needLoadMore &&
        index == widget.control.dataList.length) {
      return _buildProgressIndicator();
    }

    ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
    return widget.itemBuilder(context, index);
  }

  ///空页面
  Widget _buildEmpty() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Image(
                image: AssetImage("assets/images/empty.jpg"),
                width: 200.0,
                height: 200.0),
          ),
          const Text("目前什么都没有", style: CWConstant.normalText),
        ],
      ),
    );
  }

  ///根据配置状态返回实际列表数量
  ///实际上这里可以根据你的需要做更多的处理
  ///比如多个头部，是否需要空页面，是否需要显示加载更多。
  _getListCount() {
    // ///是否需要头部
    // if (widget.control.needHeader) {
    //   ///如果需要头部，用Item 0 的 Widget 作为ListView的头部
    //   ///列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
    //   return (widget.control.dataList!.isNotEmpty)
    //       ? widget.control.dataList!.length + 2
    //       : widget.control.dataList!.length + 1;
    // } else {
    //   ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
    //   if (widget.control.dataList!.isEmpty) {
    //     return 1;
    //   }

    //   ///如果有数据,因为部加载更多选项，需要对列表数据总数+1
    //   return (widget.control.dataList!.isNotEmpty)
    //       ? widget.control.dataList!.length + 1
    //       : widget.control.dataList!.length;
    // }
    ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
    if (widget.control.dataList.isEmpty && widget.control.needEmpty) {
      return 1;
    } else if (widget.control.dataList.isNotEmpty &&
        widget.control.needLoadMore) {
      ///如果有数据且需要加载更多选项，需要对列表数据总数+1
      return widget.control.dataList.length + 1;
    }
    return widget.control.dataList.length;
  }

  ///上拉加载更多
  Widget _buildProgressIndicator() {
    ///是否需要显示上拉加载更多的loading
    Widget bottomWidget = (widget.control.needLoadMore)
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ///loading框
            SpinKitRotatingCircle(color: Theme.of(context).primaryColor),
            Container(
              width: 5.0,
            ),

            ///加载中文本
            const Text(
              "加载更多...",
              style: TextStyle(
                color: Color(0xFF121917),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ])

        /// 不需要加载
        : Container();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: bottomWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      ///GlobalKey，用户外部获取RefreshIndicator的State，做显示刷新
      key: widget.refreshKey,

      ///下拉刷新触发，返回的是一个Future
      onRefresh: handleRefresh,
      child: ListView.builder(
        ///保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
        physics: const AlwaysScrollableScrollPhysics(),

        ///根据状态返回子孔健
        itemBuilder: (context, index) {
          return _getItem(index);
        },

        ///根据状态返回数量
        itemCount: _getListCount(),

        ///滑动监听
        controller: _scrollController,
      ),
    );
  }

  bool playAuto = false;
  @override
  bool get getPlayAuto => playAuto;
}
