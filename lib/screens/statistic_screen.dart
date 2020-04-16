import 'package:covidapiflutter/components/drawer_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

import '../services/statistic_service.dart';
import '../models/statistic_model.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {

  Statistic statistic;
  List<LinearItem> global = [];
  List<LinearItem> today = [];
  TextEditingController country = new TextEditingController();

  bool loadingCountry = false;
  var statisticCountry;

  getGlobalStatistic() async {
    final result = await StatisticService().getGlobalStatistic();
    print(result.cases);
    setState(() {
      statistic = result;
      global  = [
        LinearItem(type: 'Cases', number: result.cases),
        LinearItem(type: 'Deaths', number: result.deaths),
        LinearItem(type: 'Recovered', number: result.recovered),
      ];

      today  = [
        LinearItem(type: 'Cases', number: result.todayCases),
        LinearItem(type: 'Deaths', number: result.todayDeaths),
      ];
    });
  }

  searchByCountry() async {
    setState(() {
      loadingCountry = true;
    });
    final result = await StatisticService().getCountryStatistic(country.text);
    print(result);
    setState(() {
      statisticCountry = {
        'cases' : result.cases,
        'deaths' : result.deaths,
        'recovered' : result.recovered
      };
      loadingCountry = false;
    });
  }

  List<Charts.Series<LinearItem, String>> generateDataSeries(data) {
    return [
      Charts.Series<LinearItem, String>(
        id: 'Global Statistic',
        colorFn: (_, __) => Charts.MaterialPalette.teal.shadeDefault,
        domainFn: (LinearItem item, _) => item.type,
        measureFn: (LinearItem item, _) => item.number,
        data: data,
      ),
    ];
  }

  List<Charts.Series<StatisticCountryItem, String>> generateDataGroupSeries() {
    return [
      Charts.Series<StatisticCountryItem, String>(
        id: 'Cases',
        colorFn: (_, __) => Charts.MaterialPalette.teal.shadeDefault,
        fillColorFn: (_, __) => Charts.MaterialPalette.teal.shadeDefault,
        domainFn: (StatisticCountryItem item, _) => item.date,
        measureFn: (StatisticCountryItem item, _) => item.number,
        data: statisticCountry['cases'],
      ),
      Charts.Series<StatisticCountryItem, String>(
        id: 'Deaths',
        colorFn: (_, __) => Charts.MaterialPalette.teal.shadeDefault.lighter,
        fillColorFn: (_, __) => Charts.MaterialPalette.teal.shadeDefault.lighter,
        domainFn: (StatisticCountryItem item, _) => item.date,
        measureFn: (StatisticCountryItem item, _) => item.number,
        data: statisticCountry['deaths'],
      ),
      Charts.Series<StatisticCountryItem, String>(
        id: 'Recovered',
        colorFn: (_, __) => Charts.MaterialPalette.lime.shadeDefault,
        fillColorFn: (_, __) => Charts.MaterialPalette.lime.shadeDefault,
        domainFn: (StatisticCountryItem item, _) => item.date,
        measureFn: (StatisticCountryItem item, _) => item.number,
        data: statisticCountry['recovered'],
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    getGlobalStatistic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistic COVID19'),
      ),
      drawer: DrawerComponent(),
      backgroundColor: Colors.grey.shade200,
      body: statistic != null ? SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: country,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'Search Country',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      searchByCountry();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  )
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: loadingCountry ? 100 : 0,
              child: loadingCountry ? Center(child: CircularProgressIndicator(),) : null,
            ),
            Card(
              margin: EdgeInsets.all(statisticCountry != null ? 15 : 0),
              child: statisticCountry != null ? Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(statisticCountry != null ? 15 : 0),
                    child: Text('Statistic ${country.text}'),
                  ),
                  Container(
                    width: double.infinity,
                    height: statisticCountry != null ? 300 : 0,
                    padding: EdgeInsets.all(5),
                    child: Charts.BarChart(
                      generateDataGroupSeries(),
                      barGroupingType: Charts.BarGroupingType.grouped,
                      behaviors: [
                        Charts.SeriesLegend(
                          position: Charts.BehaviorPosition.bottom,
                          showMeasures: true,
                          measureFormatter: (num value) {
                            return value == null ? '-' : '${value}';
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ) : Container(),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text('GLOBAL STATISTIC'),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    padding: EdgeInsets.all(15),
                    child: Charts.BarChart(
                      generateDataSeries(today),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text('TODAY GLOBAL STATISTIC'),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    padding: EdgeInsets.all(10),
                    child: Charts.BarChart(
                      generateDataSeries(today),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LinearItem {
  final type;
  final number;

  LinearItem({ this.type, this.number });
}