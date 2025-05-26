import 'dart:convert';
import 'package:grocery_app/core/constants.dart';
import 'package:grocery_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class ProductApi {
  Future<List<Product>> fetchProductExclusive() async {
    try {
      final url = Uri.parse("${AppConstants.baseUrl}/products?sort=exclusive");

      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        final productData = jsonDecode(response.body)["products"] as List;

        return productData.map((product) => Product.fromJson(product)).toList();
      } else {
        dev.log(response.body);
        return [];
      }
    } catch (e) {
      dev.log("error fetching products: $e");
      return [];
    }
  }

  Future<List<Product>> searchSuggestion({required String productName}) async {
    try {
      final url = Uri.parse(
          "${AppConstants.baseUrl}/products?search=$productName&autocomplete=true");

      final res =
          await http.get(url, headers: {"Content-Type": "application/json"});
      if(res.statusCode == 200){
        final dataJson = jsonDecode(res.body)['suggestions'] as List<dynamic>;
        return dataJson.map((p) => Product.fromJson(p as Map<String, dynamic>)).toList();
      }else{
        dev.log(res.body);
        return [];
      }
    } catch (e) {
      dev.log("error fetch product suggestion: $e");
      return [];
    }
  }

  Future<List<Product>> fetchProductByCategory(
      {required String categoryId}) async {
    try {
      final url =
          Uri.parse("${AppConstants.baseUrl}/products?category=$categoryId");
      final res =
          await http.get(url, headers: {"Content-Type": "application/json"});
      if (res.statusCode == 200) {
        final productData = jsonDecode(res.body)["products"] as List;

        return productData.map((product) => Product.fromJson(product)).toList();
      } else {
        dev.log(res.body);
        return [];
      }
    } catch (e) {
      dev.log("error fetching product by categoryId: $e");
      return [];
    }
  }

  Future<List<Product>> fetchProductsBestSelling() async {
    try {
      final url =
          Uri.parse("${AppConstants.baseUrl}/products?sort=best_selling");

      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        final productData = jsonDecode(response.body)["products"] as List;

        return productData.map((product) => Product.fromJson(product)).toList();
      } else {
        dev.log(response.body);
        return [];
      }
    } catch (e) {
      dev.log("error fetching products: $e");
      return [];
    }
  }

  Future<List<Product>> fetchProductNewest() async {
    try {
      final url = Uri.parse("${AppConstants.baseUrl}/products?sort=newest");

      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        final productData = jsonDecode(response.body)["products"] as List;

        return productData.map((product) => Product.fromJson(product)).toList();
      } else {
        dev.log(response.body);
        return [];
      }
    } catch (e) {
      dev.log("error fetching products: $e");
      return [];
    }
  }

  Future<Product> fetchSingleProduct({required String productId}) async {
    try {
      final url = Uri.parse("${AppConstants.baseUrl}/products/$productId");

      final proRes =
          await http.get(url, headers: {"Content-Type": "application/json"});

      if (proRes.statusCode == 200) {
        final proJson =
            jsonDecode(proRes.body)['product'] as Map<String, dynamic>;
        return Product.fromJson(proJson);
      } else {
        dev.log(proRes.body);
        return Product.empty();
      }
    } catch (e) {
      dev.log("error fetching single product: $e");
      return Product.empty();
    }
  }
}
