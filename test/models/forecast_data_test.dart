import 'package:flutter_test/flutter_test.dart';
import 'package:today_weather/models/forecast_data.dart';

void main() {
  group('ForecastData', () {
    test('fromJson creates ForecastData with correct WeatherData list', () {
      final json = {
        "city": {"name": "Test City"},
        "list": [
          {
            "dt": 1719936000,
            "main": {"temp": 25.5},
            "weather": [
              {"main": "Clear", "icon": "01d"}
            ]
          },
          {
            "dt": 1719946000,
            "main": {"temp": 28.0},
            "weather": [
              {"main": "Clouds", "icon": "02d"}
            ]
          }
        ]
      };

      final forecast = ForecastData.fromJson(json);

      expect(forecast.list.length, 2);
      expect(forecast.list[0]!.name, "Test City");
      expect(forecast.list[0]!.temp, 25.5);
      expect(forecast.list[0]!.main, "Clear");
      expect(forecast.list[0]!.icon, "01d");
      expect(forecast.list[1]!.temp, 28.0);
      expect(forecast.list[1]!.main, "Clouds");
      expect(forecast.list[1]!.icon, "02d");
    });

    test('fromJson handles empty list', () {
      final json = {
        "city": {"name": "Empty City"},
        "list": []
      };

      final forecast = ForecastData.fromJson(json);

      expect(forecast.list, isEmpty);
    });

    // test('fromJson throws if required fields are missing', () {
    //   final json = {
    //     "city": {"name": "Test City"},
    //     "list": [
    //       {
    //         // missing 'dt', 'main', 'weather'
    //       }
    //     ]
    //   };

    //   expect(() => ForecastData.fromJson(json), throwsA(isA<TypeError>()));
    // });
  });
}