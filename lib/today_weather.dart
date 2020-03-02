import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/models/weather_data.dart';
import 'package:today_weather/widgets/weather.dart';
import 'package:today_weather/widgets/weather_item.dart';

class TodayWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodayWeatherState();
}

class TodayWeatherState extends State<TodayWeather> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  Location location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  String error;

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Widget _refreshButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isLoading
          ? CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          : IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: loadWeather,
              color: Colors.white,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: weatherData != null
                          ? Weather(weather: weatherData)
                          : Container(), // Empty container
                    ),
                  ],
                ),
              ),
              _refreshButton(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200.0,
                    child: forecastData != null
                        ? ListView.builder(
                            itemCount: forecastData.list.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => WeatherItem(
                              weather: forecastData.list.elementAt(index),
                            ),
                          )
                        : Container(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  loadWeather() async {
    String apiKey = DotEnv().env['API_KEY'];

    setState(() {
      isLoading = true;
    });

    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.DENIED) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.GRANTED) {
          return;
        }
      }

      _locationData = await location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      _locationData = null;
    }

    if (location != null) {
      final lat = _locationData.latitude;
      final lon = _locationData.longitude;

      _fetchAndSetWeathergData(apiKey, lat, lon);
      _fetchAndSetForcastingData(apiKey, lat, lon);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchAndSetForcastingData(
    String apiKey,
    double lat,
    double lon,
  ) async {
    final forecastResponse = await dio.get(
      'https://api.openweathermap.org/data/2.5/forecast?APPID=$apiKey&lat=${lat.toString()}&lon=${lon.toString()}',
    );
    if (forecastResponse.statusCode == 200) {
      return setState(() {
        forecastData = ForecastData.fromJson(forecastResponse.data);
      });
    } else {
      print(forecastResponse.statusCode);
    }
  }

  Future<void> _fetchAndSetWeathergData(
    String apiKey,
    double lat,
    double lon,
  ) async {
    final weatherResponse = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?APPID=$apiKey&lat=${lat.toString()}&lon=${lon.toString()}',
    );
    if (weatherResponse.statusCode == 200) {
      return setState(() {
        weatherData = WeatherData.fromJson(weatherResponse.data);
      });
    } else {
      print(weatherResponse.statusCode);
    }
  }
}
