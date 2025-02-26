import 'package:flutter/material.dart';
import 'package:foods_hub/controller/api_controller/auth_controller.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/core/utils/validation/validation.dart';
import 'package:foods_hub/screen/auth/widgets/otp_box.dart';
import 'package:foods_hub/screen/auth/widgets/social_media_login.dart';
import 'package:foods_hub/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _moveToTop = true;
  final TextEditingController _mobileNumberController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isTextfield = false;
  bool _isContinue = true;
  late VideoPlayerController _videoController;
  String enteredOtp = '';
  // Replace with dynamic input
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != _isTextfield) {
        setState(() {
          _isTextfield = _focusNode.hasFocus;
        });
      }
    });

    // Initialize the video controller
    _moveToTop = false;
    _videoController = VideoPlayerController.asset('assets/videos/bgvid.mp4')
      ..initialize().then((_) {
        setState(() {}); // Rebuild once video is initialized
        _videoController.setLooping(true); // Loop video
        _videoController.play(); // Start video playback
      });
  }

  void _submitOtp(String otp) {
    setState(() {
      enteredOtp = otp; // Update the OTP entered by the user
    });
    debugPrint('OTP Submitted: $otp');
  }

  @override
  void dispose() {
    _videoController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorWhite,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss the keyboard
          setState(() {
            _isTextfield = false; // Reset the flag
          });
        },
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 800),
              alignment: _moveToTop ? Alignment.center : Alignment.topCenter,
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                padding: _moveToTop
                    ? const EdgeInsets.symmetric(horizontal: 50.0)
                    : EdgeInsets.symmetric(
                        horizontal: 105.0, vertical: screenHeight * 0.09),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: _moveToTop ? -screenHeight * 0.73 : 0,
              left: 0,
              right: 0,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 850),
              child: Stack(
                children: [
                  _videoController.value.isInitialized
                      ? Positioned.fill(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _videoController.value.size.width,
                                height: screenHeight * 0.73,
                                child: VideoPlayer(
                                  _videoController,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ),
                  Container(
                    height: keyboardHeight > 0
                        ? screenHeight * 0.73 - keyboardHeight
                        : screenHeight * 0.73,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(30),
                        topStart: Radius.circular(30),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 19.0, top: 35, left: 19),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _isContinue
                                        ? 'Enter your Number'
                                        : 'Enter Verification Code',
                                    style: size14_M_bold(),
                                  ),
                                  _isContinue
                                      ? const SizedBox.shrink()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Text(
                                            'Send to +91 ${_mobileNumberController.text}',
                                            style: size12_M_regular().copyWith(
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                  const SizedBox(height: 20),
                                  _isContinue
                                      ? EnterMobileNumberTextfield(
                                          mobileNumberController:
                                              _mobileNumberController,
                                          focusNode: _focusNode)
                                      : OtpBox(
                                          onOtpSubmit: _submitOtp,
                                        ),
                                  (!_isTextfield && _isContinue)
                                      ? const Column(
                                          children: [
                                            SizedBox(height: 25),
                                            OrDividerText(),
                                            SocialMediaLogin()
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: screenHeight * 0.085,
                                            ),
                                            _isContinue
                                                ? const SizedBox.shrink()
                                                : const VerficationCodeText(),
                                            CustomButton(
                                              isTransparent: true,
                                              onTap: () {
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 300),
                                                    _isContinue
                                                        ? () {
                                                            if (_formKey
                                                                    .currentState
                                                                    ?.validate() ??
                                                                false) {
                                                              _authController
                                                                  .sendOtp(
                                                                      _mobileNumberController
                                                                          .text);
                                                              setState(() {
                                                                _isContinue =
                                                                    false;
                                                              });
                                                            }
                                                          }
                                                        : () {
                                                            if (enteredOtp
                                                                .isNotEmpty) {
                                                              debugPrint(
                                                                  'Verifying OTP: $enteredOtp');
                                                              _authController
                                                                  .verifyOTP(
                                                                      _mobileNumberController
                                                                          .text,
                                                                      enteredOtp,
                                                                      context);
                                                            }
                                                          });
                                              },
                                              text: _isContinue
                                                  ? 'Continue'
                                                  : 'Verify',
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _isContinue
                                                ? const TermsOfServiceText()
                                                : const SizedBox.shrink(),
                                            const SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrDividerText extends StatelessWidget {
  const OrDividerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          endIndent: 17,
        )),
        Text(
          'or',
          style: size16_M_medium(),
        ),
        const Expanded(
            child: Divider(
          indent: 17,
        ))
      ],
    );
  }
}

class VerficationCodeText extends StatelessWidget {
  const VerficationCodeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Get Verification Code again in ',
              style: size12_M_regular(),
            ),
            TextSpan(
              text: '00:20',
              style: size12_M_bold(),
            )
          ],
        ),
      ),
    );
  }
}

class TermsOfServiceText extends StatelessWidget {
  const TermsOfServiceText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('By clicking in, I accept the',
            style:
                size10_M_bold().copyWith(color: colorWhite.withOpacity(0.7))),
        Text(' Terms of Services',
            style: size10_M_bold().copyWith(
                decoration: TextDecoration.underline,
                decorationColor: colorWhite,
                decorationThickness: 2)),
        Text(' &',
            style:
                size10_M_bold().copyWith(color: colorWhite.withOpacity(0.7))),
        Text(' Privacy Policy',
            style: size10_M_bold().copyWith(
                decoration: TextDecoration.underline,
                decorationColor: colorWhite,
                decorationThickness: 2)),
      ],
    );
  }
}

class EnterMobileNumberTextfield extends StatelessWidget {
  const EnterMobileNumberTextfield({
    super.key,
    required TextEditingController mobileNumberController,
    required FocusNode focusNode,
  })  : _mobileNumberController = mobileNumberController,
        _focusNode = focusNode;

  final TextEditingController _mobileNumberController;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _mobileNumberController,
      keyboardType: TextInputType.number,
      style: size16_M_bold(),
      maxLength: 10,
      focusNode: _focusNode,
      cursorColor: colorWhite,
      decoration: InputDecoration(
          counterText: '',
          errorStyle: size14_M_bold()
              .copyWith(color: Colors.red[900], backgroundColor: colorWhite),
          label: Padding(
            padding: EdgeInsets.zero,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                    color: Color(0xFFACA7A7),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  ' Mobile Number ',
                  style: size14_M_medium(),
                )),
          ),
          prefix: SizedBox(
            width: 42,
            child: Row(
              children: [
                Text(
                  '+91 ',
                  style: size16_M_bold(),
                ),
                const SizedBox(
                  height: 25, // Adjust height as needed
                  child: VerticalDivider(
                    color: colorWhite,
                    thickness: 0.8,
                    width: 10, // Space between text and divider
                  ),
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 10.0), // Adjust padding inside the field
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: colorWhite, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: colorWhite, width: 1.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: colorWhite, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: colorWhite, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: colorWhite, width: 1.5),
          ),
          filled: true,
          fillColor: Colors.transparent,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      validator: (value) => validationPhone(value),
    );
  }
}
