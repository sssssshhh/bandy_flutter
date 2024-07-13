import 'package:bandy_flutter/widgets/button.dart';
import 'package:bandy_flutter/widgets/circles.dart';
import 'package:bandy_flutter/widgets/currentCircle.dart';
import 'package:bandy_flutter/widgets/smallButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 46,
                  ),
                  SizedBox(
                    width: 50,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CurrentCircle(),
                          Circle(),
                          Circle(),
                        ]),
                  ),
                  SmallButton(text: 'skip'),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 200,
                    horizontal: 140,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Develop your reading skills',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Korean stories narrated by an actor',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w100,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              const Button(
                  bgColor: Colors.orange, // TODO: Colors.orange[200]
                  textColor: Colors.white,
                  text: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
