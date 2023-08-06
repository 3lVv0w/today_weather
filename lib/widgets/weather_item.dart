import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:today_weather/models/weather_data.dart';

class WeatherItem extends StatelessWidget {
  final WeatherData? weather;

  const WeatherItem({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              weather?.name ?? '-',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              weather?.main ?? '-',
              style: TextStyle(color: Colors.black, fontSize: 24.0),
            ),
            Text(
              '${weather?.temp.toString()}°F',
              style: TextStyle(color: Colors.black),
            ),
            Image.network(
              'https://openweathermap.org/img/w/${weather?.icon}.png',
            ),
            Text(
              weather?.date != null
                  ? DateFormat.yMMMd().format(weather!.date)
                  : '-',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              weather?.date != null
                  ? DateFormat.Hm().format(weather!.date)
                  : '-',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
