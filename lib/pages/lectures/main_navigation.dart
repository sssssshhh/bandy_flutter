import 'package:bandy_flutter/pages/lectures/lectures.dart';
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
            offstage: _selectedIndex != 0,
            child: const Lectures(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const Lectures(),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Center(
          heightFactor: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.house),
              Text("home"),
            ],
          ),
        ),
      ),
    );
  }
}
