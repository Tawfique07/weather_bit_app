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
        body: const Center(
          child: Text("Weather App"),
        ),
        appBar: AppBar(
          title: const Text("Weather App"),
        ),
      ),
    );
  }
}
