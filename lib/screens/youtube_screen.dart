import 'package:flutter/material.dart';

import '../components/drawer_component.dart';
import '../components/video_component.dart';
import '../services/youtube_service.dart';

class YoutubeScreen extends StatefulWidget {
  @override
  _YoutubeScreenState createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {

  bool loading = true;
  List videos = [];

  getVideos() async {
    final result = await YoutubeService().searchVideo('Covid');
    setState(() {
      videos  = result;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube COVID19'),
      ),
      drawer: DrawerComponent(),
      backgroundColor: Colors.grey.shade200,
      body: loading ? Center(
        child: CircularProgressIndicator(),
      ) : Container(
        child: videos == null ? Center(
          child: Text('No Data'),
        ) : VideoComponent(videos: videos,),
      ),
    );
  }
}
