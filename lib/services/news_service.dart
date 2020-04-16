import 'package:http/http.dart';
import 'dart:convert';

import '../models/news_model.dart';

class NewsService {

  Client client = Client();

  Future getHeadline() async {
    final response = await client.get('https://newsapi.org/v2/top-headlines?q=COVID&'
        'from=2020-03-16&sortBy=publishedAt&'
        'apiKey=5f6442f7c41b4500819aa4d146df47b1&pageSize=10&page=1&language=en');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'].map((item) {
        return News(
            image: item['urlToImage'],
            title: item['title'],
            description: item['description'],
            source: item['source']['name'],
            published: item['publishedAt']
        );
      }).toList();
    }
  }

  Future getNews(page) async {
    final response = await client.get('https://newsapi.org/v2/everything?q=COVID&'
        'from=2020-03-16&sortBy=publishedAt&apiKey=5f6442f7c41b4500819aa4d146df47b1&pageSize=100&page='+ page +'&language=en');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'].map((item) {
        return News(
            image: item['urlToImage'],
            title: item['title'],
            description: item['description'],
            source: item['source']['name'],
            published: item['publishedAt']
        );
      }).toList();
    }
  }
}