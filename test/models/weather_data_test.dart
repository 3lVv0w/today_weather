import 'package:flutter_test/flutter_test.dart';
import 'package:today_weather/models/weather_data.dart';

void main() {
  group('WeatherData', () {
    test('fromJson parses valid JSON correctly', () {
      final json = {
        'dt': 1719936000,
        'name': 'London',
        'main': {'temp': 22.5},
        'weather': [
          {'main': 'Clouds', 'icon': '03d'}
        ]
      };

      final weather = WeatherData.fromJson(json);

      expect(weather.date, DateTime.fromMillisecondsSinceEpoch(1719936000 * 1000, isUtc: false));
      expect(weather.name, 'London');
      expect(weather.temp, 22.5);
      expect(weather.main, 'Clouds');
      expect(weather.icon, '03d');
    });

    test('fromJson handles double temperature', () {
      final json = {
        'dt': 1719936000,
        'name': 'Paris',
        'main': {'temp': 18},
        'weather': [
          {'main': 'Rain', 'icon': '10n'}
        ]
      };

      final weather = WeatherData.fromJson(json);

      expect(weather.temp, 18.0);
    });

    test('fromJson throws if weather list is empty', () {
      final json = {
        'dt': 1719936000,
        'name': 'Berlin',
        'main': {'temp': 15.2},
        'weather': []
      };

      expect(() => WeatherData.fromJson(json), throwsA(isA<RangeError>()));
    });

    test('fromJson throws if required fields are missing', () {
      final json = {
        'dt': 1719936000,
        'main': {'temp': 20.0},
        'weather': [
          {'main': 'Clear', 'icon': '01d'}
        ]
      };

      expect(() => WeatherData.fromJson(json), throwsA(isA<TypeError>()));
    });
  });
}