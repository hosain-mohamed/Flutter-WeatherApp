part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeatherByLocation extends WeatherEvent {
  @override
  List<Object> get props => null;
}

class GetWeatherByCityName extends WeatherEvent {
  final String cityName;
  GetWeatherByCityName({@required this.cityName});

  @override
  List<Object> get props => [cityName];
}
