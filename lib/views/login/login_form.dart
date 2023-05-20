import 'package:changweiba/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'animated_text.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController? userController;
  final TextEditingController? passwordController;
  Future<void> Function()? onRequest;
  LoginForm({
    Key? key,
    this.userController,
    this.passwordController,
    required this.onRequest,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final AuthController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  side: const BorderSide(color: Colors.black, width: 2)),
              child: SizedBox(
                width: 500.w,
                height: 330.h,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 30.h, bottom: 20.h, left: 30.w, right: 30.w),
                      child: UserField(controller: widget.userController),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0, bottom: 20.h, left: 30.w, right: 30.w),
                      child: PasswordField(
                        controller: widget.passwordController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.h),
              child: SizedBox(
                height: 80.h,
                width: 300.w,
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.black,
                          ))),
                      foregroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        return states.contains(MaterialState.pressed)
                            ? const Color.fromARGB(255, 108, 118, 126)
                            : Colors.red;
                      }),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent,
                      )),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onRequest!();
                    }
                  },
                  child: GetBuilder<AuthController>(
                    init: c,
                    builder: (_) => AnimatedText(
                      text:
                          c.mode.value == AuthMode.signin ? 'SignIn' : 'SignUp',
                      textRotation: AnimatedTextRotation.up,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextButton(
              style: ButtonStyle(
                  // side: MaterialStateProperty.all(const BorderSide(
                  //     width: 2, color: Color.fromARGB(222, 222, 222, 22))),
                  // padding: const MaterialStateProperty.symmetric(
                  //     horizontal: 30.0, vertical: 8.0),
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.pressed)
                    ? Colors.blue
                    : Colors.red;
              })),
              onPressed: () => c.switchAuth(),
              child: GetBuilder<AuthController>(
                init: c,
                builder: (_) => AnimatedText(
                  text: c.mode.value == AuthMode.signin ? 'SignUp' : 'SignIn',
                  textRotation: AnimatedTextRotation.up,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  FormFieldSetter<String>? onSaved;
  ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;

  PasswordField(
      {Key? key, this.onSaved, this.onFieldSubmitted, this.controller})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: '密码',
        contentPadding: const EdgeInsets.only(top: 7),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      validator: (value) {
        if (value!.length < 7) {
          return 'Password must be at least 7 characters long';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}

// ignore: must_be_immutable
class UserField extends StatefulWidget {
  FormFieldSetter<String>? onSaved;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  UserField(
      {Key? key,
      this.onSaved,
      this.onFieldSubmitted,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  _UserFieldState createState() => _UserFieldState();
}

class _UserFieldState extends State<UserField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(
        labelText: "用户名",
        contentPadding: EdgeInsets.zero,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      validator: (value) {
        if (value!.length < 4) {
          return 'Enter at least 4 characters';
        } else {
          return null;
        }
      },
      maxLength: 20,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
