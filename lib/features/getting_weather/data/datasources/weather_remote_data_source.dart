import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/features/getting_weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherBylocation();
  Future<WeatherModel> getWeatherByCityName(String cityName);
}

const String apiKey = 'ca1efd05391c06bc43f4b3c69dcf842e';
const String weatherUrl = 'http://api.openweathermap.org/data/2.5/weather?';
const String units = '&units=metric';

class WeatherRemoteDataImpl implements WeatherRemoteDataSource {
  http.Client client;
  Geolocator geolocator;

  WeatherRemoteDataImpl({
    @required this.client,
    @required this.geolocator,
  });

  @override
  Future<WeatherModel> getWeatherByCityName(String cityName) async {
    String link = weatherUrl + 'q=$cityName' + '&appid=$apiKey' + units;
    final response =
        await client.get(link, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> getWeatherBylocation() async {
    if (!await geolocator.isLocationServiceEnabled()) {
      throw LocationDisabledException();
    }
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    double latitude = position.latitude;
    double longitude = position.longitude;
    String link = weatherUrl +
        'lat=$latitude&' +
        'lon=$longitude' +
        '&appid=$apiKey' +
        units;
    final response =
        await client.get(link, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
