import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksn_mobile_customer/controller/api_controller/contact_us_controller.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/core/utils/validation/validation.dart';
import 'package:ksn_mobile_customer/model/contact_us_model.dart';
import 'package:ksn_mobile_customer/screens/faqs/widgets/faq_app_bar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return FaqAppBarWidget(
      height: 120,
      title: 'Contact Us',
      //backgroundColor: colorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            BuildHeader(),
            SizedBox(
              height: 20,
            ),
            GreenColorContainer(),
            SizedBox(
              height: 33,
            ),
            TextFieldAndButton(),
            Image.asset('assets/images/dec.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.all(20),
                color: Color(0xFF011C2A),
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 85,
                      height: 45,
                      fit: BoxFit.fill,
                    ),
                    Divider(
                      height: 19,
                      color: colorWhite,
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reach us',
                              style: size16_M_bold(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset('assets/icons/call.png'),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              '+1012 3456 789',
                              style: size12_M_regular(),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            const Icon(
                              Icons.email,
                              color: colorWhite,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'demo@gmail.com',
                              style: size12_M_regular(),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            const Icon(
                              Icons.location_on,
                              color: colorWhite,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              '132 Dartmouth Street Boston, Massachusetts 02156 United States',
                              style: size12_M_regular(),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Company',
                                style: size16_M_bold(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'About',
                                style: size12_M_regular(),
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                'Contact',
                                style: size12_M_regular(),
                              ),
                              const SizedBox(
                                height: 13,
                              ),
                              Text(
                                'Blogs',
                                style: size12_M_regular(),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Legal',
                              style: size16_M_bold(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Privacy Policy',
                              style: size12_M_regular(),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Text(
                              'Terms & Services',
                              style: size12_M_regular(),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Text(
                              'Terms of Use',
                              style: size12_M_regular(),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Text(
                              'Refund Policy',
                              style: size12_M_regular(),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quick Links', style: size16_M_bold()),
                              const SizedBox(height: 20),
                              Text('Techlabz Keybox',
                                  style: size12_M_regular()),
                              const SizedBox(height: 13),
                              Text('Downloads', style: size12_M_regular()),
                              const SizedBox(height: 13),
                              Text('Forum', style: size12_M_regular()),
                            ],
                          ),
                        ))
                      ],
                    ),
                    SizedBox(height: 48),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF011621),
                      ),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'Join Our Newsletter',
                            style: size16_M_bold(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  color: Color(0xFF02273A),
                                  child: TextField(
                                    style: size12_M_medium(),
                                    cursorColor: colorWhite,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(left: 10),
                                        hintText: 'Your email address'),
                                  ),
                                )),
                                Container(
                                  height: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 22),
                                  color: Color(0xFF000E15),
                                  child: Center(
                                    child: Text(
                                      'Subscribe',
                                      style: size12_M_medium(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '*  Will send you weekly updates for your better tool management.',
                            style: size14_M_medium(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 74)
          ],
        ),
      ),
    );
  }
}

class TextFieldAndButton extends StatefulWidget {
  const TextFieldAndButton({
    super.key,
  });

  @override
  State<TextFieldAndButton> createState() => _TextFieldAndButtonState();
}

class _TextFieldAndButtonState extends State<TextFieldAndButton> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController messageController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final contactusController = Get.put(ContactUsController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            CustomTextFIeldContactUs(
              textEditingController: firstNameController,
              labelText: 'First Name',
              validator: (value) => validationFirstName(value),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFIeldContactUs(
              textEditingController: lastNameController,
              labelText: 'Last Name',
              validator: (value) => validationLastName(value),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFIeldContactUs(
              textEditingController: emailController,
              labelText: 'Email',
              validator: (value) => validationEmail(value),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFIeldContactUs(
              textEditingController: phoneNumberController,
              labelText: 'Phone Number',
              isNumber: true,
              validator: (value) => validationPhone(value),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              maxLines: 5,
              controller: messageController,
              decoration: InputDecoration(
                focusColor: blackType1,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blackType1)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "Enter your message",
                labelStyle: size16_M_bold(textColor: const Color(0xFF8D8D8D)),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Message cannot be empty";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  var request = ContactRequest(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      contactNo: phoneNumberController.text,
                      message: messageController.text);
                  contactusController.addCustomerDetails(request);
                  // Clear text fields

                  Future.delayed(const Duration(seconds: 4), () {
                    firstNameController.clear();
                    lastNameController.clear();
                    emailController.clear();
                    phoneNumberController.clear();
                    messageController.clear();

                    // Optionally, reset form state
                    _formKey.currentState!.reset();
                  });
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF00B800),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Send Message',
                    style: size14_M_medium(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextFIeldContactUs extends StatelessWidget {
  const CustomTextFIeldContactUs(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      this.isNumber = false,
      required this.validator});
  final TextEditingController textEditingController;
  final String labelText;
  final bool isNumber;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: isNumber ? TextInputType.number : TextInputType.name,
      validator: validator,
      decoration: InputDecoration(
          focusColor: blackType1,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: blackType1,
          )),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: size16_M_bold(textColor: const Color(0xFF8D8D8D))),
    );
  }
}

class GreenColorContainer extends StatelessWidget {
  const GreenColorContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 75),
      width: double.infinity,
      color: const Color(0xFF00B800),
      child: Column(
        children: [
          Text(
            'Contact information',
            style: size20_M_bold(),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'Say something to start a live chat!',
            style: size12_M_regular(),
          ),
          const SizedBox(
            height: 12,
          ),
          Image.asset('assets/icons/call.png'),
          const SizedBox(
            height: 12,
          ),
          Text(
            '+1012 3456 789',
            style: size12_M_regular(),
          ),
          const SizedBox(
            height: 32,
          ),
          const Icon(
            Icons.email,
            color: colorWhite,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'demo@gmail.com',
            style: size12_M_regular(),
          ),
          const SizedBox(
            height: 32,
          ),
          const Icon(
            Icons.location_on,
            color: colorWhite,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            '132 Dartmouth Street Boston, Massachusetts 02156 United States',
            style: size12_M_regular(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class BuildHeader extends StatelessWidget {
  const BuildHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Contact Us',
          style: size24_M_bold(textColor: notificationAppBarColor)
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Any question or remarks? \nJust write us a message!',
          style: size14_M_medium(textColor: const Color(0xFF717171)),
        ),
      ],
    );
  }
}
