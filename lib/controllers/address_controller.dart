import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:grocery_app/core/constants.dart';
import 'package:grocery_app/models/address.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:grocery_app/utils/api_headers.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  final addressRes = Rx(AddressResponse());
  final isLoading = false.obs;

  @override
  void onInit(){
    super.onInit();
    fetchAddresses();
  }
  Future<void> fetchAddresses() async {
    final token = await TokenStorage().getToken();
    try {
      isLoading.value = true;
      final response =
          await http.get(
            headers: headers(token ?? ""),
            Uri.parse('${AppConstants.baseUrl}/addresses',));
      if (response.statusCode == 200) {
        final dataJson = jsonDecode(response.body);
        addressRes.value = AddressResponse.fromJson(dataJson);
      } else {
        if (kDebugMode) {
          print('Failed to load addresses: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching addresses: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
