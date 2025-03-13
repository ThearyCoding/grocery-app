import 'package:flutter/material.dart';
import 'package:grocery_app/pages/filter_page.dart';
import 'package:grocery_app/widgets/grocery_card_item_widget.dart';

import '../models/grocery_item.dart';

class CategoryItemsPage extends StatelessWidget {
  final String categoryName;
  const CategoryItemsPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FilterPage())),icon: Icon(Icons.sort)),
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          categoryName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GridView.builder(
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GroceryCardItemWidget(
                item: items[index],
              );
            }),
      ),
    );
  }
}
