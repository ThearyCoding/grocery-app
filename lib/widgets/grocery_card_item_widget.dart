import 'package:flutter/material.dart';
import 'package:grocery_app/models/grocery_item.dart';

import '../core/app_colors.dart';

class GroceryCardItemWidget extends StatelessWidget {
  final GroceryItem item;
  const GroceryCardItemWidget({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.all(10),
              width: 180,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xffE2E2E2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Center(
                    child: Image.asset(height: 150, item.imagePath),
                  )),
                   SizedBox(height: 10,),
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                 
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.primaryColor),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
  }
}