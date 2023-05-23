/// fork from https://github.com/CarGuo/gsy_github_app_flutter.git

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CommonUtils {
  static getThemeData(Color color) {
    return ThemeData(
      primarySwatch: color as MaterialColor?,
      // colorScheme: const ColorScheme.light().copyWith(primary: color)
      // platform: TargetPlatform.android,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarContrastEnforced: true,
          systemStatusBarContrastEnforced: true,
          systemNavigationBarColor: color,
          statusBarColor: color,
          systemNavigationBarDividerColor: color.withAlpha(199),
        ),
      ),
      // 如果需要去除对应的水波纹效果
      // splashFactory: NoSplash.splashFactory,
      // textButtonTheme: TextButtonThemeData(
      //   style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      // ),
    );
  }

  ///判断当前时间是否在9:30-15:00之间
  static bool isBetweenNineThirtyAndFifteen() {
    var now = DateTime.now();
    var startTime = DateFormat('HH:mm').parse('09:30');
    var endTime = DateFormat('HH:mm').parse('15:00');

    return now.isAfter(startTime) && now.isBefore(endTime);
  }
}
