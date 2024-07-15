import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, // bgColor for all pages
          colorScheme: ColorScheme.fromSwatch(
            backgroundColor: Colors.white,
          ),
          primaryColor: Colors.amber[500], // TODO: check RGB from pigma
        ),
        home: const Lecture());
  }
}
