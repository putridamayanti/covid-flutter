import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class VideoComponent extends StatelessWidget {

  final List videos;

  VideoComponent({ this.videos });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos != null ? videos.length : 0,
      itemBuilder: (context, index) {
        return VideoItemComponent(
          id: videos[index].id,
          title: videos[index].title,
          thumbnail: videos[index].thumbnail,
          channel: videos[index].channel,
          published: videos[index].published,
        );
      },
    );
  }
}

class VideoItemComponent extends StatelessWidget {

  final String id;
  final String title;
  final String thumbnail;
  final String channel;
  final String published;

  VideoItemComponent({ this.id, this.title, this.thumbnail, this.channel, this.published });

  playVideo() {
    return FlutterYoutube.playYoutubeVideoById(
        apiKey: 'AIzaSyDzdN4sWztq5BK3Db-p4w9r3Dk9sSoyxiA',
        videoId: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(thumbnail != null ? thumbnail :
                    'https://dummyimage.com/100x100/ebebeb/a8a8ad&text=No+Image'),
                  fit: BoxFit.cover
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(channel,
                            style: TextStyle(
                                fontStyle: FontStyle.italic
                            ),
                          ),
                        ],
                      ),
                    )
                  )
                ),
                OutlineButton(
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  child: Text('Play', style: TextStyle(color: Colors.teal),),
                    onPressed: () {
                      playVideo();
                    }
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
