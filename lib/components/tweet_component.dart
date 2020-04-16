import 'package:flutter/material.dart';

class TweetComponent extends StatelessWidget {

  final List tweets;

  TweetComponent({ this.tweets });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tweets.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(image: NetworkImage(tweets[index].image))
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(tweets[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(tweets[index].status),
                        )
                      ],
                    ),
                  )
                ),
              ],
            )
          ),
        );
      }
    );
  }
}
