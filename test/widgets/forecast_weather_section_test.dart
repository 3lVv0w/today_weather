import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_weather/widgets/forecast_weather_section.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/models/weather_data.dart';
import 'package:today_weather/widgets/weather.dart';

void main() {
  group('ForecaseWeaterSection', () {
    testWidgets('renders nothing when forecastData is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ForecaseWeaterSection(forecastData: null),
              ],
            ),
          ),
        ),
      );

      // Should not find any Card widgets
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('renders list of weather cards when forecastData is provided', (WidgetTester tester) async {
      final forecastData = ForecastData(
        list: [
          WeatherData(name: 'Bangkok', temp: 20, main: 'Sunny', icon: '01d', date: DateTime.now()),
          WeatherData(name: 'Bangkok', temp: 22, main: 'Cloudy', icon: '02d', date: DateTime.now().add(const Duration(hours: 3))),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ForecaseWeaterSection(forecastData: forecastData),
              ],
            ),
          ),
        ),
      );

      // Should find two Card widgets
      expect(find.byType(Card), findsNWidgets(2));
    });

    testWidgets('Weather widget receives correct data', (WidgetTester tester) async {
      final weatherData = WeatherData(name: 'Bangkok', temp: 25, main: 'Rainy', icon: '09d', date: DateTime.now());
      final forecastData = ForecastData(list: [weatherData]);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ForecaseWeaterSection(forecastData: forecastData),
              ],
            ),
          ),
        ),
      );

      // Should find Weather widget
      expect(find.byType(Weather), findsOneWidget);
    });

    testWidgets('ListView is horizontal', (WidgetTester tester) async {
      final forecastData = ForecastData(
        list: [
          WeatherData(name: 'Bangkok', temp: 20, main: 'Sunny', icon: '01d', date: DateTime.now()),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ForecaseWeaterSection(forecastData: forecastData),
              ],
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.scrollDirection, Axis.horizontal);
    });
  });
}