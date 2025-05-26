import 'package:get/get.dart';
import 'package:grocery_app/services/apis/category_api.dart';

import '../models/category.dart';

class CategoryController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  final CategoryApi _api = CategoryApi();
  final categories = <Category>[].obs;
  final isLoading = true.obs;

  Future<void> fetchCategories() async {
    isLoading(true);
    final data = await _api.fetchCategories();
    categories.assignAll(data);
    isLoading(false);
  }
}
