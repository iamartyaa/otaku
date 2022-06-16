import 'package:flutter/material.dart';
import 'package:otaku/models/categories.dart';

class CategoryItem extends StatelessWidget {
  final Category myCategory;
  CategoryItem(this.myCategory);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        child: Card(
          child: Column(
            children: [
              Image.asset(myCategory.imgUrl),
              Text(myCategory.name),
            ],
          ),
        ),
      ),
    );
  }
}