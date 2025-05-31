
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/models/weather_data.dart';
class TodayWeatherController {
  Dio dio = Dio();

  String? message;

  Future<Map<String, dynamic>?> init() async {
    String apiKey = dotenv.env["API_KEY"]!;

    try {
      const double lat = 13.7563; // Default latitude
      const double lon = 100.5018; // Default longitude

      WeatherData? weatherData = await fetchAndSetWeatherData(apiKey, lat, lon);
      ForecastData? forecastData = await fetchAndSetForcastingData(apiKey, lat, lon);

      return {
        "message": message,
        "code": 200,
        "weatherData": weatherData,
        "forecastData": forecastData,
      };
    } catch (e, _) {

      return {
        "message": e.toString(),
        "code": 500,
        "weatherData": null,
        "forecastData": null,
      };
    }
  }

  Future<WeatherData?> fetchAndSetWeatherData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    final weatherResponse = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?appid=$apiKey&lat=${lat.toString()}&lon=${lon.toString()}',
    );
    if (weatherResponse.statusCode == 200) {
      return WeatherData.fromJson(weatherResponse.data);
    } else {
      return null;
    }
  }

  Future<ForecastData?> fetchAndSetForcastingData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    final forecastResponse = await dio.get(
      'https://api.openweathermap.org/data/2.5/forecast?appid=$apiKey&lat=${lat?.toString()}&lon=${lon?.toString()}',
    );
    if (forecastResponse.statusCode == 200) {
      return ForecastData.fromJson(forecastResponse.data);
    } else {
      return null;
    }
  }
}