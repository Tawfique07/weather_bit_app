import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'api.dart';
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
  int? cel;
  String far = '°F';
  String? tempMsg;

  initialize() async {
    myLocation = await getLocation();
    if (myLocation != null) {
      weatherModel = await getWeatherByLoc(
          myLocation?.latitude.toString(), myLocation?.longitude.toString());
    }
    setState(() {});
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: inputCity()),
                Expanded(child: locationButton()),
              ],
            ),
            locationView(),
            Row(
              children: [
                Expanded(
                  child: viewButton(),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.all(10)),
            dateTimeView(),
            const Padding(padding: EdgeInsets.all(10)),
            temperature(),
            weatherDescription(),
            sunsetSunrise(),
          ],
        ),
        appBar: AppBar(
          title: const Center(child: Text("Weather App")),
        ),
      ),
    );
  }

  Widget temperature() {
    var temp = weatherModel?.main?.temp;
    if (weatherModel != null) {
      cel = temp?.round();
      tempMsg = '$cel°C';
    } else {
      tempMsg = 'Invalid City';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Center(
        child: Text(
          '$tempMsg',
          style: const TextStyle(
              height: 1,
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: Colors.black54),
        ),
      ),
    );
  }

  Widget dateTimeView() {
    if (weatherModel == null) {
      return Container();
    }
    var dateTime = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Text(
        "Date & Time: $dateTime",
        style: const TextStyle(
            height: 1,
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: Colors.black54),
      ),
    );
  }

  Widget inputCity() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: textFieldController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
            borderSide: const BorderSide(
              width: 4,
              color: Colors.blue,
            ),
          ),
          label: const Text("Enter City Name"),
          prefixIcon: const Icon(
            Icons.add_location,
            size: 28,
            color: Colors.indigoAccent,
          ),
        ),
      ),
    );
  }

  Widget viewButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.search_sharp, size: 30),
        label: const Text('VIEW WEATHER'),
        onPressed: () async {
          weatherModel = await getWeatherByCity(textFieldController.text);

          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(55),
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget weatherDescription() {
    if (weatherModel == null) {
      return Container();
    }
    Map<String, dynamic> description = {
      "Humidity": weatherModel?.main?.humidity,
      "Pressure": weatherModel?.main?.pressure,
      "Visibility": weatherModel?.visibility,
    };
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Text(
        "Humidity              ${description["Humidity"]}%",
        style: const TextStyle(
            height: 1,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black54),
      ),
    );
  }

  Widget locationButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
      child: ElevatedButton.icon(
        onPressed: () async {
          myLocation = await getLocation();
          if (myLocation != null) {
            weatherModel = await getWeatherByLoc(
                myLocation?.latitude.toString(),
                myLocation?.longitude.toString());
          }
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
          fixedSize: const MaterialStatePropertyAll<Size>(Size.fromHeight(55)),
          textStyle: const MaterialStatePropertyAll<TextStyle>(
            TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        icon: const Icon(Icons.my_location),
        label: const Text("LOCATION"),
      ),
    );
  }

  Widget locationView() {
    if (weatherModel == null) {
      return Container();
    }
    Widget expandText(String text) {
      return Expanded(
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    Widget latloc = Row(
      children: [
        expandText("Latitude"),
        expandText("${weatherModel?.coord?.lat ?? ""}"),
        expandText("Longitude"),
        expandText("${weatherModel?.coord?.lon ?? ""}"),
      ],
    );
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          latloc,
          const Padding(padding: EdgeInsets.all(5)),
          Row(
            children: [
              Text(
                "${weatherModel?.name ?? " "}, ${weatherModel?.sys?.country ?? " "} ",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }

  Widget sunsetSunrise() {
    if (weatherModel == null) {
      return Container();
    }
    formattedText(String time) {
      return Text(
        time,
        style: const TextStyle(
            height: 1,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black54),
      );
    }

    Widget sunrise = Column(
      children: [
        formattedText("Sunrise"),
        const Padding(padding: EdgeInsets.all(10)),
        Image.asset('assets/sunrise.jpg', height: 90, width: 90),
        const Padding(padding: EdgeInsets.all(10)),
        formattedText(timeFormat(weatherModel?.sys?.sunrise ?? 0)),
      ],
    );

    Widget sunset = Column(
      children: [
        formattedText("Sunset"),
        const Padding(padding: EdgeInsets.all(10)),
        Image.asset('assets/sunset.jpg', height: 90, width: 90),
        const Padding(padding: EdgeInsets.all(10)),
        formattedText(timeFormat(weatherModel?.sys?.sunset ?? 0)),
      ],
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: sunrise,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: sunset,
          ),
        ],
      ),
    );
  }

  String timeFormat(timeStamp) {
    final DateTime date1 =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('hh:mm a').format(date1);
  }
}
