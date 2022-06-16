import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String imgUrl;
  
  Category({required this.id,required this.imgUrl,required this.name});
}

List<Category> categories = [
  Category(id: '1', imgUrl: "assets/images/2.webp", name: 'Top Anime'),
  Category(id: '2', imgUrl: "assets/images/3.webp", name: 'Top Manga'),
  Category(id: '3', imgUrl: "assets/images/4.jpg", name: 'Top Characters'),
  Category(id: '4', imgUrl: "assets/images/1.jpg", name: 'Top People'),
];