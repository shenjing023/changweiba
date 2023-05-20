import 'package:flutter/material.dart';

import '../../common/style/style.dart';
import '../../utils/shared_preferences.dart';
import '../../widget/flex_button.dart';

class HomeDrawer extends StatelessWidget {
  // showAboutDialog(BuildContext context, String? versionName) {
  //   versionName ??= "Null";
  //   NavigatorUtils.showGSYDialog(
  //       context: context,
  //       builder: (BuildContext context) => AboutDialog(
  //             applicationName: GSYLocalizations.i18n(context)!.app_name,
  //             applicationVersion: GSYLocalizations.i18n(context)!.app_version +
  //                 ": " +
  //                 (versionName ?? ""),
  //             applicationIcon: new Image(
  //                 image: new AssetImage(GSYICons.DEFAULT_USER_ICON),
  //                 width: 50.0,
  //                 height: 50.0),
  //             applicationLegalese: "http://github.com/CarGuo",
  //           ));
  // }

  // showThemeDialog(BuildContext context, Store store) {
  //   StringList list = [
  //     GSYLocalizations.i18n(context)!.home_theme_default,
  //     GSYLocalizations.i18n(context)!.home_theme_1,
  //     GSYLocalizations.i18n(context)!.home_theme_2,
  //     GSYLocalizations.i18n(context)!.home_theme_3,
  //     GSYLocalizations.i18n(context)!.home_theme_4,
  //     GSYLocalizations.i18n(context)!.home_theme_5,
  //     GSYLocalizations.i18n(context)!.home_theme_6,
  //   ];
  //   CommonUtils.showCommitOptionDialog(context, list, (index) {
  //     CommonUtils.pushTheme(store, index);
  //     LocalStorage.save(Config.THEME_COLOR, index.toString());
  //   }, colorList: CommonUtils.getThemeListColor());
  // }
  final String userName = Storage().prefs.getString("username") ?? "";

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      ///侧边栏按钮Drawer
      child: Container(
        ///默认背景
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          ///item 背景
          child: Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Material(
              color: CWColors.white,
              child: Column(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    //Material内置控件
                    accountName: Text(
                      userName,
                      style: CWConstant.largeTextWhite,
                    ),
                    accountEmail: const Text(
                      "---",
                      style: CWConstant.normalTextLight,
                    ),
                    currentAccountPicture: GestureDetector(
                      //用户头像
                      onTap: () {},
                      child: const CircleAvatar(
                        //圆形图标控件
                        backgroundImage:
                            NetworkImage(GSYICons.DEFAULT_REMOTE_PIC),
                      ),
                    ),
                    decoration: BoxDecoration(
                      //用一个BoxDecoration装饰器提供背景图片
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ListTile(
                      title: const Text(
                        "更改主题",
                        style: CWConstant.normalText,
                      ),
                      onTap: () {}),
                  ListTile(
                      title: const Text(
                        "检查更新",
                        style: CWConstant.normalText,
                      ),
                      onTap: () {}),
                  ListTile(
                      title: const Text(
                        "关于",
                        style: CWConstant.normalText,
                      ),
                      onLongPress: () {},
                      onTap: () {}),
                  ListTile(
                      title: FlexButton(
                        text: "退出登录",
                        color: Colors.redAccent,
                        textColor: CWColors.textWhite,
                        onPress: () {},
                      ),
                      onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
