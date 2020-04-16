import 'dart:convert';
import 'package:covidapiflutter/models/twitter_model.dart';
import 'package:twitter_api/twitter_api.dart';

class TwitterService {

  final twitterOauth = new twitterApi(
      consumerKey: '<YOUR_CONSUMER_API_KEY>',
      consumerSecret: '<YOUR_CONSUMER_SECRET_KEY>',
      token: '<YOUR_TOKEN>',
      tokenSecret: '<YOUR_TOKE_SECRET>'
  );

  Future getTweet() async {
    final response = await twitterOauth.getTwitterRequest('GET', 'search/tweets.json', options: {
      'q' : 'covid',
      'count' : '10',
      'lang' : 'en',
      'exclude_replies' : 'true'
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['statuses'].map((item) {
        return Twitter(
          name: item['user']['name'],
          username: item['user']['screen_name'],
          image: item['user']['profile_image_url'],
          status: item['text'],
          createdAt: item['created_at']
        );
      }).toList();
    }
  }
}
