import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/model/artical_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticalModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=54145bc9681c42de9a6cc831aa90502b";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=='ok'){
  jsonData["articles"].forEach((element){
    if(element["urlToImage"]!=null && element['description']!=null){
      ArticalModel articalModel= ArticalModel(
        title: element["title"],
        description: element["description"],
        url: element["url"],
        urlToImage: element["urlToImage"],
        content: element["content"],
        author: element["author"],
      );
      news.add(articalModel);
    }
  });
}
  }
}
