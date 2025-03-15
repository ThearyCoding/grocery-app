import 'package:flutter/material.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/widgets/custom_button.dart';

class DetailProductPage extends StatefulWidget {
  final GroceryItem item;
  const DetailProductPage({super.key, required this.item});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios,size: 20,)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.favorite_border),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                widget.item.imagePath,
                width: double.infinity,
                height: 200,
              )),
              SizedBox(
                height: 50,
              ),
              Text(
                widget.item.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.item.description,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 15,
                    children: [
                      Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xffE2E2E2),
                              )),
                          child: Icon(Icons.remove)),
                      Text(
                        "0",
                        style: TextStyle(fontSize: 17),
                      ),
                      Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xffE2E2E2),
                              )),
                          child: Icon(Icons.add)),
                    ],
                  ),
                  Text(
                    '\$${widget.item.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Divider(),
              ExpansionTile(
                title: Text("Product Details"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Apples are nutritious. Apples may be good for weight loss. Apples may be good for your heart.",
                    ),
                  )
                ],
              ),
              ListTile(
                title: Text("Nutritions"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Reviews"),
                trailing: Row(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          5,
                          (index) => Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 20,
                              )),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(label: 'Add to Basket', onPressed: () {}),
      ),
    );
  }
}
