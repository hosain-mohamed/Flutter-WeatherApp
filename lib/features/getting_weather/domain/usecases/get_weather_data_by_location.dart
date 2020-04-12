import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';
import 'package:weather_app/features/getting_weather/domain/repositories/weather_repository.dart';

class GetWeatherDataBylocation extends Usecase<Weather, NoParams> {
  final WeatherRepository weatherRepository;
  GetWeatherDataBylocation(this.weatherRepository);

  @override
  Future<Either<Failure, Weather>> call(NoParams params) async {
    return await weatherRepository.getWeatherBylocation( );
  }
}

class NoParams extends Equatable {
  
  @override
  List<Object> get props => [null];
}
