import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              texField(),
              button(),
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
    return const Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Enter City Name"),
        ),
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      onPressed: () {
        print("Button Pressed");
        setState(() {});
      },
      child: const Text("Get Weather"),
    );
  }
}
