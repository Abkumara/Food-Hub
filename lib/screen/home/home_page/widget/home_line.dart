import 'package:flutter/material.dart';

class HomeLine extends StatelessWidget {
  const HomeLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF8F8B8B),
            Color(0x00999999),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
