import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/listen_speak.dart';
import 'package:flutter/material.dart';

class Completed extends StatefulWidget {
  final List<Map<String, dynamic>> expressionList;
  final int lessonNo;

  const Completed(
      {super.key, required this.expressionList, required this.lessonNo});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ListenSpeak(
                  expressionList: widget.expressionList,
                  lessonNo: widget.lessonNo,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.orange,
              size: 48,
            ),
            Gaps.v16,
            Text(
              "Completed",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
