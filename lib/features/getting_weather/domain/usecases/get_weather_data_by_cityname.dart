import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';
import 'package:weather_app/features/getting_weather/domain/repositories/weather_repository.dart';

class GetWeatherDataByCityName extends Usecase<Weather,CityParams>{
  final WeatherRepository weatherRepository ;

  
  GetWeatherDataByCityName(this.weatherRepository);

  @override
  Future<Either<Failure, Weather>> call(CityParams params) async {
    
    return await weatherRepository.getWeatherByCityName(params.cityName);
  }
}

class CityParams extends Equatable{
  CityParams({@required this.cityName});
  final String cityName ;

  @override
  List<Object> get props => [cityName];
}
