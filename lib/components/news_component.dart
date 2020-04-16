import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsComponent extends StatelessWidget {

  final image;
  final title;
  final description;
  final source;
  final published;

  NewsComponent({
    this.image,
    this.title,
    this.description,
    this.source,
    this.published
  });

  @override
  Widget build(BuildContext context) {

    final parseDate = DateTime.parse(published);
    final date = DateFormat.yMMMMd("en_US").format(parseDate);

    return Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Container(
//        height: 120,
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(image != null ? image :
                      'https://dummyimage.com/100x100/ebebeb/a8a8ad&text=No+Image'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 74,
                              child: Text('$title',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                            ),
                            Container(
                              child: Text('$source  -  $date'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
