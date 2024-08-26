import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:bandy_flutter/pages/lectures/lectures.dart';
import 'package:bandy_flutter/pages/lectures/pronucation_assessment2.dart';
import 'package:bandy_flutter/pages/lectures/puzzle.dart';
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

  final screens = [Lectures(key: GlobalKey()), Lecture(key: GlobalKey())];

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
            child: const Puzzle(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.searchengin),
            label: "search",
          )
        ],
      ),
    );
  }
}
