import 'package:azure_speech_assessment/azure_speech_assessment.dart';
import 'package:bandy_flutter/firebase_options.dart';
import 'package:bandy_flutter/pages/making/azure_speech_assessment.dart';
import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
import 'package:bandy_flutter/pages/onBoarding/onBoarding.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/pages/making/ai_test.dart';
import 'package:bandy_flutter/pages/lectures/lecture.dart';
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
      title: 'Bandy',
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

//  theme: ThemeData(
//           scaffoldBackgroundColor: Colors.white, // bgColor for all pages
//           colorScheme: ColorScheme.fromSwatch(
//             backgroundColor: Colors.white,
//           ),
//           primaryColor: Colors.amber[500], // TODO: check RGB from pigma
//         ),
//         home: const MainNavigation());