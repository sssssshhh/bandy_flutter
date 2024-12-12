import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const ActionButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => onPressed?.call(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2BC40),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(120, 56),
                  shadowColor: Colors.transparent,
                ),
                child: Text(text, style: const TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
