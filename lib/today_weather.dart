import 'package:flutter/material.dart';
import 'package:today_weather/controller/today_weather_controller.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/models/weather_data.dart';
import 'package:today_weather/widgets/current_weather_section.dart';
import 'package:today_weather/widgets/forecast_weather_section.dart';
import 'package:today_weather/widgets/refresh_button.dart';

class TodayWeather extends StatefulWidget {
  const TodayWeather({super.key});

  @override
  State<StatefulWidget> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  // Variables
  bool isLoading = false;
  WeatherData? weatherData;
  ForecastData? forecastData;
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      data = await TodayWeatherController().loadWeather();
      if (data != null && data!['code'] == 200) {
        weatherData = data!['weatherData'];
        forecastData = data!['forecastData'];
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // TODO: Refactor this section into widgets
                CurrentWeather(
                  weatherData: weatherData,
                ),
                RefreshButton(
                  isLoading: isLoading,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    data = await TodayWeatherController().loadWeather();
                    if (data != null && data!['code'] == 200) {
                      weatherData = data!['weatherData'];
                      forecastData = data!['forecastData'];
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                // TODO: Refactor this section into widgets
                ForecaseWeaterSection(
                  forecastData: forecastData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
