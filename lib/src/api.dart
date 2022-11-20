import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/weather_model.dart';

getWeatherByLoc(String? lat, String? lon) async {
  var url =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=627930ee2bd20cdd5c3c05f2a9d8c512&units=metric";
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    }
  } catch (ex) {
    return null;
  }
}

getWeatherByCity(String? city) async {
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=627930ee2bd20cdd5c3c05f2a9d8c512&units=metric";
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    }
  } catch (ex) {
    return null;
  }
}
