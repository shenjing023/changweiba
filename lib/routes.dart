import 'package:get/get.dart';

// import 'views/home/home.dart';
import 'views/login/login.dart';
import 'views/chart/k_chart.dart';
import 'views/home/home.dart';
import 'views/search/search.dart';

abstract class Routes {
  static const home = '/';
  static const login = '/login';
  static const chart = '/chart';
  static const search = '/search';
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
      page: () => const KChartPage(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 100),
    ),
  ];
}
