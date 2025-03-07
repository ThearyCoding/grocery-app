import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Column(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Divider(),
          ),
          SizedBox(
            height: 30,
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
                onPressed: () {},
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Continue with Google",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff4A65AC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17))),
                onPressed: () {},
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Continue with Facebook",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                icon: Image.asset(
                  logoFacebookPath,
                  width: 35,
                  height: 35,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
