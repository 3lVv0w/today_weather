import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/models/weather_data.dart';
import 'package:today_weather/widgets/current_weather_section.dart';
import 'package:today_weather/widgets/refresh_button.dart';
import 'package:today_weather/widgets/weather.dart';
import 'package:today_weather/widgets/weather_item.dart';

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
  Location location = Location();

  bool? _isServiceNotEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  String? error;

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    loadWeather();
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
                  onPressed: () => loadWeather(),
                ),
                // TODO: Refactor this section into widgets
                SafeArea(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    height: 200.0,
                    child: Visibility(
                      visible: forecastData != null,
                      child: ListView.builder(
                        itemCount: forecastData?.list.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => WeatherItem(
                          weather: forecastData?.list[index],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadWeather() async {
    String apiKey = dotenv.env["API_KEY"]!;
    print('1');
    setState(() {
      isLoading = true;
    });

    try {
      _isServiceNotEnabled = await location.serviceEnabled();
      if (!_isServiceNotEnabled!) {
        _isServiceNotEnabled = await location.requestService();
        if (!_isServiceNotEnabled!) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await location.getLocation();

      error = null;
    } on PlatformException catch (e, stackTrace) {
      print("land");
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      _locationData = null;
    }

    print(_locationData);

    if (_locationData != null) {
      final double? lat = _locationData!.latitude;
      final double? lon = _locationData!.longitude;
      // TODO: add Await to each function here to get the number print in the order
      await _fetchAndSetWeatherData(apiKey, lat, lon);
      await _fetchAndSetForcastingData(apiKey, lat, lon);
    }
    print('4');
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchAndSetWeatherData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    print('2');
    final weatherResponse = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?appid=$apiKey&lat=${lat.toString()}&lon=${lon.toString()}',
    );
    if (weatherResponse.statusCode == 200) {
      return setState(() {
        weatherData = WeatherData.fromJson(weatherResponse.data);
      });
    } else {
      print(weatherResponse.statusCode);
    }
  }

  Future<void> _fetchAndSetForcastingData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    print('3');
    final forecastResponse = await dio.get(
      'https://api.openweathermap.org/data/2.5/forecast?appid=$apiKey&lat=${lat?.toString()}&lon=${lon?.toString()}',
    );
    if (forecastResponse.statusCode == 200) {
      return setState(() {
        forecastData = ForecastData.fromJson(forecastResponse.data);
      });
    } else {
      print(forecastResponse.statusCode);
    }
  }
}
