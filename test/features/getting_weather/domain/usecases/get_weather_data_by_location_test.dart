import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';
import 'package:weather_app/features/getting_weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/getting_weather/domain/usecases/get_weather_data_by_location.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

MockWeatherRepository mockWeatherRepository;
GetWeatherDataBylocation usecase;
void main() {
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherDataBylocation(mockWeatherRepository);
  });
  final Weather tWeatherData = Weather(
    cityName: 'cairo',
    description: 'clear',
    temprature: 33,
  );

  test('make sure that this use case return a weather instance', () async {
    when(mockWeatherRepository.getWeatherBylocation())
        .thenAnswer((_) async => Right(tWeatherData));

    final result =
        await usecase(NoParams());
    expect(result, Right(tWeatherData));
    verify(mockWeatherRepository.getWeatherBylocation());
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
