import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';
import 'package:weather_app/features/getting_weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/getting_weather/domain/usecases/get_weather_data_by_cityname.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

GetWeatherDataByCityName useCase;
MockWeatherRepository mockWeatherRepository;

void main() {
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    useCase = GetWeatherDataByCityName(mockWeatherRepository);
  });
  
  final tWeather = Weather(
    temprature: 38,
    description: 'clear',
    cityName: 'cairo',
  );

  test(
    'make sure that usecase will return weather instance',
    () async {
      when(mockWeatherRepository.getWeatherByCityName(any))
          .thenAnswer((_) async => Right(tWeather));
      
      final result = await useCase(CityParams(cityName: 'cairo'));

      expect(result, Right(tWeather));

      verify(mockWeatherRepository.getWeatherByCityName('cairo'));

      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
