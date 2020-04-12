import 'package:flutter/material.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel(
      {@required int temprature,
      @required String description,
      @required String cityName})
      : super(
            cityName: cityName,
            temprature: temprature,
            description: description);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: json['weather'][0]['description'],
      cityName: json['name'],
      temprature: (json['main']['temp'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'name': cityName,
      'weather': [
        {"description": description}
      ],
      'main': {'temp': temprature}
    };
    return json;
  }
  
}
