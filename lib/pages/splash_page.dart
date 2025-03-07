import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/pages/welcome_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final String assetPath = 'assets/icons/splash_screen_icon.svg';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(
      seconds: 2
    ),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff53B176),
      body: Center(
        child: SvgPicture.asset(assetPath),
      ),
    );
  }
}