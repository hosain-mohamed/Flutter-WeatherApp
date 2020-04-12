import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';

import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeatherBylocation();
  Future<Either<Failure, Weather>> getWeatherByCityName(String cityName);
}
