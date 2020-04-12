part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class InitialWeather extends WeatherState{
  @override
  List<Object> get props => [null];
}
class LoadingWeather extends WeatherState{
  @override
  List<Object> get props => [null];
 
}

class LoadedWeather extends WeatherState{
  final Weather weather ;
  LoadedWeather({@required this.weather});
  @override
  List<Object> get props => [weather];

}

class ErrorWeather extends WeatherState{
  final String errorMessage ;
  ErrorWeather({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
  }