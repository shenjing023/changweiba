import 'package:changweiba/api/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../api/http.dart';
import '../../model/auth.dart';
import '../../state/auth.dart';
import '../../util/shared_preferences.dart';
import 'login_form.dart';

class LoginPage extends ConsumerStatefulWidget {
  final VoidCallback? onLoginSuccess; // 添加回调参数

  const LoginPage({Key? key, this.onLoginSuccess}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController userFormController;
  late TextEditingController passwordFormController;

  @override
  void initState() {
    super.initState();
    String? user = Storage().prefs.getString("username");
    String? password = Storage().prefs.getString("password");
    userFormController = TextEditingController(text: user ?? "user1");
    passwordFormController = TextEditingController(text: password ?? "user1");
  }

  void saveAccountData(String username, String password, String accessToken,
      String refreshToken) async {
    Storage().prefs.setString("username", username);
    Storage().prefs.setString("password", password);
    Storage().prefs.setString("accessToken", accessToken);
    Storage().prefs.setString("refreshToken", refreshToken);
  }

  Future<dynamic> onRequest() async {
    Future<AuthResponse?> Function(String, String) func;
    if (ref.watch(authProvider) == AuthMode.signin) {
      func = signIn;
    } else {
      func = signUp;
    }

    // httpTest();

    SmartDialog.showLoading();
    try {
      var response =
          await func(userFormController.text, passwordFormController.text);
      SmartDialog.dismiss();
      if (response!.code == 200) {
        debugPrint(response.data.toString());
        saveAccountData(userFormController.text, passwordFormController.text,
            response.data!["accessToken"]!, response.data!["refreshToken"]!);
        // 调用回调以关闭弹窗
        if (widget.onLoginSuccess != null) {
          widget.onLoginSuccess!();
        }
      } else {
        SmartDialog.showToast(response.message);
      }
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
                child: LoginForm(
              key: widget.key,
              userController: userFormController,
              passwordController: passwordFormController,
              onRequest: onRequest,
            )),
          ),
        );
      },
    );
  }
}
