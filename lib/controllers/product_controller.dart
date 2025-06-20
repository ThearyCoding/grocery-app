import 'package:get/get.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/services/apis/product_api.dart';
import 'dart:developer' as dev;

class ProductController extends GetxController {
  final _productApi = ProductApi();
  final productsExclusive = <Product>[].obs;
  final productsBestSelling = <Product>[].obs;
  final productNewest = <Product>[].obs;
  final isLoadingExclusive = false.obs;
  final isLoadingBestSelling = false.obs;
  final isLoadingNewest = false.obs;
  final isLoadingDetail = false.obs;
  final isLoadingCategory = false.obs;
  final products = <Product>[].obs;
  final Rx<Product> product = Rx(Product.empty());
  final suggestions = <Product>[].obs;
  final isLoadingSuggestion = false.obs;

  @override
  void onInit() {
    super.onInit();

    Future.wait([
      fetchProductExclusive(),
      fetchProductsBestSelling(),
      fetchProductNewest(),
    ]);
  }

  Future<void> searchSuggestion({required String productName}) async {
    isLoadingSuggestion(true);
    final data = await _productApi.searchSuggestion(productName: productName);

    suggestions.assignAll(data);
    isLoadingSuggestion(false);
  }

  Future<void> fetchProductByCategory({required String categoryId}) async {
    isLoadingCategory(true);
    final data =
        await _productApi.fetchProductByCategory(categoryId: categoryId);
    products.assignAll(data);
    isLoadingCategory(false);
  }

  Future<void> fetchSingleProduct({required String productId}) async {
    isLoadingDetail(true);
    final proData = await _productApi.fetchSingleProduct(productId: productId);
    product.value = proData;
    isLoadingDetail(false);
  }

  Future<void> fetchProductExclusive() async {
    try {
      isLoadingExclusive(true);
      final productData = await _productApi.fetchProductExclusive();

      productsExclusive.assignAll(productData);
    } catch (e) {
      dev.log("error fetching products");
    } finally {
      isLoadingExclusive(false);
    }
  }

  Future<void> fetchProductsBestSelling() async {
    try {
      isLoadingBestSelling(true);

      final data = await _productApi.fetchProductsBestSelling();
      productsBestSelling.assignAll(data);
    } catch (e) {
      dev.log("error fetching products");
    } finally {
      isLoadingBestSelling(false);
    }
  }

  Future<void> fetchProductNewest() async {
    try {
      isLoadingNewest(true);

      final data = await _productApi.fetchProductNewest();
      productNewest.assignAll(data);
    } catch (e) {
      dev.log("error fetching products");
    } finally {
      isLoadingNewest(false);
    }
  }
}
