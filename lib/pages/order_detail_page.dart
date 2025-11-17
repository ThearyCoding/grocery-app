import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/order_controller.dart';
import 'package:grocery_app/models/order_detail.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final orderController = Get.isRegistered<OrderController>()
      ? Get.find<OrderController>()
      : Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    final orderId = Get.arguments["id"] as String;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderController.fetchOrderDetail(orderId: orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Order Detail",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(() {
            if (orderController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            final orderData = orderController.orderDetailRes.value.data;

            if (orderData == null) {
              return Center(
                child: Text("Failed to get order Detail"),
              );
            }
            return ListView(
              children: [
                _OrderHeader(
                    orderData: orderData, orderController: orderController),
                SizedBox(
                  height: 20,
                ),
                _DeliveryAddress(orderData: orderData),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12)),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Items",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle),
                                child: Text(
                                  orderData.items!.length.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ))
                          ],
                        ),
                      ),
                      Divider(),
                      _OrderItems(orderData: orderData),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _CostBreakdown(
                  discount: orderData.discount ?? 0.0,
                  total: orderData.totalAmount ?? 0.0,
                  otherFee: orderData.otherFee ?? 0.0,
                  promoCode: orderData.promoCode ?? "",
                  subtotal: orderData.subtotal ?? 0.0,
                  tax: orderData.tax ?? 0,
                )
              ],
            );
          }),
        ));
  }
}

class _OrderItems extends StatelessWidget {
  const _OrderItems({
    required this.orderData,
  });

  final OrderData? orderData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: orderData!.items!.length,
        itemBuilder: (context, index) {
          final it = orderData!.items![index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Row(
                    spacing: 10,
                    children: [
                      Image.network(
                        it.image ?? "",
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              it.name ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Text(it.unit ?? ""),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "x${it.quantity}  .  ${it.price}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "\$${it.subtotal}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

class _DeliveryAddress extends StatelessWidget {
  const _DeliveryAddress({
    required this.orderData,
  });

  final OrderData? orderData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12)),
      child: Row(
        spacing: 10,
        children: [
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.green.shade50,
              ),
              child: Icon(
                Icons.location_pin,
                color: Colors.green,
                size: 27,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Address",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  orderData!.address ?? "",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CostBreakdown extends StatelessWidget {
  const _CostBreakdown({
    required this.subtotal,
    required this.discount,
    required this.promoCode,
    required this.tax,
    required this.otherFee,
    required this.total,
  });

  final double subtotal;
  final double discount;
  final String promoCode;
  final double tax;
  final double otherFee;
  final double total;

  @override
  Widget build(BuildContext context) {
    Widget row(String label, num value, {bool bold = false}) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "\$${value.toStringAsFixed(2)}",
              style: bold
                  ? const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
                  : Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          row('Subtotal', subtotal),
          if (discount > 0 || promoCode.isNotEmpty)
            row(promoCode.isNotEmpty ? 'Promo ($promoCode)' : 'Discount',
                discount),
          if (tax > 0) row('Tax', tax),
          if (otherFee > 0) row('Other fees', otherFee),
          const Divider(height: 24),
          row('Total', total, bold: true),
        ],
      ),
    );
  }
}

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({
    required this.orderData,
    required this.orderController,
  });

  final OrderData? orderData;
  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order #${orderData!.id!.substring(0, 6)}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              Text(
                  "Placed on ${orderController.formatDate(orderData!.createdAt ?? DateTime.now())}")
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: orderController
                    .getStatusColor(orderData!.orderStatus ?? "")
                    .withValues(alpha: 0.1),
                border: Border.all(
                    color: orderController
                        .getStatusColor(orderData!.orderStatus ?? ""))),
            child: Text(
                orderController.orderDetailRes.value.data!.orderStatus ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: orderController
                      .getStatusColor(orderData!.orderStatus ?? ""),
                )),
          ),
        ],
      ),
    );
  }
}
