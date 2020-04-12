import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/utilities/input_checker.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';
import 'package:weather_app/features/getting_weather/domain/usecases/get_weather_data_by_cityname.dart';
import 'package:weather_app/features/getting_weather/domain/usecases/get_weather_data_by_location.dart';
part 'weather_event.dart';
part 'weather_state.dart';

const String SERVER_FAILURE_MESSAGE = 'City not found';

const String LOCATION_DISABLED_FAILURE_MESSAGE =
    'Location services is not enabled';
const String LOCATION_PERMESSION_FAILURE_MESSAGE =
    'Location permession is denied';

const String CACHE_FAILURE_MESSAGE = 'No internet Connection';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid city name ';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherDataByCityName getWeatherDataByCityName;
  final GetWeatherDataBylocation getWeatherDataBylocation;
  final InputChecker inputChecker;
  WeatherBloc({
    @required GetWeatherDataByCityName cityName,
    @required GetWeatherDataBylocation location,
    @required InputChecker checker,
  })  : assert(cityName != null),
        assert(location != null),
        getWeatherDataByCityName = cityName,
        getWeatherDataBylocation = location,
        inputChecker = checker;
  @override
  WeatherState get initialState => InitialWeather();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherByCityName) {
      final checkerResult = inputChecker.checkOfStringInput(event.cityName);
      yield* checkerResult.fold(
        (inpurtFailure) async* {
          yield ErrorWeather(errorMessage: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (str) async* {
          yield LoadingWeather();
          final failurOrWeather = await getWeatherDataByCityName(
              CityParams(cityName: event.cityName));
          yield* failurOrWeather.fold((failure) async* {
            String errorMessage = _mapFailureToMessage(failure);
            yield ErrorWeather(errorMessage: errorMessage);
          }, (weather) async* {
            yield LoadedWeather(weather: weather);
          });
        },
      );
    } else if (event is GetWeatherByLocation) {
      yield LoadingWeather();
      final failurOrWeather = await getWeatherDataBylocation(NoParams());
      yield* failurOrWeather.fold((failure) async* {
        String errorMessage = _mapFailureToMessage(failure);
        yield ErrorWeather(errorMessage: errorMessage);
      }, (weather) async* {
        yield LoadedWeather(weather: weather);
      });
    }
  }
}

String _mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure) {
    return SERVER_FAILURE_MESSAGE;
  } else if (failure is CacheFailure) {
    return CACHE_FAILURE_MESSAGE;
  } else if (failure is LocationDisabledFailure) {
    return LOCATION_DISABLED_FAILURE_MESSAGE;
  } else if (failure is LocationPermessionFailure) {
    return LOCATION_PERMESSION_FAILURE_MESSAGE;
  } else if (failure is InvalidInputFailure) {
    return INVALID_INPUT_FAILURE_MESSAGE;
  } else {
    return "Un Expected Error";
  }
}
