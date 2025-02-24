import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/auth_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/core/utils/validation/validation.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key, required this.mobileNumber});
  final String mobileNumber;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 30),
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                authController.signUpUpdate(
                  mobileNumber,
                  _emailController.text,
                  _nameController.text,
                  true,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            child: Text(
              "SIGN UP",
              style: size14_M_bold().copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(91, 249, 158, 105),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: const Color.fromARGB(91, 249, 158, 105),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SIGN UP",
                        style: size16_M_bold().copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Create an account with the new phone \nnumber",
                        style: size10_M_regular().copyWith(color: addressColor),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "10 digit mobile number",
                        style: size10_M_regular().copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mobileNumber,
                            style:
                                size14_M_bold().copyWith(color: addressColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => VerifyScreen(),
                              //   ),
                              // );
                            },
                            child: const Icon(Icons.check, color: Colors.green),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "NAME",
                          labelStyle: size16_M_medium(textColor: hintTextColor),
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                        onTap: () {
                          final TextSelection newCursor =
                              TextSelection.collapsed(
                                  offset: _nameController.text.length);
                          _nameController.selection = newCursor;
                        },
                        validator: (value) => validationFirstName(value),
                        controller: _nameController,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          labelText: "EMAIL ADDRESS",
                          labelStyle: size16_M_medium(textColor: hintTextColor),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                        validator: (value) => validationEmail(value),
                        onTap: () {
                          final TextSelection newCursor =
                              TextSelection.collapsed(
                                  offset: _emailController.text.length);
                          _emailController.selection = newCursor;
                        },
                        controller: _emailController,
                      ),
                      const SizedBox(height: 150),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
}
