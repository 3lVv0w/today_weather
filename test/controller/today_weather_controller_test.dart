import 'package:flutter_test/flutter_test.dart';
import 'package:today_weather/controller/today_weather_controller.dart';
import 'package:today_weather/models/weather_data.dart';
import 'package:today_weather/models/forecast_data.dart';

import '../utils/mock_today_weather_controller.dart';

void main() {
  group('TodayWeatherController', () {
    late TodayWeatherController controller;

    setUp(() {
      controller = TodayWeatherController();
    });

    test('should create TodayWeatherController instance', () {
      expect(controller, isA<TodayWeatherController>());
    });

    test('MockTodayWeatherController returns mocked data from init', () async {
      final mockController = MockTodayWeatherController();
      final result = await mockController.init();

      expect(result, isA<Map<String, dynamic>>());
      expect(result?['message'], equals('Mocked data'));
      expect(result?['code'], equals(200));
      expect(result?['weatherData'], isA<WeatherData>());
      expect(result?['forecastData'], isA<ForecastData>());
    });

    test('MockTodayWeatherController fetchAndSetWeatherData returns WeatherData', () async {
      final mockController = MockTodayWeatherController();
      final weatherData = await mockController.fetchAndSetWeatherData('dummy', 0, 0);

      expect(weatherData, isA<WeatherData>());
      expect(weatherData?.name, equals('Mock City'));
      expect(weatherData?.main, equals('Sunny'));
      expect(weatherData?.icon, equals('01d'));
    });

    test('MockTodayWeatherController fetchAndSetForcastingData returns ForecastData', () async {
      final mockController = MockTodayWeatherController();
      final forecastData = await mockController.fetchAndSetForcastingData('dummy', 0, 0);

      expect(forecastData, isA<ForecastData>());
      expect(forecastData?.list, isA<List>());
      expect(forecastData?.list.length, equals(0));
    });
  });
}
