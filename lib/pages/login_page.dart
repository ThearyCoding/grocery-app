import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String appLogoPath = 'assets/icons/app_icon_color.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: SvgPicture.asset(
                  appLogoPath,
                  width: 70,
                )),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Loging",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Enter your emails and password',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 45,
                ),
                Text(
                  'Email',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter email'),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Password',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.visibility_off,
                      ),
                      hintText: 'Enter password'),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff53B176),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18))),
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
