import 'package:bandy_flutter/pages/authentication/sign_in/sign_in_email.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/widgets/shared_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  static String routeName = "/settings";

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Future<void> _deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();

        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, SignUpOrSignIn.routeName, (route) => false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, SignUpOrSignIn.routeName, (route) => false);
  }

  void _confirmDeleteAccount() {
    SharedDialog.showAlertDialog(
      context,
      'Delete Account',
      'Are you sure you want to delete your account?',
      onYes: () => _deleteAccount(),
    );
  }

  void _confirmLogout() {
    SharedDialog.showAlertDialog(
      context,
      'Log out',
      'Do you really want to log out?',
      onYes: () => _logout(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text('My page',
              style:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A))),
        ),
        centerTitle: false,
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenu(index: 0, title: 'Account setting', iconAssetName: "account_setting"),
            _buildMenu(index: 1, title: 'My Level', iconAssetName: "my_level"),
            _buildMenu(
              index: 2,
              title: 'Log out',
              iconAssetName: "log_out",
              onTap: () => _confirmLogout(),
            ),
            _buildMenu(
              index: 3,
              title: 'Delete Account',
              iconAssetName: "delete_account",
              onTap: () => _confirmDeleteAccount(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(
      {required int index,
      required String title,
      required String iconAssetName,
      void Function()? onTap}) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontSize: 16, color: Color(0xFF444444))),
          leading: SvgPicture.asset('assets/svg/$iconAssetName.svg'),
          minTileHeight: 64,
          onTap: () => onTap?.call(),
        ),
        if (index < 3) const Divider(height: 1, color: Color(0xFFEAEAEA)),
      ],
    );
  }
}
