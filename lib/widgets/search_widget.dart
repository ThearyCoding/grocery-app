import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchWidget extends StatefulWidget {
  final void Function()? onTap;
  const SearchWidget({super.key, this.onTap});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color(0xFFF2F3F2), borderRadius: BorderRadius.circular(15)),
        child: Row(
          spacing: 15,
          children: [
            SvgPicture.asset('assets/icons/search_icon.svg'),
            Text(
              'Search Store',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}