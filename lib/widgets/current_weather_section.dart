import 'package:flutter/material.dart';
import 'package:today_weather/models/weather_data.dart';
import 'package:today_weather/widgets/weather.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherData? weatherData;

  const CurrentWeather({
    super.key,
    this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: weatherData != null,
          child: Weather(weather: weatherData),
        ),
      ),
    );
  }
}
