import 'package:flutter/material.dart';

import '../screens/statistic_screen.dart';
import '../screens/news_screen.dart';
import '../screens/youtube_screen.dart';
import '../screens/twitter_screen.dart';
import '../screens/maps_screen.dart';

class DrawerComponent extends StatefulWidget {
  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {

  List routes = [
    { 'type': 'header', 'title': 'COVID19 Related Social' },
    { 'type': 'menu', 'title': 'Statistic', 'screen': StatisticScreen(), 'path': '/statistic' },
    { 'type': 'menu', 'title': 'News', 'screen': NewsScreen(), 'path': '/news' },
    { 'type': 'menu', 'title': 'Youtube', 'screen': YoutubeScreen(), 'path': '/youtube' },
    { 'type': 'menu', 'title': 'Twitter', 'screen': TwitterScreen(), 'path': '/twitter' },
    { 'type': 'menu', 'title': 'Maps', 'screen': MapsScreen(), 'path': '/maps' },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) {
              if (routes[index]['type'] == 'header') {
                return DrawerHeader(
                  child: Center(
                    child: Text(routes[index]['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                );
              }
              return ListTile(
                title: Text('${routes[index]['title']}'),
                onTap: () {
//                  Navigator.of(context).pushReplacement(MaterialPageRoute(
//                      builder: (context) => routes[index]['screen']
//                  ));
                  Navigator.pushNamed(context, routes[index]['path']);
                },
              );
            }
        )
    );
  }
}
