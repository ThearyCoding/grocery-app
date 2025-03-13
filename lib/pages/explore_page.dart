import 'package:flutter/material.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/pages/category_items_page.dart';
import 'package:grocery_app/pages/search_sort_page.dart';
import 'package:grocery_app/widgets/search_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Color> gridColors = [
    Color(0xff53B175),
    Color(0xffF8A44C),
    Color(0xffF7A593),
    Color(0xffD3B0E0),
    Color(0xffFDE598),
    Color(0xffB7DFF5),
    Color(0xff836AF6),
    Color(0xffD73B77),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('Find Product',style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SearchWidget(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchSortPage(),));
                },
              ),
              SizedBox(height: 15,),
              Expanded(
                child: GridView.builder(
                  itemCount: categoryItemsDemo.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2), itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryItemsPage(categoryName: categoryItemsDemo[index].name,)));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: gridColors[index % gridColors.length].withValues(alpha: 0.7),width: 1),
                          borderRadius: BorderRadius.circular(18),
                          color: gridColors[index % gridColors.length].withValues(alpha: 0.1)
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              width: 120,
                              height: 120,
                              categoryItemsDemo[index].imagePath),
                            Text(
                              textAlign: TextAlign.center,
                              categoryItemsDemo[index].name,style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),)
                          ],
                        ),
                      ),
                    );
                  }),
              )
            ],
          ),
        ));
  }
}
