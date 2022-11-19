import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' show get;

import 'geolocator.dart';
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
  Position? myLocation;
  String cel = '°C';
  String far = '°F';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            inputCity(),
            locationView(),
            viewButton(),
            const Padding(padding: EdgeInsets.all(10)),
            weatherDescription(),
            locationButton(),
          ],
        ),
        appBar: AppBar(
          title: const Center(child: Text("Weather App")),
        ),
      ),
    );
  }

  Widget inputCity() {
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

  Widget viewButton() {
    return ElevatedButton(
      onPressed: () async {
        weatherModel = await getWeather(textFieldController.text);
        setState(() {});
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
      ),
      child: const Text("VIEW WEATHER"),
    );
  }

  Widget weatherDescription() {
    print(weatherModel?.weather?[0].main);
    return Text(
        // ignore: unnecessary_string_interpolations
        "${weatherModel?.weather?[0].main ?? "Enter correct city name"}");
  }

  Widget locationButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        myLocation = await getLocation();
        setState(() {});
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.green;
            }
            return Colors.red; // Use the component's default.
          },
        ),
      ),
      icon: const Icon(Icons.my_location),
      label: const Text("LOCATION"),
    );
  }

  Widget locationView() {
    Widget expandText(String text) {
      return Expanded(
        child: Text(
          text,
          textAlign: TextAlign.left,
        ),
      );
    }

    Widget latloc = Row(
      children: [
        expandText("Latitude"),
        expandText("${myLocation?.latitude ?? "Error"}"),
        expandText("Longitude"),
        expandText("${myLocation?.longitude ?? "Error"}"),
      ],
    );
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          latloc,
          const Text(
            "city, country",
          ),
        ],
      ),
    );
  }

  getWeather(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=627930ee2bd20cdd5c3c05f2a9d8c512";

    try {
      var res = await get(Uri.parse(url));
      if (res.statusCode == 200) {
        print(json.decode(res.body));
        return WeatherModel.fromJson(json.decode(res.body));
      }
    } catch (e) {
      return null;
    }
  }
}
