import 'package:get/get.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/apis/user_api.dart';

class UserController extends GetxController{
  Rx<User> user = Rx(User.empty());
  final UserApi _userApi = UserApi();

  Future<void> getProfile()async{
    final data = await _userApi.getProfile();
    user.value = data;
  }
}