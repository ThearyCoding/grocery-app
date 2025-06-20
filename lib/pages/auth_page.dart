import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/controllers/auth_controller.dart';
import 'package:grocery_app/pages/login_page.dart';
import 'package:grocery_app/pages/main_page.dart';
import 'package:grocery_app/pages/selected_location_page.dart';
import 'package:grocery_app/widgets/custom_button.dart';
import 'package:get/get.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final String loginSlidePath = "assets/images/login-slide.png";
  final String logoGooglePath = "assets/icons/icons8-google-96.png";
  final String logoFacebookPath = "assets/icons/icons8-facebook-f-96.png";
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(loginSlidePath),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Get your groceries',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 27),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Nectar',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 27),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CountryCodePicker(
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  label: "Login wiht Phone",
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SelectedLocationPage()))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: CustomButton(
                  label: "Login wiht Email",
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LoginPage()))),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Divider(),
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  'or connect with social media',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff5583EC),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17))),
                  onPressed: () async {
                    await authController.logOut();
                    final success = await authController.loginWithGoogle();
                    if (success) {
                      Get.off(MainPage());
                    }
                  },
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: authController.isLoading.value
                        ? CircularProgressIndicator()
                        : Text(
                            "Continue with Google",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                  ),
                  icon: Image.asset(
                    logoGooglePath,
                    width: 35,
                    height: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
