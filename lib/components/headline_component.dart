import 'package:covidapiflutter/models/news_model.dart';
import 'package:flutter/material.dart';

import '../models/news_model.dart';
class HeadlineComponent extends StatelessWidget {

  final List headlines;

  HeadlineComponent({ this.headlines });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: headlines.length,
        itemBuilder: (context, i) {
          return HeadlineItem(
            title: headlines[i].title,
            image: headlines[i].image,
          );
        }
    );
  }
}

class HeadlineItem extends StatelessWidget {

  final String title;
  final String image;

  HeadlineItem({ this.title, this.image });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image != null ? image :
              'https://dummyimage.com/100x100/ebebeb/a8a8ad&text=No+Image'),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              color: Colors.white.withOpacity(0.9),
              child: Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
