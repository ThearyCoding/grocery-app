import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/auth_controller.dart';
import 'package:grocery_app/controllers/user_controller.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/pages/auth_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final String profilePath = "assets/images/theary_profile.JPG";

  @override
  void initState() {
    super.initState();
    _userController.getProfile();
  }

  final List<Map<String, String>> accountItems = [
    {
      'imagePath': 'assets/icons/account_icons/orders_icon.svg',
      'title': 'Orders'
    },
    {
      'imagePath': 'assets/icons/account_icons/details_icon.svg',
      'title': 'My Details'
    },
    {
      'imagePath': 'assets/icons/account_icons/delivery_icon.svg',
      'title': 'Delivery Address'
    },
    {
      'imagePath': 'assets/icons/account_icons/payment_icon.svg',
      'title': 'Payment Methods'
    },
    {
      'imagePath': 'assets/icons/account_icons/promo_icon.svg',
      'title': 'Promo Code'
    },
    {
      'imagePath': 'assets/icons/account_icons/notification_icon.svg',
      'title': 'Notifications'
    },
    {'imagePath': 'assets/icons/account_icons/help_icon.svg', 'title': 'Help'},
    {
      'imagePath': 'assets/icons/account_icons/about_icon.svg',
      'title': 'About'
    },
  ];

  final AuthController _authController = Get.put(AuthController());
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundColor:
                          AppColors.primaryColor.withValues(alpha: .1),
                      backgroundImage: (_userController
                                  .user.value.picture?.isNotEmpty ??
                              false)
                          ? NetworkImage(_userController.user.value.picture!)
                          : null,
                      child:
                          (_userController.user.value.picture?.isEmpty ?? true)
                              ? Text(
                                  (_userController.user.value.fullName
                                              ?.isNotEmpty ??
                                          false)
                                      ? _userController.user.value.fullName![0]
                                          .toUpperCase()
                                      : "?",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _userController.user.value.fullName ??
                                "no name provided.",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.edit,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      Text(
                        _userController.user.value.email ??
                            "no email provided.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff7C7C7C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return ListTile(
                    leading:
                        SvgPicture.asset(accountItems[index]['imagePath']!),
                    title: Text(
                      accountItems[index]['title']!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                },
                separatorBuilder: (_, index) => Divider(),
                itemCount: accountItems.length),
            Divider(),
            SizedBox(
              height: 50,
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                    icon: SvgPicture.asset(
                        'assets/icons/account_icons/logout_icon.svg'),
                    style: ElevatedButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        backgroundColor: Color(0xffF2F3F2),
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))),
                    onPressed: () async {
                      await _authController.logOut();
                      Get.off(() => AuthPage());
                    },
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                            fontSize: 18, color: AppColors.primaryColor),
                      ),
                    )))
          ],
        ),
      ),
    ));
  }
}
