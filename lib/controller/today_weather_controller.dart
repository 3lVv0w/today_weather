import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/models/weather_data.dart';

class TodayWeatherController {
  bool? _isServiceNotEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  Location location = Location();
  Dio dio = Dio();

  String? message;

  Future<Map<String, dynamic>?> loadWeather() async {
    String apiKey = dotenv.env["API_KEY"]!;
    print('1');

    try {
      _isServiceNotEnabled = await location.serviceEnabled();
      if (!_isServiceNotEnabled!) {
        _isServiceNotEnabled = await location.requestService();
        if (!_isServiceNotEnabled!) {
          return null;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      _locationData = await location.getLocation();

      print(_locationData);

      final double? lat = _locationData!.latitude;
      final double? lon = _locationData!.longitude;
      // TODO: add Await to each function here to get the number print in the order
      WeatherData? weatherData = await _fetchAndSetWeatherData(apiKey, lat, lon);
      ForecastData? forecastData = await _fetchAndSetForcastingData(apiKey, lat, lon);

      print('4');

      return {
        "message": message,
        "code": 200,
        "weatherData": weatherData,
        "forecastData": forecastData,
      };
    } on PlatformException catch (e, _) {
      print("land");
      if (e.code == 'PERMISSION_DENIED') {
        message = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        message = 'Permission denied - please ask the user to enable it from the app settings';
      }

      _locationData = null;

      return {
        "message": message,
        "code": 500,
        "weatherData": null,
        "forecastData": null,
      };
    }
  }

  Future<WeatherData?> _fetchAndSetWeatherData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    print('2');
    final weatherResponse = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?appid=$apiKey&lat=${lat.toString()}&lon=${lon.toString()}',
    );
    if (weatherResponse.statusCode == 200) {
      return WeatherData.fromJson(weatherResponse.data);
    } else {
      print(weatherResponse.statusCode);
      return null;
    }
  }

  Future<ForecastData?> _fetchAndSetForcastingData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    print('3');
    final forecastResponse = await dio.get(
      'https://api.openweathermap.org/data/2.5/forecast?appid=$apiKey&lat=${lat?.toString()}&lon=${lon?.toString()}',
    );
    if (forecastResponse.statusCode == 200) {
      return ForecastData.fromJson(forecastResponse.data);
    } else {
      print(forecastResponse.statusCode);
      return null;
    }
  }
}
