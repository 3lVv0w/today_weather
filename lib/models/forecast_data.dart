import 'package:today_weather/models/weather_data.dart';

class ForecastData {
  final List<dynamic> list;

  ForecastData({
    required this.list,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List? list = [];

    for (dynamic e in json['list']) {
      WeatherData w = WeatherData(
        date: DateTime.fromMillisecondsSinceEpoch(
          e['dt'] * 1000,
          isUtc: false,
        ),
        name: json['city']['name'],
        temp: e['main']['temp'].toDouble(),
        main: e['weather'][0]['main'],
        icon: e['weather'][0]['icon'],
      );
      list.add(w);
    }

    return ForecastData(
      list: list,
    );
  }
}
