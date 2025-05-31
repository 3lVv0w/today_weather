import 'package:today_weather/controller/today_weather_controller.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/models/weather_data.dart';

class MockTodayWeatherController extends TodayWeatherController {
  @override
  Future<Map<String, dynamic>?> init() async {
    return {
      "message": "Mocked data",
      "code": 200,
      "weatherData": WeatherData(
        name: 'Mock City',
        main: 'Sunny',
        temp: 75.0,
        icon: '01d',
        date: DateTime.now(),
      ),
      "forecastData": ForecastData(
        list: [],
      ),
    };
  }

  @override
  Future<WeatherData?> fetchAndSetWeatherData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    return WeatherData(
      name: 'Mock City',
      main: 'Sunny',
      temp: 75.0,
      icon: '01d',
      date: DateTime.now(),
    );
  }

  @override
  Future<ForecastData?> fetchAndSetForcastingData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    return ForecastData(
      list: [],
    );
  }
}