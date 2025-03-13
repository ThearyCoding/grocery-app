import 'package:flutter/material.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/models/grocery_item.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Favorite",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Container(
                      height: 100,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Image.asset(beverages[index].imagePath),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    beverages[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    beverages[index].description,
                                    style: TextStyle(fontSize: 14,color:Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            spacing: 10,
                            children: [
                              Text(
                                "\$${beverages[index].price.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 17),
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => Padding(
                        padding: EdgeInsets.all(15),
                        child: Divider(),
                      ),
                  itemCount: beverages.length),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Add all to cart",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ))),
        ));
  }
}
