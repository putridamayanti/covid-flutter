import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../models/statistic_model.dart';

class StatisticService {

  Client client = Client();
  
  Future getGlobalStatistic() async {
    final response = await client.get('https://corona.lmao.ninja/all');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return Statistic.fromJson(data);
    }
  }

  Future getCountryStatistic(String country) async {
    final response = await client.get('https://corona.lmao.ninja/v2/historical/'+ country +'?lastdays=7');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<StatisticCountryItem> cases = [];
      List<StatisticCountryItem> deaths = [];
      List<StatisticCountryItem> recovered = [];
      await Future.forEach(data['timeline']['cases'].entries, (MapEntry entry) async {
        var statisticItem = StatisticCountryItem(
            date: entry.key,
            number: entry.value
        );
        cases.add(statisticItem);
      });
      await Future.forEach(data['timeline']['deaths'].entries, (MapEntry entry) async {
        var statisticItem = StatisticCountryItem(
            date: entry.key,
            number: entry.value
        );
        deaths.add(statisticItem);
      });
      await Future.forEach(data['timeline']['recovered'].entries, (MapEntry entry) async {
        var statisticItem = StatisticCountryItem(
            date: entry.key,
            number: entry.value
        );
        recovered.add(statisticItem);
      });

      return StatisticCountry(
        cases: cases,
        deaths: deaths,
        recovered: recovered
      );
    }
  }

}