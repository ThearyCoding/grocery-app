import 'dart:convert';

import 'package:grocery_app/core/constants.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:grocery_app/utils/api_headers.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import '../../models/wishlist.dart';

class WishlistApi {
  final TokenStorage _storage = TokenStorage();

  Future<void> createWishlist({required String productId}) async {
    try {
      final token = await _storage.getToken();
      final url = Uri.parse("${AppConstants.baseUrl}/wishlists");
      final response = await http.post(url,
          headers: headers(token!), body: jsonEncode({"productId": productId}));

      if (response.statusCode == 201) {
        dev.log("product added to wishlist");
      } else {
        dev.log("error creating wishlist: ${response.body}");
      }
    } catch (e) {
      dev.log("errr creating wishlist: $e");
    }
  }

  Future<void> removeWishlist({required String productId}) async {
    try {
      final token = await _storage.getToken();
      final url = Uri.parse("${AppConstants.baseUrl}/wishlists/$productId");
      final response = await http.delete(url,
          headers: headers(token!));

      if (response.statusCode == 200) {
        dev.log("product removed from wishlist");
      } else {
        dev.log("error remove wishlist: ${response.body}");
      }
    } catch (e) {
      dev.log("errr remove wishlist: $e");
    }
  }
  Future<Wishlist> fetchWishlist() async {
    try {
      final token = await _storage.getToken();
      final url = Uri.parse("${AppConstants.baseUrl}/wishlists");
      final response = await http.get(url, headers: headers(token!));

      if (response.statusCode == 200) {
        dev.log("fetch wishlist success.");
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return Wishlist.fromJson(data);
      } else {
        dev.log("error fetching wishlist: ${response.body}");
        return Wishlist.empty();
      }
    } catch (e) {
      dev.log("error fetching wishlist: $e");
      return Wishlist.empty();
    }
  }

  Future<bool> isInWishlist({required String productId}) async{
    try {
      final token = await _storage.getToken();
      final url = Uri.parse("${AppConstants.baseUrl}/wishlists/is-in-wishlist/$productId");
      final response = await http.get(url,headers: headers(token!));
      if(response.statusCode == 200){
        return jsonDecode(response.body) as bool;
      }else{
        return jsonDecode(response.body) as bool;
      }
    } catch (e) {
      dev.log("error fetching wishlist product: $e");
      return false;
    }
  }




}
