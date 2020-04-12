import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/getting_weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';
import 'package:weather_app/features/getting_weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  WeatherRepositoryImpl(
      {@required this.remoteDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, Weather>> getWeatherByCityName(String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData =
            await remoteDataSource.getWeatherByCityName(cityName);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Weather>> getWeatherBylocation() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getWeatherBylocation();
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on LocationDisabledException {
        return Left(LocationDisabledFailure());
      } on LocationPermessionException {
        return Left(LocationPermessionFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
