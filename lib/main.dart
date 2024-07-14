import 'package:bandy_flutter/pages/authentication/sign_up/select_auth_or_self.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/pages/ai_test.dart';
import 'package:bandy_flutter/pages/onboarding.dart';
import 'package:bandy_flutter/widgets/Button.dart';
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
        home: const SelectSignUp());
  }
}
    // return const MaterialApp(
    //   home: Scaffold(
    //     backgroundColor: Color(0xFF181818),
    //     body: Padding(
    //       padding: EdgeInsets.symmetric(
    //         horizontal: 40,
    //       ),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           SizedBox(
    //             height: 100,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 children: [
    //                   Text(
    //                     'Hey, Sㅇㅇ',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 28,
    //                       fontWeight: FontWeight.w800,
    //                     ),
    //                   ),
    //                   Text(
    //                     'Welcome back',
    //                     style: TextStyle(
    //                       color: Color.fromRGBO(255, 255, 255, 0.8),
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //           SizedBox(
    //             height: 120,
    //           ),
    //           Text(
    //             "Total Balcne",
    //             style: TextStyle(fontSize: 22, color: Colors.amber),
    //           ),
    //           SizedBox(
    //             height: 50,
    //           ),
    //           Text(
    //             "Total Balcne",
    //             style: TextStyle(fontSize: 22, color: Colors.amber),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Row(
    //             children: [
    //               Button(
    //                 text: 'Transfer1',
    //                 bgColor: Color(0xFFF1B33B),
    //                 textColor: Colors.black,
    //               ),
    //               Button(
    //                 text: 'Transfer2',
    //                 bgColor: Color(0xFFF1B33B),
    //                 textColor: Colors.black,
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
//   }
// }
