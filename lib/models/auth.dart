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

class AuthResponse {
  int code;
  String message;
  Map<String, String>? data;
  AuthResponse(this.code, this.message, this.data);
}

class User {
  late String nickname;
  late int id;
  String? avatar;

  User(this.nickname, this.id, this.avatar);

  User.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    id = json['id'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickname'] = nickname;
    data['id'] = id;
    data['avatar'] = avatar;
    return data;
  }

  @override
  String toString() {
    return 'User: {nickname: $nickname, id: $id, avatar: $avatar}';
  }
}
