import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:today_weather/models/weather_data.dart';

class Weather extends StatelessWidget {
  final WeatherData? weather;
  final Color? color;

  const Weather({
    super.key,
    this.weather,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          weather?.name ?? '-',
          style: TextStyle(color: color),
        ),
        Text(
          weather?.main ?? '-',
          style: TextStyle(color: color, fontSize: 28.0),
        ),
        Text(
          '${weather?.temp.toString()}°F',
          style: TextStyle(color: color),
        ),
        Image.network(
          'https://openweathermap.org/img/w/${weather?.icon}.png',
        ),
        Text(
          weather?.date != null
              ? DateFormat.yMMMd().format(weather!.date)
              : '-',
          style: TextStyle(color: color),
        ),
        Text(
          weather?.date != null ? DateFormat.Hm().format(weather!.date) : '-',
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
