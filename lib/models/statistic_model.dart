class Statistic {
  final cases;
  final todayCases;
  final deaths;
  final todayDeaths;
  final recovered;

  Statistic({
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered
  });

  factory Statistic.fromJson(Map json) {
    return Statistic(
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered']
    );
  }
}

class StatisticCountry {
  List<StatisticCountryItem> cases;
  List<StatisticCountryItem> deaths;
  List<StatisticCountryItem> recovered;

  StatisticCountry({ this.cases, this.deaths, this.recovered });
}

class StatisticCountryItem {
  final date;
  final number;

  StatisticCountryItem({ this.date, this.number });
}