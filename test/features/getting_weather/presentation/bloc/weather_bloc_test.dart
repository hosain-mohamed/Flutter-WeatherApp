import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/utilities/input_checker.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';
import 'package:weather_app/features/getting_weather/domain/usecases/get_weather_data_by_cityname.dart';
import 'package:weather_app/features/getting_weather/domain/usecases/get_weather_data_by_location.dart';
import 'package:weather_app/features/getting_weather/presentation/bloc/bloc/weather_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetWeatherDataByCityName extends Mock
    implements GetWeatherDataByCityName {}

class MockGetWeatherDataByLocation extends Mock
    implements GetWeatherDataBylocation {}

class MockInputChecker extends Mock implements InputChecker {}

main() {
  WeatherBloc weatherBloc;
  MockGetWeatherDataByCityName getWeatherDataByCityName;
  MockGetWeatherDataByLocation getWeatherDataBylocation;
  MockInputChecker inputChecker;

  setUp(() {
    getWeatherDataByCityName = MockGetWeatherDataByCityName();
    getWeatherDataBylocation = MockGetWeatherDataByLocation();
    inputChecker = MockInputChecker();
    weatherBloc = WeatherBloc(
        cityName: getWeatherDataByCityName,
        location: getWeatherDataBylocation,
        checker: inputChecker);
  });

  test('throw assertion error when weatherbloc parameters is equal Null', () {
    try {
      WeatherBloc(cityName: null, location: null, checker: null);
    } catch (e) {
      expect(e, isA<AssertionError>());
    }
  });
  Weather tWeather =
      Weather(cityName: 'cairo', description: 'clear', temprature: 39);
  group('GetWeatherByCityName Event', () {
    String tCityName = "cairo";

    void assumeInputChekerToLeft() {
      when(inputChecker.checkOfStringInput(any))
          .thenReturn(Left(InvalidInputFailure()));
    }

    void assumeInputChekerToRight() {
      when(inputChecker.checkOfStringInput(any)).thenReturn(Right(tCityName));
    }

    blocTest(
      'should call Input Checker method when the event add',
      build: () async {
        assumeInputChekerToLeft();
        return weatherBloc;
      },
      act: (bloc) async {
        return bloc.add(GetWeatherByCityName(cityName: tCityName));
      },
      verify: (bloc) async {
        verify(bloc.inputChecker.checkOfStringInput(tCityName));
      },
    );

    blocTest(
      "should show [error] when input is returns InvalidInputFailure",
      build: () async {
        assumeInputChekerToLeft();
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherByCityName(cityName: tCityName)),
      expect: [ErrorWeather(errorMessage: INVALID_INPUT_FAILURE_MESSAGE)],
    );
    blocTest(
      "should call GetWeatherByCityNameUseCase ",
      build: () async {
        assumeInputChekerToRight();
        when(getWeatherDataByCityName(any))
            .thenAnswer((_) async => Right(tWeather));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherByCityName(cityName: tCityName)),
      verify: (bloc) async {
        verify(getWeatherDataByCityName(CityParams(cityName: tCityName)));
      },
    );
    blocTest("should emit [loadingWeather - LoadedWeather] ",
        build: () async {
          assumeInputChekerToRight();
          when(getWeatherDataByCityName(any))
              .thenAnswer((_) async => Right(tWeather));
          return weatherBloc;
        },
        act: (bloc) => bloc.add(GetWeatherByCityName(cityName: tCityName)),
        expect: [LoadingWeather(), LoadedWeather(weather: tWeather)]);

    blocTest(
        "Should show [loading - Error] when the use case return ServerFailure",
        build: () async {
          assumeInputChekerToRight();
          when(getWeatherDataByCityName(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return weatherBloc;
        },
        act: (bloc) => bloc.add(GetWeatherByCityName(cityName: tCityName)),
        expect: [
          LoadingWeather(),
          ErrorWeather(errorMessage: SERVER_FAILURE_MESSAGE)
        ]);

    blocTest(
        "Should show [loading - Error] when the use case return cacheFailure",
        build: () async {
          assumeInputChekerToRight();
          when(getWeatherDataByCityName(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          return weatherBloc;
        },
        act: (bloc) => bloc.add(GetWeatherByCityName(cityName: tCityName)),
        expect: [
          LoadingWeather(),
          ErrorWeather(errorMessage: CACHE_FAILURE_MESSAGE)
        ]);
  });

  group('GetWeatherByLocation Event', () {

    blocTest(
      "check if getWeatherBylocation is called",
      build: () async {
        when(getWeatherDataBylocation(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherByLocation()),
      verify: (bloc) async{
        verify(getWeatherDataBylocation(NoParams()));
      }
    );
    blocTest(
      "emit [Error] when server exception caught",
      build: () async {
        when(getWeatherDataBylocation(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherByLocation()),
      expect: [
        LoadingWeather(),
        ErrorWeather(errorMessage: SERVER_FAILURE_MESSAGE)
      ],
    );
    blocTest(
      "emit [Error] when LocationDisabled exception caught",
      build: () async {
        when(getWeatherDataBylocation(any))
            .thenAnswer((_) async => Left(LocationDisabledFailure()));

        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherByLocation()),
      expect: [
        LoadingWeather(),
        ErrorWeather(errorMessage: LOCATION_DISABLED_FAILURE_MESSAGE)
      ],
    );
    blocTest(
      "emit [Error] when LocationPermession exception caught",
      build: () async {
        when(getWeatherDataBylocation(any))
            .thenAnswer((_) async => Left(LocationPermessionFailure()));

        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherByLocation()),
      expect: [
        LoadingWeather(),
        ErrorWeather(errorMessage: LOCATION_PERMESSION_FAILURE_MESSAGE)
      ],
    );
    blocTest(
      "emit [Error] when Cache exception caught",
      build: () async {
        when(getWeatherDataBylocation(any))
            .thenAnswer((_) async => Left(CacheFailure()));

        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherByLocation()),
      expect: [
        LoadingWeather(),
        ErrorWeather(errorMessage: CACHE_FAILURE_MESSAGE)
      ],
    );
    blocTest(
      "emit [loaded] when getWeatherbylocation is successfully done ",
      build: () async {
        when(getWeatherDataBylocation(any))
            .thenAnswer((_) async => Right(tWeather));

        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherByLocation()),
      expect: [
        LoadingWeather(),
        LoadedWeather(weather: tWeather),
      ],
    );
  });
}
