import 'package:changweiba/page/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class SideNavigationItem {
  final String title;
  final IconData icon;

  SideNavigationItem({required this.title, required this.icon});
}

class SideNavigation extends StatefulWidget {
  const SideNavigation({
    Key? key,
    required this.items,
    required this.onItemSelected,
    this.initialSelectedIndex = 0,
  }) : super(key: key);

  final List<SideNavigationItem> items;
  final void Function(int index) onItemSelected;
  final int initialSelectedIndex;

  @override
  _SideNavigationState createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.only(top: 20),
      color: Colors.grey[100],
      child: ListView(
        children: [
          _buildHeadImage(),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "消灭权限暴政\n世界属于肠胃",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          _buildItems(),
        ],
      ),
    );
  }

  void _showLoginDialog() {
    SmartDialog.show(
      builder: (_) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  maxHeight: constraints.maxHeight * 0.4,
                ),
                child: LoginPage(
                  onLoginSuccess: () {
                    SmartDialog.dismiss(); // 关闭弹窗
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildItems() {
    var activeColor = Colors.blue;
    var normalColor = Colors.black;
    return Column(
      children: List.generate(widget.items.length, (index) {
        var item = widget.items[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () => _onItemTapped(index),
            child: Container(
              height: 35,
              padding: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: _selectedIndex == index
                    ? activeColor.withOpacity(0.1)
                    : null,
              ),
              alignment: Alignment.center,
              child: Wrap(children: [
                Icon(
                  item.icon,
                  color: _selectedIndex == index ? activeColor : normalColor,
                  size: 15,
                ),
                const SizedBox(width: 8),
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 13,
                    color: _selectedIndex == index ? activeColor : normalColor,
                  ),
                ),
              ]),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeadImage() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            print("图片被点击了");
            _showLoginDialog();
          },
          child: Container(
            width: 75,
            height: 75,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 0.2,
                )
              ],
              image: const DecorationImage(
                image: AssetImage("assets/images/default.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
