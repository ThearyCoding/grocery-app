import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/order_controller.dart';
import 'package:grocery_app/pages/order_detail_page.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Orders',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            if (orderController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (orderController.orders.isEmpty) {
              return const Center(
                child: Text('No orders found.'),
              );
            } else {
              return RefreshIndicator.adaptive(
                onRefresh: () => orderController.fetchOrders(),
                child: ListView.builder(
                  itemCount: orderController.orders.length,
                  itemBuilder: (context, index) {
                    final order = orderController.orders[index];
                    final items = order.items;
                    return GestureDetector(
                      onTap: () => Get.to(() => OrderDetailPage(),arguments: {
                        "orderId": order.id?? ""
                      }),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order #${order.id?.substring(0, 6) ?? 'N/A'}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: orderController
                                          .getStatusColor(
                                              order.orderStatus ?? 'N/A')
                                          .withValues(alpha: .1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      order.orderStatus ?? 'N/A',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: orderController.getStatusColor(
                                              order.orderStatus ?? "")),
                                    )),
                              ],
                            ),
                            Text(
                              orderController
                                  .formatDate(order.createdAt ?? DateTime.now()),
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ...items!.map((it) {
                              return Row(
                                spacing: 10,
                                children: [
                                  Image.network(
                                    fit: BoxFit.cover,
                                    it.image ?? "",
                                    width: 70,
                                    height: 70,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        it.name ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        "${it.unit ?? ""}  .  x${it.quantity}",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$${it.price! * (it.quantity ?? 0)}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              );
                            }),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                Text(
                                  "\$${order.totalAmount?.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 16),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ));
  }
}
