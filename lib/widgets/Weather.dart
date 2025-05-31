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
          key: const Key('weather_name'),
          weather?.name ?? '-',
          style: TextStyle(color: color),
        ),
        Text(
          key: const Key('weather_main'),
          weather?.main ?? '-',
          style: TextStyle(color: color, fontSize: 28.0),
        ),
        Text(
          key: const Key('weather_temp'),
          '${weather?.temp ?? '--'}°F',
          style: TextStyle(color: color),
        ),
        Image.network(
          key: const Key('weather_icon'),
          'https://openweathermap.org/img/w/${weather?.icon}.png',
           errorBuilder: (context, error, stackTrace) => 
              const Icon(Icons.error, color: Colors.red, size: 50.0),
        ),
        Text(
          key: const Key('weather_date'),
          weather?.date != null
              ? DateFormat.yMMMd().format(weather!.date)
              : '-',
          style: TextStyle(color: color),
        ),
        Text(
          key: const Key('weather_time'),
          weather?.date != null ? DateFormat.Hm().format(weather!.date) : '-',
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
