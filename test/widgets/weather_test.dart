import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_weather/widgets/weather.dart';
import 'package:today_weather/models/weather_data.dart';

void main() {
  group('Weather Widget', () {
    testWidgets('displays placeholder when weather is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Weather(),
          ),
        ),
      );

      expect(find.text('-'), findsNWidgets(4)); // name, main, date, time
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('--°F'), findsOneWidget); // Updated: placeholder for temp
    });

    testWidgets('displays weather data correctly', (WidgetTester tester) async {
      final weatherData = WeatherData(
        name: 'London',
        main: 'Cloudy',
        temp: 72.5,
        icon: '10d',
        date: DateTime(2024, 6, 10, 15, 30),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Weather(weather: weatherData),
          ),
        ),
      );

      expect(find.text('London'), findsOneWidget);
      expect(find.text('Cloudy'), findsOneWidget);
      expect(find.text('72.5°F'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Jun 10, 2024'), findsOneWidget);
      expect(find.text('15:30'), findsOneWidget);
    });

    testWidgets('applies custom color', (WidgetTester tester) async {
      final weatherData = WeatherData(
        name: 'Paris',
        main: 'Sunny',
        temp: 80.0,
        icon: '01d',
        date: DateTime(2024, 6, 11, 10, 0),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Weather(weather: weatherData, color: Colors.red),
          ),
        ),
      );

      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      for (final text in textWidgets) {
        // Only check non-null styles
        if (text.style != null && text.style!.color != null) {
          expect(text.style!.color, Colors.red);
        }
      }
    });

    testWidgets('shows correct image url', (WidgetTester tester) async {
      final weatherData = WeatherData(
        name: 'Berlin',
        main: 'Rain',
        temp: 60.0,
        icon: '09n',
        date: DateTime(2024, 6, 12, 8, 0),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Weather(weather: weatherData),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(
        (image.image as NetworkImage).url,
        'https://openweathermap.org/img/w/09n.png',
      );
    });
  });
}