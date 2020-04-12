import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/getting_weather/data/models/weather_model.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';

import '../../../../fixtures/json_reader.dart';

void main() {
  final weatherModel =
      WeatherModel(cityName: 'Cairo', temprature: 15, description: 'overcast clouds');
  test('should tell that weatherModel subclass of weather entity', () {
    expect(weatherModel, isA<Weather>());
  });

  group('from json : ', () {
    test('convert json file(integer) to WeatherModel', () {
      final result = WeatherModel.fromJson(
          json.decode(convertJsonToString(fileName: 'weather.json')));
      expect(result, weatherModel);
    });
    test('convert json file(double) to WeatherModel', () {
      final result = WeatherModel.fromJson(
          json.decode(convertJsonToString(fileName: 'weather_double.json')));
      expect(result, weatherModel);
    });
  });
}
