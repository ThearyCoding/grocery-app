import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/pages/order_accepted_page.dart';
import 'package:grocery_app/widgets/custom_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
        title: Text(
          "CheckOut",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Obx(() {
                return cartController.isLoading.isTrue
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                        itemCount: cartController.cart.value.items.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = cartController.cart.value.items[index];
                          return Row(
                            spacing: 15,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Image.network(
                                      width: 150,
                                      height: 150,
                                      item.product!.images.first),
                                  Positioned(
                                    right: -5,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xff727272),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        item.quantity.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  spacing: 5,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product!.name ?? "No name",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      item.product!.unit ?? "No unit",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "\$${(item.quantity! * (item.product!.price ?? 0)).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        });
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Discount code',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black12,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black12,
                        )),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black12,
                        ))),
                  )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF2F4F3),
                          minimumSize: Size(100, 50),
                          shape: RoundedRectangleBorder()),
                      onPressed: () {},
                      child: Text(
                        "Apply",
                        style: TextStyle(color: Colors.black54),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Obx((){
                return cartController.isLoading.isTrue ? SizedBox(): ListView.builder(
                shrinkWrap: true,
                itemCount: cartController.getSummaryItems().length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final summaryItems = cartController.getSummaryItems()[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Text(
                           summaryItems["title"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: summaryItems["bold"] == true
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                        summaryItems['title'] == 'Shipping'
                                ? Icon(Icons.local_shipping)
                                : SizedBox.shrink()
                          ],
                        ),
                       summaryItems["editable"] == true
                            ? GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Enter shipping address",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : Text(
                                "\$${summaryItems['amount']}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                  );
                },
              );
              })
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 5),
        width: double.infinity,
        height: 70,
        child: CustomButton(
            label: "Order now",
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => OrderAcceptedPage()))),
      ),
    );
  }
}
