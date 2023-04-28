import 'dart:io';

import 'package:changweiba/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

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

  bool _isLoading = false;

  String label1 = "SignIn";

  test2() async {
    if (c.mode.value == AuthMode.signin) {
      print("signin");
      _isLoading = true;
      SmartDialog.showLoading();
      await Future.delayed(const Duration(seconds: 2));
      SmartDialog.dismiss();
      // label1 = "SignIn...";
      // c.loadingLabel.value = "SignIn...";
      await Future.delayed(Duration(seconds: 10));
      _isLoading = false;
      // c.loadingLabel.value = "SignIn";
    } else {
      print("signup");
      // c.loadingLabel.value = "SignUp...";
      _isLoading = true;
      await Future.delayed(Duration(seconds: 10));
      _isLoading = false;
      // c.loadingLabel.value = "SignUp";
    }
  }

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
                  onPressed: test2,
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
                // child: ButtonTheme(
                //     height: 80.h,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(3),
                //         side: const BorderSide(
                //           width: 5,
                //           color: Color.fromARGB(0, 27, 27, 26),
                //         )),
                //     child: TextButton(
                //       style: ButtonStyle(
                //           shape: MaterialStateProperty.all(
                //               RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(3),
                //                   side: const BorderSide(
                //                     width: 5,
                //                     color: Color.fromARGB(0, 27, 27, 26),
                //                   ))),
                //           foregroundColor:
                //               MaterialStateProperty.resolveWith((states) {
                //             return states.contains(MaterialState.pressed)
                //                 ? const Color.fromARGB(255, 108, 118, 126)
                //                 : Colors.red;
                //           }),
                //           elevation: MaterialStateProperty.all(0),
                //           backgroundColor: MaterialStateProperty.all(
                //             Colors.transparent,
                //           )),
                //       onPressed: !_isLoading ? () => c.switchAuth() : null,
                //       child: GetBuilder<AuthController>(
                //         init: c,
                //         builder: (_) => AnimatedText(
                //           text: c.mode.value == AuthMode.signin
                //               ? 'SignIn'
                //               : 'SignUp',
                //           textRotation: AnimatedTextRotation.up,
                //           style: TextStyle(
                //             color: !_isLoading ? Colors.black : Colors.grey,
                //             fontSize: 30,
                //           ),
                //         ),
                //       ),
                //     )
                //   )
              ),
            ),
            // child: ElevatedButton(
            //   style: ButtonStyle(
            //       padding: MaterialStateProperty.all(
            //           const EdgeInsets.fromLTRB(25, 15, 25, 15)),
            //       side: MaterialStateProperty.all(const BorderSide(
            //           width: 2, color: Color.fromARGB(222, 222, 222, 22))),
            //       // padding: const MaterialStateProperty.symmetric(
            //       //     horizontal: 30.0, vertical: 8.0),
            //       foregroundColor:
            //           MaterialStateProperty.resolveWith((states) {
            //         return states.contains(MaterialState.pressed)
            //             ? Colors.blue
            //             : Colors.red;
            //       })),
            //   onPressed: !_isLoading ? () => c.switchAuth() : null,
            //   child: GetBuilder<AuthController>(
            //     init: c,
            //     builder: (_) => AnimatedText(
            //       text: c.mode.value == AuthMode.signin ? 'SignIn' : 'SignUp',
            //       textRotation: AnimatedTextRotation.up,
            //       style: TextStyle(
            //         color: !_isLoading ? Colors.black : Colors.grey,
            //         fontSize: 30,
            //       ),
            //     ),
            //   ),
            // ),
            // child: ArgonButton(
            //     height: 80.h,
            //     width: 300.w,
            //     // minWidth: 180.w,
            //     borderSide: BorderSide(
            //         color: Color.fromARGB(255, 110, 65, 65), width: 5),
            //     borderRadius: 3,
            //     roundLoadingShape: true,
            //     color: Colors.transparent,
            //     elevation: 0,
            //     loader: const SpinKitFadingCircle(
            //       color: Colors.black,
            //     ),
            //     onTap: (startLoading, stopLoading, btnState) async {
            //       final isValid = formKey.currentState!.validate();
            //       if (isValid) {
            //         setState(() {
            //           _isLoading = true;
            //         });
            //         if (btnState == ButtonState.Idle) {
            //           startLoading();
            //           // await widget.onRequest!();
            //           // stopLoading();
            //         }
            //         setState(() {
            //           _isLoading = false;
            //         });
            //       }
            //     },
            //     child: GetBuilder<AuthController>(
            //       init: c,
            //       builder: (_) => AnimatedText(
            //         text:
            //             c.mode.value == AuthMode.signin ? 'SignIn' : 'SignUp',
            //         textRotation: AnimatedTextRotation.down,
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 25,
            //         ),
            //       ),
            //     )),
            // ),
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
