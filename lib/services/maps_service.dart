import 'package:http/http.dart';
import 'dart:convert';

import '../models/maps_model.dart';

class MapsService {
  Client client = new Client();

  Future getCountry() async {
    final response = await client.get('https://corona.lmao.ninja/countries?sort=country');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.map((item) {
        var lat = item['countryInfo']['lat'];
        if (lat is String) {
          lat = double.parse(item['countryInfo']['lat']);
        }
        if (lat is int) {
          lat = item['countryInfo']['lat'].toDouble();
        }

        var long = item['countryInfo']['long'];
        if (long is String) {
          long = double.parse(item['countryInfo']['long']);
        }
        if (long is int) {
          long = item['countryInfo']['long'].toDouble();
        }

        return Maps(
          lat: lat,
          long: long,
          country: item['country'],
          cases: item['cases']
        );
      }).toList();
    }
  }
}