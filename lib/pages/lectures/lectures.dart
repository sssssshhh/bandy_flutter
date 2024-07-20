import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Leuctures extends StatefulWidget {
  const Leuctures({super.key});

  @override
  State<Leuctures> createState() => _LeucturesState();
}

class _LeucturesState extends State<Leuctures> {
  int _selectedIndex = 0;

  final screens = [
    const Center(
      child: Text("home"),
    ),
    const Center(
      child: Text("search"),
    )
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[_selectedIndex],
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
              label: "serach",
            )
          ],
        ));
  }
}
