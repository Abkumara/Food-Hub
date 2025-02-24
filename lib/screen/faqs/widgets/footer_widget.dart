import 'package:flutter/material.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(204, 0, 0, 0),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Privacy',
                    style: size14_M_regular(textColor: Colors.white)),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Terms',
                    style: size14_M_regular(textColor: Colors.white)),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Security',
                    style: size14_M_regular(textColor: Colors.white)),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Site Map',
                    style: size14_M_regular(textColor: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('SOCIAL LINKS',
                    style: size14_M_bold(textColor: Colors.white)),
              ),
              const SizedBox(height: 8),
              Text('Instagram',
                  style: size14_M_regular(textColor: Colors.white)),
              const SizedBox(height: 8),
              Text('Facebook',
                  style: size14_M_regular(textColor: Colors.white)),
            ],
          ),
          const SizedBox(height: 15),
          Image.asset(
            'assets/images/logo.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            '''
By continuing past this page, you agree to our Terms of Service, Cookie Policy, Privacy Policy and Content Policies. All trademarks are properties of their respective owners. ©KSN. All rights reserved.
''',
            textAlign: TextAlign.center,
            style: size12_M_regular(textColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
