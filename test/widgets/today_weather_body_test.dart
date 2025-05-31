// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:today_weather/main.dart' as app;

void main() {
  testWidgets('Can Build app correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();

    await tester.pumpAndSettle();

    final todayWeatherScaffoldKey = find.byKey(const Key("today_weather_scaffold"));
    expect(todayWeatherScaffoldKey, findsOneWidget);

    final todayWeatherBodyKey = find.byKey(const Key("today_weather_body"));
    expect(todayWeatherBodyKey, findsOneWidget);

    final currentWeatherSectionKey = find.byKey(const Key("current_weather_section"));
    expect(currentWeatherSectionKey, findsOneWidget);

    final refreshButtonKey = find.byKey(const Key("refresh_button"));
    expect(refreshButtonKey, findsOneWidget);

    final forecastWeatherSectionKey = find.byKey(const Key("forecast_weather_section"));
    expect(forecastWeatherSectionKey, findsOneWidget);

    await tester.tap(find.byKey(const Key("refresh_button")));
    await tester.pumpAndSettle();
  });
}
