import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:today_weather/today_weather.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(TodayWeather());
}
