import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/order_controller.dart';
import 'package:grocery_app/pages/order_detail_page.dart';

class MyOrderPage extends StatelessWidget {
  MyOrderPage({super.key});
  final orderController = Get.isRegistered<OrderController>()
      ? Get.find<OrderController>()
      : Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (orderController.isLoading.value) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (orderController.errorText.value != null) {
            return Center(child: Text(orderController.errorText.value!));
          }

          if (orderController.orderResponse.value.data == null) {
            return const Center(child: Text('No orders found.'));
          }

          return RefreshIndicator.adaptive(
            onRefresh: () => orderController.fetchOrders(),
            child: ListView.builder(
              itemCount: orderController.orderResponse.value.data?.length,
              itemBuilder: (context, index) {
                if (orderController.orderResponse.value.data == null) {
                  return SizedBox();
                }
                final order = orderController.orderResponse.value.data![index];
                final items = order.items ?? const [];

                return GestureDetector(
                  onTap: () => Get.to(() => const OrderDetailPage(),
                      arguments: {"id": order.id ?? ""}),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order #${order.id?.substring(0, 6) ?? 'N/A'}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: orderController
                                    .getStatusColor(order.orderStatus ?? 'N/A')
                                    .withOpacity(
                                        .1), 
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                order.orderStatus ?? 'N/A',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: orderController
                                      .getStatusColor(order.orderStatus ?? ''),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          orderController
                              .formatDate(order.createdAt ?? DateTime.now()),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 20),
                        ...items.map((it) {
                          final qty = it.quantity ?? 0;
                          final unit = it.unit ?? '';
                          final price = (it.price ?? 0) * qty; 
                          final imageUrl =
                              (it.image ?? '').isEmpty ? null : it.image;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: imageUrl == null
                                      ? Container(
                                          width: 70,
                                          height: 70,
                                          color: Colors.grey.shade200,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                              Icons.image_not_supported),
                                        )
                                      : Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          width: 70,
                                          height: 70,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                            width: 70,
                                            height: 70,
                                            color: Colors.grey.shade200,
                                            alignment: Alignment.center,
                                            child:
                                                const Icon(Icons.broken_image),
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        it.name ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "$unit  ·  x$qty",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "\$${price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),

                        // Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            Text(
                              "\$${(order.totalAmount ?? 0).toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
