import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  // Storage._();
  late SharedPreferences prefs;
  // static late Storage _instance;
  // static Storage getInstance() {
  //   if (_instance == null) {
  //     _instance = Storage._();
  //   }
  //   return _instance;
  // }

  Storage._internal();

  factory Storage() => _instance;

  static late final Storage _instance = Storage._internal();

  init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
