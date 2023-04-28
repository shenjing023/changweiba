import 'package:get/get.dart';

import 'views/home/home.dart';
import 'views/login/login.dart';

abstract class Routes {
  static const home = '/';
  static const login = '/login';
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
  ];
}
