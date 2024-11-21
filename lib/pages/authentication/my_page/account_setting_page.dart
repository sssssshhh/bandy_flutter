import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountSettingPage extends StatefulWidget {
  static const routeName = "/account-setting";

  const AccountSettingPage({super.key});

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  String email = '';
  String nickname = '';

  @override
  void initState() {
    super.initState();

    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.email != null) {
      setState(() {
        email = user?.email ?? '';
      });

      final dbs = await FirebaseFirestore.instance.collection('users').doc(user?.email).get();
      if (dbs.exists && dbs.data() != null) {
        setState(() {
          nickname = dbs.data()?['nickname'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Setting',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A))),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenu(index: 0, title: 'Email', value: email),
            const SizedBox(height: 30),
            _buildMenu(index: 1, title: 'Nickname', value: nickname),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu({required int index, required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Color(0xFF808080))),
        const SizedBox(height: 25),
        Text(value, style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 15),
        const Divider(height: 1, color: Color(0xFFEAEAEA)),
      ],
    );
  }
}
