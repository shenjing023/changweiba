import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/auth.dart';
import 'animated_text.dart';

class LoginForm extends ConsumerStatefulWidget {
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

class _LoginFormState extends ConsumerState<LoginForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
                side: const BorderSide(color: Colors.black, width: 2)),
            child: SizedBox(
              width: 500,
              height: 350,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 20, left: 30, right: 30),
                    child: UserField(controller: widget.userController),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 20, left: 30, right: 30),
                    child: PasswordField(
                      controller: widget.passwordController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 50,
                      width: 150,
                      child: TextButton(
                        style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ))),
                            foregroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              return states.contains(WidgetState.pressed)
                                  ? const Color.fromARGB(255, 108, 118, 126)
                                  : Colors.red;
                            }),
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.all(
                              Colors.transparent,
                            )),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            widget.onRequest!();
                          }
                        },
                        child: AnimatedText(
                          text: ref.watch(authProvider) == AuthMode.signin
                              ? 'SignIn'
                              : 'SignUp',
                          textRotation: AnimatedTextRotation.up,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        // side: MaterialStateProperty.all(const BorderSide(
                        //     width: 2, color: Color.fromARGB(222, 222, 222, 22))),
                        // padding: const MaterialStateProperty.symmetric(
                        //     horizontal: 30.0, vertical: 8.0),
                        foregroundColor:
                            WidgetStateProperty.resolveWith((states) {
                      return states.contains(WidgetState.pressed)
                          ? Colors.blue
                          : Colors.red;
                    })),
                    onPressed: () =>
                        ref.read(authProvider.notifier).switchAuth(),
                    child: AnimatedText(
                      text: ref.watch(authProvider) == AuthMode.signin
                          ? 'SignUp'
                          : 'SignIn',
                      textRotation: AnimatedTextRotation.up,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 10),
          //   child: SizedBox(
          //     height: 50,
          //     width: 150,
          //     child: TextButton(
          //       style: ButtonStyle(
          //           shape: WidgetStateProperty.all(RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(5),
          //               side: const BorderSide(
          //                 width: 2,
          //                 color: Colors.black,
          //               ))),
          //           foregroundColor:
          //               WidgetStateProperty.resolveWith((states) {
          //             return states.contains(WidgetState.pressed)
          //                 ? const Color.fromARGB(255, 108, 118, 126)
          //                 : Colors.red;
          //           }),
          //           elevation: WidgetStateProperty.all(0),
          //           backgroundColor: WidgetStateProperty.all(
          //             Colors.transparent,
          //           )),
          //       onPressed: () {
          //         if (formKey.currentState!.validate()) {
          //           widget.onRequest!();
          //         }
          //       },
          //       child: AnimatedText(
          //         text: ref.watch(authProvider) == AuthMode.signin
          //             ? 'SignIn'
          //             : 'SignUp',
          //         textRotation: AnimatedTextRotation.up,
          //         style: const TextStyle(
          //           color: Colors.black,
          //           fontSize: 30,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // TextButton(
          //   style: ButtonStyle(
          //       // side: MaterialStateProperty.all(const BorderSide(
          //       //     width: 2, color: Color.fromARGB(222, 222, 222, 22))),
          //       // padding: const MaterialStateProperty.symmetric(
          //       //     horizontal: 30.0, vertical: 8.0),
          //       foregroundColor: WidgetStateProperty.resolveWith((states) {
          //     return states.contains(WidgetState.pressed)
          //         ? Colors.blue
          //         : Colors.red;
          //   })),
          //   onPressed: () => ref.read(authProvider.notifier).switchAuth(),
          //   child: AnimatedText(
          //     text: ref.watch(authProvider) == AuthMode.signin
          //         ? 'SignUp'
          //         : 'SignIn',
          //     textRotation: AnimatedTextRotation.up,
          //     style: const TextStyle(
          //       color: Colors.black,
          //       fontSize: 25,
          //     ),
          //   ),
          // )
        ],
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
        if (value!.isEmpty) {
          return 'Password must be at least 1 characters long';
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
