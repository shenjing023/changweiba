import 'package:changweiba/api/auth.dart';
import 'package:changweiba/views/login/background.dart';
import 'package:changweiba/views/login/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../models/auth.dart';
import '../../routes.dart';
import '../../utils/shared_preferences.dart';
import 'login_form.dart';
import 'login_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final controller = ScrollController();

  /// signUpUserFromController
  late TextEditingController userFormController;

  /// signUpPasswordFromController
  late TextEditingController passwordFormController;

  final AuthController c = Get.find();

  @override
  void initState() {
    super.initState();
    String? user = Storage().prefs.getString("username");
    String? password = Storage().prefs.getString("password");
    userFormController =
        TextEditingController.fromValue(TextEditingValue(text: user ?? ""));
    passwordFormController =
        TextEditingController.fromValue(TextEditingValue(text: password ?? ""));
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
    if (c.mode.value == AuthMode.signin) {
      func = signIn;
    } else {
      func = signUp;
    }

    SmartDialog.showLoading();
    try {
      var response =
          await func(userFormController.text, passwordFormController.text);
      SmartDialog.dismiss();
      if (response!.code == 200) {
        // print
        debugPrint(response.data.toString());
        saveAccountData(userFormController.text, passwordFormController.text,
            response.data!["accessToken"]!, response.data!["refreshToken"]!);
        Get.offNamed(Routes.home);
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
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: buildMobileScreen(context),
          desktop: buildDespktopScreen(context),
        ),
      ),
    );
  }

  Widget buildMobileScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const TopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(
                userController: userFormController,
                passwordController: passwordFormController,
                onRequest: onRequest,
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget buildDespktopScreen(BuildContext context) {
    return Row(children: [
      const Expanded(child: TopImage()),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 450,
            child: LoginForm(
              userController: userFormController,
              passwordController: passwordFormController,
              onRequest: onRequest,
            ),
          )
        ],
      )),
    ]);
  }
}
