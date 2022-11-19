import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

import 'models/weather_model.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  var textFieldController = TextEditingController();
  WeatherModel? weatherModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              texField(),
              button(),
              const Padding(padding: EdgeInsets.all(10)),
              Text(
                  "${weatherModel?.data?[0].appTemp ?? "Enter correct city name"}"),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Weather App"),
        ),
      ),
    );
  }

  Widget texField() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: textFieldController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Enter City Name"),
        ),
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      onPressed: () async {
        weatherModel = await getWeather(textFieldController.text);
        setState(() {});
      },
      child: const Text("Get Weather"),
    );
  }

  getWeather(String city) async {
    final url =
        "http://api.weatherbit.io/v2.0/current?city=$city&key=b9b7ef8a3aca4c6eb8c0482c91f88782";

    try {
      var res = await get(Uri.parse(url));
      if (res.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(res.body));
      }
    } catch (e) {
      return null;
    }
  }
}
