import 'package:flutter/material.dart';
import 'package:today_weather/widgets/today_weather_body.dart';


class TodayWeather extends StatelessWidget {
  const TodayWeather({super.key});

  // Variables
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        key: Key('today_weather_scaffold'),
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Center(
            child: TodayWeatherBody(
              key: Key('today_weather_body'),
            ),
          ),
        ),
      ),
    );
  }
}

