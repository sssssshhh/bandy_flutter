import 'package:bandy_flutter/bandy_routes.dart';
import 'package:bandy_flutter/firebase_options.dart';
import 'package:bandy_flutter/pages/splash_page.dart';
import 'package:bandy_flutter/route_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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

  static RouterObserver routerObserver = RouterObserver();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BANDY',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white, // bgColor for all pages
          splashColor: Colors.transparent,
          fontFamily: "Pretendard"),
      initialRoute: SplashPage.routeName,
      onGenerateRoute: BandyRoutes.onGenerateRoute,
      onUnknownRoute: BandyRoutes.onUnknownRoute,
      navigatorObservers: [
        routerObserver, // Global
        BandyRoutes.pageRouteObserver, // Page
      ],
    );
  }
}
