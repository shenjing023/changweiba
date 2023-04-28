import 'package:get/get.dart';

enum AuthMode {
  signup,
  signin,
}

class AuthController extends GetxController {
  var mode = AuthMode.signin.obs;
  switchAuth() {
    mode.value =
        mode.value == AuthMode.signin ? AuthMode.signup : AuthMode.signin;
    update();
  }
}
