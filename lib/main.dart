import 'package:bandy_flutter/firebase_options.dart';
import 'package:bandy_flutter/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'BANDY',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // bgColor for all pages
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.white,
        ),
        splashColor: Colors.transparent,
      ),
    );
  }
}
