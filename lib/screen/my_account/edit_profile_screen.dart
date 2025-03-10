import 'package:flutter/material.dart';
import 'package:foods_hub/controller/api_controller/auth_controller.dart';
import 'package:foods_hub/controller/api_controller/user_profile_controller.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/widgets/loading_widgets.dart';
import 'package:foods_hub/screen/my_account/widgets/edit_profile_screen_widgets.dart';
import 'package:foods_hub/widgets/custom_app_bar_widget.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final AuthController authController = Get.put(AuthController());

  String initialName = "";
  String initialEmail = "";
  String initialNumber = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => fetchUserData());
  }

  void fetchUserData() async {
    userProfileController.isLoading.value = true;
    await userProfileController.fetchUserProfile();
    var userApi = userProfileController.userProfile.value;

    setState(() {
      initialName = userApi.name ?? "";
      initialEmail = userApi.email ?? "";
      initialNumber = userApi.mobile ?? "";

      nameController.text = initialName;
      emailController.text = initialEmail;
      numberController.text = initialNumber;
      userProfileController.isLoading.value = false;
    });
  }

  void updateProfile() async {
    await authController.signUpUpdate(
      numberController.text,
      emailController.text,
      nameController.text,
      false,
    );

    // Refresh the user profile in the global controller
    //await userProfileController.fetchUserProfile();

    // Optionally, show a success message or navigate back
    //Get.snackbar("Success", "Profile updated successfully");
    setState(() {
      fetchUserData();
    });
  }

  void resetValues() {
    setState(() {
      nameController.text = initialName;
      emailController.text = initialEmail;
      numberController.text = initialNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: const CustomAppBar(title: 'EDIT ACCOUNT'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (userProfileController.isLoading.value) {
            return ShimmerLoadingWidget();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                EditAccountTextField(
                  controller: nameController,
                  labelText: 'Name',
                  onUpdate: updateProfile,
                  onCancel: resetValues,
                ),
                EditAccountTextField(
                  controller: emailController,
                  labelText: 'Email Address',
                  onUpdate: updateProfile,
                  onCancel: resetValues,
                ),
                EditAccountTextField(
                  controller: numberController,
                  labelText: 'Phone Number',
                  onUpdate: updateProfile,
                  onCancel: resetValues,
                  isEdit: false,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
