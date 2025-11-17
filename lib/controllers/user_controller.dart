import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/localization_controller.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/apis/user_api.dart';

class UserController extends GetxController {
  Rx<User> user = Rx(User.empty());
  final UserApi _userApi = UserApi();
  final localizationController = Get.find<LocalizationController>();

  Future<void> getProfile() async {
    final data = await _userApi.getProfile();
    user.value = data;
  }

  void showDialogChangeLanguages() async {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return Dialog(
          
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select your language",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  ),
                ),
                ListTile(
                  leading: Text('🇺🇸',style: TextStyle(
                    fontSize: 17
                  ),),
                  title: Text(
                    "English",
                    style: TextStyle(
                        fontWeight:
                            localizationController.currectLocale.value ==
                                    Locale("en")
                                ? FontWeight.w600
                                : FontWeight.w500),
                  ),
                  onTap: () {
                    localizationController.switchLanguage(Locale("en"));
                  },
                  trailing: localizationController.currectLocale.value ==
                          Locale("en")
                      ? Icon(Icons.check,
                          color: localizationController.currectLocale.value ==
                                  Locale("en")
                              ? Colors.green
                              : null)
                      : null,
                ),
                ListTile(
                  leading: Text("🇰🇭",style: TextStyle(
                    fontSize: 17
                  ),),
                  title: Text(
                    "Khmer",
                    style: TextStyle(
                        fontWeight:
                            localizationController.currectLocale.value ==
                                    Locale("km")
                                ? FontWeight.w600
                                : FontWeight.w500),
                  ),
                  onTap: () {
                    localizationController.switchLanguage(Locale("km"));
                  },
                  trailing: localizationController.currectLocale.value ==
                          Locale("km")
                      ? Icon(Icons.check,
                          color: localizationController.currectLocale.value ==
                                  Locale("km")
                              ? Colors.green
                              : null)
                      : null,
                ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 10,),
            
              ],
            ),
          );
        });
  }
}
