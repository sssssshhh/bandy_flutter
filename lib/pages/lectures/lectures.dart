import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/cloudFrontPath.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:bandy_flutter/widgets/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Lectures extends StatefulWidget {
  const Lectures({super.key});

  @override
  State<Lectures> createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<Map<String, dynamic>?> findDB() async {
  //   final doc = await _db
  //       .collection('lectures')
  //       .doc('Confused_Korean')
  //       .collection('main')
  //       .doc('1')
  //       .get();
  //   print(doc.data());
  //   return doc.data();
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Recommendation(),
      ),
    );
  }
}
