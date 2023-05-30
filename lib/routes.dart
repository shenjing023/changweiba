import 'package:changweiba/views/post/post_new.dart';
import 'package:get/get.dart';

// import 'views/home/home.dart';
import 'views/login/login.dart';
import 'views/chart/chart.dart';
import 'views/home/home.dart';
import 'views/post/post_detail.dart';
import 'views/search/search.dart';

abstract class Routes {
  static const home = '/';
  static const login = '/login';
  static const chart = '/chart';
  static const search = '/search';
  static const newPost = '/newPost';
  static const postDetail = '/postDetail';
}

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.home,
        page: () => HomePage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.chart,
      page: () => ChartPage(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
    ),
    GetPage(
      name: Routes.newPost,
      page: () => const NewPostPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
    ),
    GetPage(
      name: Routes.postDetail,
      page: () => PostDetail(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
    ),
  ];
}
