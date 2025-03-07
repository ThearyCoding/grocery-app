import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                  "Sign Up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Enter credentials to continue.',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 45,
                ),
                Text(
                  'Username',
                  style: TextStyle(
                      fontSize: 18, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter username'),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Email',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      hintText: 'Enter email'),
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
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'By continuing you agree to our',
                      style: TextStyle(color: Colors.black, fontSize: 17)),
                  TextSpan(
                      text: 'Terms of Services',
                      style: TextStyle(color: Colors.green, fontSize: 17)),
                  TextSpan(
                      text: ' and ',
                      style: TextStyle(color: Colors.black, fontSize: 17)),
                  TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Colors.green, fontSize: 17)),
                ])),
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
                      'Already have an account?',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                        },
                        child: Text(
                          'Login',
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
