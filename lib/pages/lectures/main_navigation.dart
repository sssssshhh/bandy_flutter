import 'package:bandy_flutter/pages/lectures/lectures.dart';
import 'package:bandy_flutter/pages/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  static String routeName = "mainNavigation";
  static String routeURL = "/mainNavigation";

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
            child: const Settings(),
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
