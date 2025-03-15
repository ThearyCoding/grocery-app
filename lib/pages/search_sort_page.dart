import 'package:flutter/material.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/widgets/grocery_card_item_widget.dart';

class SearchSortPage extends StatefulWidget {
  const SearchSortPage({super.key});

  @override
  State<SearchSortPage> createState() => _SearchSortPageState();
}

class _SearchSortPageState extends State<SearchSortPage> {
  final TextEditingController searchController = TextEditingController();

  void onSearch(String query) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        leadingWidth: 45,
        title: Container(
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200),
          child: TextField(
            onChanged: onSearch,
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search grocery',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(onPressed: () {}, icon: Icon(Icons.close))
                    : null,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sort),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: GridView.builder(
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GroceryCardItemWidget(item: items[index]);
            }),
      ),
    );
  }
}
