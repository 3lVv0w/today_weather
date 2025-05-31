import 'package:alchemist/alchemist.dart';
import 'package:today_weather/models/weather_data.dart';
import 'package:today_weather/widgets/weather.dart';

void main() {

  final weatherData = WeatherData(
    name: 'London',
    main: 'Cloudy',
    temp: 72,
    icon: '10d',
    date: DateTime(2024, 6, 10, 15, 30),
  );
  goldenTest(
    'WeatherWidget golden test',
    fileName: 'weather_widget_default',
    builder: () => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          name: 'Default Weather',
          child: Weather(
            weather: weatherData,
          ),
        ),
      ],
    ),
  );
}