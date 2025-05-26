import 'package:get/get.dart';
import 'package:grocery_app/models/wishlist.dart';
import 'package:grocery_app/services/apis/wishlist_api.dart';

class WishlistController extends GetxController {
  final _wishlistApi = WishlistApi();
  final Rx<Wishlist> wishlist = Rx(Wishlist.empty());
  final isLoading = false.obs;
  final isInWishlistProduct = false.obs;

  Future<void> isInWishlist({required String productId}) async {
    isInWishlistProduct.value =
        await _wishlistApi.isInWishlist(productId: productId);
  }

  Future<void> toggleWishlist({required String productId}) async {
    if (isInWishlistProduct.isTrue) {
      await removeWishlist(productId: productId);
      isInWishlistProduct(false);
    } else {
      await createWishlist(productId: productId);
      isInWishlistProduct(true);
    }
  }

  Future<void> removeWishlist({required String productId}) async {
    int index = wishlist.value.items.indexWhere((item) => item.product!.id == productId);

    await _wishlistApi.removeWishlist(productId: productId);
    if (index != -1) {
      wishlist.value.items.removeAt(index);
      wishlist.refresh();
    }
  }

  Future<void> createWishlist({required String productId}) async {
    await _wishlistApi.createWishlist(productId: productId);
    await fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    isLoading(true);
    final data = await _wishlistApi.fetchWishlist();
    wishlist.value = data;
    isLoading(false);
  }
}
