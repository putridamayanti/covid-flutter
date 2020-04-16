import 'package:http/http.dart';
import 'dart:convert';

import '../models/youtube_model.dart';

class YoutubeService {
  
  Client client = Client();
  
  Future searchVideo(keyword) async {
    try {
      final response = await client.get('https://www.googleapis.com/youtube/v3/search?part=snippet&'
          'q='+ keyword +'&key=AIzaSyDzdN4sWztq5BK3Db-p4w9r3Dk9sSoyxiA');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['items'].map((item) {
          return Youtube(
              id: item['id']['videoId'],
              title: item['snippet']['title'],
              thumbnail: item['snippet']['thumbnails']['medium']['url'],
              channel: item['snippet']['channelTitle'],
              published: item['snippet']['publishedAt']
          );
        }).toList();
      }
    } catch(error) {
      print(error);
    }
  }
}