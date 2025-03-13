import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/widgets/custom_checkbox.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<String> categoriesName = [
    "Dairy & Eggs",
    "Fresh Fruits & Vegetables",
    "Cooking Oil",
    "Meat & Fish",
    "Bakery & Snacks",
    "Beverages"
  ];
  final List<String> brandsName = [
    "Individual Collections",
    "Cocola",
    "Ifad",
    "Kazi Farmas",
  ];

  late List<bool> selectedBrands;
  late List<bool> selectedCategories;
  @override
  void initState() {
    super.initState();
    selectedBrands = List.generate(brandsName.length, (index) => false);
    selectedCategories = List.generate(categoriesName.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
        title: Text(
          "Filters",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Color(0xFFF2F3F2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoriesName.length,
              itemBuilder: (context, index) {
                return Row(
                  spacing: 10,
                  children: [
                    CustomCheckbox(
                        isChecked: selectedCategories[index],
                        onChanged: (value) {
                          setState(() {
                            selectedCategories[index] = value!;
                          });
                        }),
                    Text(
                      categoriesName[index],
                      style: TextStyle(
                        color: selectedCategories[index]
                            ? AppColors.primaryColor
                            : Colors.grey.shade700,
                        fontSize: 18,
                      ),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Brands",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: brandsName.length,
              itemBuilder: (context, index) {
                return Row(
                  spacing: 10,
                  children: [
                    CustomCheckbox(
                        isChecked: selectedBrands[index],
                        onChanged: (value) {
                          setState(() {
                            selectedBrands[index] = value!;
                          });
                        }),
                    Text(
                      brandsName[index],
                      style: TextStyle(
                        color: selectedBrands[index]
                            ? AppColors.primaryColor
                            : Colors.grey.shade700,
                        fontSize: 18,
                      ),
                    )
                  ],
                );
              },
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff53B176),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
