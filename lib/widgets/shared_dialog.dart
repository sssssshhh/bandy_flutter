import 'package:flutter/material.dart';

class SharedDialog {
  static Future<bool> showAlertDialog(
    BuildContext context,
    String title,
    String content, {
    void Function()? onYes,
    void Function()? onNo,
  }) async {
    return (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              content: Text(
                content,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF808080),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (onNo != null) {
                      onNo.call();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0F0F0),
                    foregroundColor: const Color(0xFF808080),
                    minimumSize: const Size(120, 50),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (onYes != null) {
                      onYes.call();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2BC40),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(120, 50),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('Yes'),
                ),
              ],
              actionsAlignment: MainAxisAlignment.spaceBetween,
            );
          },
        )) ??
        false;
  }
}
