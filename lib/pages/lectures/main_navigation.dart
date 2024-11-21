import 'package:bandy_flutter/pages/authentication/my_page/my_page.dart';
import 'package:bandy_flutter/pages/lectures/lectures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigation extends StatefulWidget {
  static const routeName = "/mainNavigation";

  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex == 0,
            child: const MyPage(),
          ),
          Offstage(
            offstage: _selectedIndex == 1,
            child: const Lectures(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _onTap(0),
                    icon: const FaIcon(FontAwesomeIcons.house),
                    tooltip: "Home",
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _onTap(1),
                    icon: const FaIcon(FontAwesomeIcons.gear),
                    tooltip: "Setting",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
