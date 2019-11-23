import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/WeatherData.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather.name, style: new TextStyle(color: Colors.white)),
        Text(weather.main,
            style: TextStyle(color: Colors.white, fontSize: 32.0)),
        Text('${weather.temp.toString()}°F',
            style: TextStyle(color: Colors.white)),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
        Text(new DateFormat.yMMMd().format(weather.date),
            style: new TextStyle(color: Colors.white)),
        Text(new DateFormat.Hm().format(weather.date),
            style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
