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
    nickname = json['name'];
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
