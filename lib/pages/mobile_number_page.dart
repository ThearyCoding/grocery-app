import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/pages/verification_otp_page.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MobileNumberPage extends StatefulWidget {
  const MobileNumberPage({super.key});

  @override
  State<MobileNumberPage> createState() => _MobileNumberPageState();
}

class _MobileNumberPageState extends State<MobileNumberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Enter your mobile number",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Mobile Number",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            IntlPhoneField(
              showDropdownIcon: false,
              initialCountryCode: 'KH',
              decoration: InputDecoration(contentPadding: EdgeInsets.all(15)),
              onChanged: (phone) {
                if (kDebugMode) {
                  print(phone.completeNumber);
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => VerificationOtpPage())),
          shape: CircleBorder(),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
