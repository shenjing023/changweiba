import 'package:get/get.dart';

// import 'views/home/home.dart';
import 'views/login/login.dart';
import 'views/chart/k_chart.dart';
import 'views/home/home2.dart';

abstract class Routes {
  static const home = '/';
  static const login = '/login';
  static const chart = '/chart';
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
  ];
}
