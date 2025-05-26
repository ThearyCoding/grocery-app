import 'dart:convert';

import 'package:grocery_app/core/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import '../../models/category.dart';

class CategoryApi {
  Future<List<Category>> fetchCategories() async{
    try {
      final url  = Uri.parse("${AppConstants.baseUrl}/categories");
      final response = await http.get(url,headers: {
        "Content-Type": "application/json",
      });
      if(response.statusCode == 200){
        final dataJson = jsonDecode(response.body) as List;
        return dataJson.map((e) => Category.fromJson(e)).toList();
      }else{
        dev.log("Error: ${response.body}");
         return [];
      }
    } catch (e) {
      return [];
    }
  }
}