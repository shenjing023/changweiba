import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth.g.dart';

enum AuthMode {
  signup,
  signin,
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthMode build() => AuthMode.signin;

  switchAuth() {
    state = state == AuthMode.signin ? AuthMode.signup : AuthMode.signin;
  }
}
