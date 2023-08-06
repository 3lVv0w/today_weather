import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:today_weather/models/weather_data.dart';

class Weather extends StatelessWidget {
  final WeatherData? weather;
  final Color? color;

  const Weather({
    super.key,
    required this.weather,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          weather?.name ?? '-',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          weather?.main ?? '-',
          style: TextStyle(color: Colors.white, fontSize: 32.0),
        ),
        Text(
          '${weather?.temp.toString()}°F',
          style: TextStyle(color: Colors.white),
        ),
        Image.network(
          'https://openweathermap.org/img/w/${weather?.icon}.png',
        ),
        Text(
          weather?.date != null
              ? DateFormat.yMMMd().format(weather!.date)
              : '-',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          weather?.date != null ? DateFormat.Hm().format(weather!.date) : '-',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
