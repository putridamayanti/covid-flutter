import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../components/drawer_component.dart';
import '../components/tweet_component.dart';
import '../services/twitter_service.dart';

class TwitterScreen extends StatefulWidget {
  @override
  _TwitterScreenState createState() => _TwitterScreenState();
}

class _TwitterScreenState extends State<TwitterScreen> {

  bool loading = true;
  List tweets = [];

  getTweets() async {
      final result = await TwitterService().getTweet();
      print(result);
      setState(() {
        tweets = result;
        loading = false;
      });
  }

  @override
  void initState() {
    super.initState();

    getTweets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter COVID19'),
      ),
      drawer: DrawerComponent(),
      backgroundColor: Colors.grey.shade200,
      body: loading ? Center(
        child: CircularProgressIndicator(),
      ) : Container(
        child: tweets == null ? Center(
          child: Text('No Data'),
        ) : TweetComponent(tweets: tweets,)
      ),
    );
  }
}
