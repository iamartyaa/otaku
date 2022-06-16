import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyTopAnime {
  final int id;
  final String? title;
  final String? imgUrl;
  final String? trailerUrl;
  final String? titleEnglish;
  final int episodes;
  final int rank;
  MyTopAnime(
      {required this.id,
      required this.episodes,
      required this.imgUrl,
      required this.title,
      required this.titleEnglish,
      required this.trailerUrl,
      required this.rank});
}

class Animes with ChangeNotifier {
  List<MyTopAnime> animes = [];

  Future<void> fetchAndSetAnimes() async {
    final Uri url = Uri.parse("https://api.jikan.moe/v4/top/anime");

    final response = await http.get(url);
    final List<MyTopAnime> loadedAnimes = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    // ignore: unnecessary_null_comparison
    if (extractedData == null) {
      return;
    }
    // print(extractedData["data"][1]["title"]);
    extractedData.forEach(
      (id, data) {
        if (id == "data") {
          for (int i = 0; i < 20; i++) {
            print(data[i]['title']);
            loadedAnimes.add(MyTopAnime(
              id: data[i]['mal_id'],
              episodes: data[i]['episodes'],
              imgUrl: data[i]['images']['jpg']['image_url'],
              title: data[i]['title'],
              titleEnglish: data[i]['title_english'],
              trailerUrl: data[i]['trailer']['url'],
              rank: data[i]['rank'],
            ));
          }
        }
      },
    );
    animes = loadedAnimes;
    print(animes.length);
    notifyListeners();
  }
}
