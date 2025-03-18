import 'package:flutter/material.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/pages/order_accepted_page.dart';
import 'package:grocery_app/widgets/custom_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final List<Map<String, dynamic>> summaryItems = [
    {"title": "Subtotal", "amount": 430.50},
    {"title": "Shipping", "amount": 0.0, "editable": true},
    {"title": "Estimated Taxes", "amount": 12.00},
    {"title": "Others Fees", "amount": 0.00},
    {"title": "Total", "amount": 442.50, "bold": true},
  ];
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
              ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                  itemCount: groceries.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      spacing: 15,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Color(0xffF0F1F6)),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                  width: 150,
                                  height: 150,
                                  groceries[index].imagePath),
                              Positioned(
                                right: -5,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xff727272),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                groceries[index].name,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(groceries[index].description),
                              Text(
                                "\$${groceries[index].price.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )
                      ],
                    );
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: summaryItems.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Text(
                              summaryItems[index]["title"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: summaryItems[index]["bold"] == true
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            summaryItems[index]['title'] == 'Shipping'
                                ? Icon(Icons.local_shipping)
                                : SizedBox.shrink()
                          ],
                        ),
                        summaryItems[index]["editable"] == true
                            ? GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Enter shipping address",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : Text(
                                "\$${summaryItems[index]["amount"].toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 5),
        width: double.infinity,
        height: 70,
        child: CustomButton(label: "Order now", onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OrderAcceptedPage()))),
      ),
    );
  }
}
