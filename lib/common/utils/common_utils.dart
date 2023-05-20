/// fork from https://github.com/CarGuo/gsy_github_app_flutter.git

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
}
