import 'package:flutter/material.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/widgets/weather.dart';

class ForecaseWeaterSection extends StatelessWidget {
  final ForecastData? forecastData;

  const ForecaseWeaterSection({
    super.key,
    this.forecastData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          // height: 200.0,
          child: Visibility(
            visible: forecastData != null,
            child: ListView.builder(
              itemCount: forecastData?.list.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Card(
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Weather(
                    weather: forecastData?.list[index],
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
