import 'package:get/get.dart';

class PullLoadWidgetControl extends GetxController {
  ///数据，对齐增减，不能替换
  var dataList = [].obs;

  // var get dataList => _dataList;

  // set dataList(List? value) {
  //   _dataList!.clear();
  //   if (value != null) {
  //     _dataList!.addAll(value);
  //   }
  // }

  addList(List? value) {
    if (value != null) {
      dataList.addAll(value);
      update();
    }
  }

  add(value) {
    if (value != null) {
      dataList.add(value);
      update();
    }
  }

  clear() {
    dataList.clear();
    update();
  }

  ///是否需要加载更多
  bool _needLoadMore = true;

  set needLoadMore(value) {
    _needLoadMore = value;
  }

  get needLoadMore => _needLoadMore;

  ///是否需要头部
  bool _needHeader = true;

  set needHeader(value) {
    _needHeader = value;
  }

  get needHeader => _needHeader;

  ///是否加载中
  bool isLoading = false;

  //是否需要空页面
  get needEmpty => _needEmpty;

  bool _needEmpty = true;

  set needEmpty(value) {
    _needEmpty = value;
  }
}
