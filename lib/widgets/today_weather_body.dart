import 'package:flutter/material.dart';
import 'package:today_weather/controller/today_weather_controller.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/models/weather_data.dart';
import 'package:today_weather/widgets/current_weather_section.dart';
import 'package:today_weather/widgets/forecast_weather_section.dart';
import 'package:today_weather/widgets/refresh_button.dart';

class TodayWeatherBody extends StatefulWidget {

  const TodayWeatherBody({super.key});

  @override
  State<TodayWeatherBody> createState() => _TodayWeatherBodyState();
}

class _TodayWeatherBodyState extends State<TodayWeatherBody> {
  bool isLoading = false;

  WeatherData? weatherData;

  ForecastData? forecastData;

  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      data = await TodayWeatherController().init();
      if (data != null && data!['code'] == 200) {
        weatherData = data!['weatherData'];
        forecastData = data!['forecastData'];
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CurrentWeather(
                  key: const Key('current_weather_section'),
                  weatherData: weatherData,
                ),
                RefreshButton(
                  key: const Key('refresh_button'),
                  isLoading: isLoading,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    data = await TodayWeatherController().init();
                    if (data != null && data!['code'] == 200) {
                      weatherData = data!['weatherData'];
                      forecastData = data!['forecastData'];
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                ForecaseWeaterSection(
                  key: const Key('forecast_weather_section'),
                  forecastData: forecastData,
                ),
              ],
            );
  }
}