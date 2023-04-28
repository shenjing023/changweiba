import 'package:changweiba/api/auth.dart';
import 'package:changweiba/views/login/background.dart';
import 'package:changweiba/views/login/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
  final signUpUFController = TextEditingController();

  /// signUpPasswordFromController
  final signUpPFController = TextEditingController();

  /// signInUserFromController
  final signInUFController = TextEditingController();

  /// signInPasswordFromController
  final signInPFController = TextEditingController();

  Future<void> _onSignUpPressed() async {
    try {
      signUp(signUpUFController.text, signUpPFController.text);
      Get.offNamed("/");
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onSignInPressed() async {
    // final isValid = signInFormKey.currentState!.validate();
    // if (isValid) {
    if (signInUFController.text.length == 5) {
      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 151, 117, 114),
          textColor: Colors.white,
          fontSize: 16.0);
    }
    // }
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
                userController: signUpUFController,
                passwordController: signUpPFController,
                onRequest: _onSignUpPressed,
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
              userController: signUpUFController,
              passwordController: signUpPFController,
              onRequest: _onSignUpPressed,
            ),
          )
        ],
      )),
    ]);
  }
}
