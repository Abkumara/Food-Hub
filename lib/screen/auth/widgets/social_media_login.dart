import 'package:flutter/material.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {}, child: Image.asset('assets/images/gmail.png')),
            const SizedBox(
              width: 28,
            ),
            GestureDetector(
                onTap: () {}, child: Image.asset('assets/images/facebook.png'))
          ],
        ),
      ],
    );
  }
}
