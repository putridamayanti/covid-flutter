import 'package:flutter/material.dart';

import '../services/news_service.dart';

import '../components/headline_component.dart';
import '../components/news_component.dart';
import '../components/drawer_component.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  bool loading = true;
  int page = 1;
  List news = [];
  List headlines = [];
  ScrollController scrollController = new ScrollController();

  getHeadlines() async {
    final result = await NewsService().getHeadline();
    print(result);
    setState(() {
      headlines = result;
    });
  }

  getNews() async {
    final result = await NewsService().getNews(page.toString());
    setState(() {
      news = result;
      loading = false;
      page  = page + 1;
    });
  }

  onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentPosition = scrollController.position.pixels;

    if (maxScroll - currentPosition <= 200) {
      getNews();
    }
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(onScroll);

    getHeadlines();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News COVID19'),
      ),
      drawer: DrawerComponent(),
      backgroundColor: Colors.grey.shade200,
      body: loading ? Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: news.length + 1,
          itemBuilder: (context, index) {
            if (index == 0 && headlines.length != 0) {
              return Container(
                height: 300,
                child: HeadlineComponent(headlines: headlines,),
              );
            }

            return NewsComponent(
              image: news[index].image,
              title: news[index].title,
              source: news[index].source,
              published: news[index].published,
              description: news[index].description,
            );
          }
      ),
    );
  }
}
