import 'package:changweiba/api/auth.dart';
import 'package:changweiba/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/router_report.dart';
import 'package:get_it/get_it.dart';

import 'api/base.dart';
import 'api/graphql.dart';
import 'common/style/style.dart';
import 'common/utils/common_utils.dart';
import 'models/auth.dart';
import 'utils/shared_preferences.dart';

// debug cmd
// flutter run -d chrome --web-hostname localhost --web-port 5050
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);

  runApp(const MyApp());
}

void initNetwork() {
  const String uri = "http://172.20.211.254:8020/graphql";

  GetIt.I.registerLazySingleton<GQLClient>(() => GQLClient(uri: uri));
}

Future initialization(BuildContext? context) async {
  await Storage().init();
  String? rToken = Storage().prefs.getString("refreshToken");
  String accessToken = "";
  initNetwork();
  if (rToken != null) {
    var response = await refreshAuthToken(rToken);
    if (response!.code == 200) {
      Storage().prefs.setString("accessToken", response.data!["accessToken"]!);
      Storage()
          .prefs
          .setString("refreshToken", response.data!["refreshToken"]!);
      Storage().prefs.setBool("isAuthenticated", true);
      accessToken = response.data!["accessToken"]!;

      // set graphql client header
      var gqlClient = GetIt.I.get<GQLClient>();
      gqlClient.setHeader("auth", accessToken);
    } else {
      Storage().prefs.setBool("isAuthenticated", false);
    }
  } else {
    Storage().prefs.setBool("isAuthenticated", false);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = Storage().prefs.getBool("isAuthenticated") ?? false;
    // put authController here
    Get.lazyPut(() => AuthController());
    return ScreenUtilInit(
        designSize: const Size(750, 1334),
        builder: (context, child) => GetMaterialApp(
              title: '肠胃吧',
              debugShowCheckedModeBanner: false,
              theme: CommonUtils.getThemeData(CWColors.primarySwatch),
              // theme: ThemeData(
              //   // This is the theme of your application.
              //   //
              //   // Try running your application with "flutter run". You'll see the
              //   // application has a blue toolbar. Then, without quitting the app, try
              //   // changing the primarySwatch below to Colors.green and then invoke
              //   // "hot reload" (press "r" in the console where you ran "flutter run",
              //   // or simply save your changes to "hot reload" in a Flutter IDE).
              //   // Notice that the counter didn't reset back to zero; the application
              //   // is not restarted.
              //   primarySwatch: Colors.green,
              // ),
              initialRoute: isAuthenticated ? Routes.home : Routes.login,
              getPages: AppPages.routes,
              builder: FlutterSmartDialog.init(),
              navigatorObservers: [
                FlutterSmartDialog.observer,
                GetXRouterObserver()
              ],
            ));
  }
}

class GetXRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouterReportManager.reportCurrentRoute(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    RouterReportManager.reportRouteDispose(route);
  }
}
