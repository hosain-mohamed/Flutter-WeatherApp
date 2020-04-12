import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/getting_weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/getting_weather/data/models/weather_model.dart';
import 'package:weather_app/features/getting_weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/getting_weather/domain/entities/weather.dart';

class MockRemoteDataSource extends Mock implements WeatherRemoteDataSource {}


class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  WeatherRepositoryImpl mockRepositoryImpl;
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockRepositoryImpl = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
  final tCityName = 'cairo';
 

  final tWeatherModel =
      WeatherModel(temprature: 36, description: 'sunny', cityName: 'cairo');
  final Weather tWeather = tWeatherModel;

  void runTestsOnline(Function body) {
    group('test for online user : ', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async {
          return true;
        });
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('test for offline user : ', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async {
          return false;
        });
      });

      body();
    });
  }

  group('get Weather by cityName', () {
    runTestsOnline(() {
      test('should return remote data and cach it locally', () async {
        when(mockRemoteDataSource.getWeatherByCityName(any))
            .thenAnswer((_) async {
          return tWeatherModel;
        });
        final result = await mockRepositoryImpl.getWeatherByCityName(tCityName);
        verify(mockRemoteDataSource.getWeatherByCityName(tCityName));
        expect(result, Right(tWeather));
      });

      test('should return a server failure when throw a server exception',
          () async {
        when(mockRemoteDataSource.getWeatherByCityName(any))
            .thenThrow(ServerException());
        final result = await mockRepositoryImpl.getWeatherByCityName(tCityName);
        verify(mockRemoteDataSource.getWeatherByCityName(tCityName));
        expect(result, Left(ServerFailure()));
      });
    });
    runTestsOffline(() {
      test('should return cache failure ', () async {
        final result = await mockRepositoryImpl.getWeatherByCityName(tCityName);
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, Left(CacheFailure()));
      });
    });
  });

  group('get weather by location', () {
    runTestsOnline(() {
      test('should return remote data and cach it locally', () async {
        when(mockRemoteDataSource.getWeatherBylocation()).thenAnswer((_) async {
          return tWeatherModel;
        });
        final result = await mockRepositoryImpl.getWeatherBylocation();
        verify(mockRemoteDataSource.getWeatherBylocation());
        expect(result, Right(tWeather));
      });

      test('should return a server failure when throw a server exception',
          () async {
        when(mockRemoteDataSource.getWeatherBylocation())
            .thenThrow(ServerException());
        final result = await mockRepositoryImpl.getWeatherBylocation();
        verify(mockRemoteDataSource.getWeatherBylocation());
        expect(result, Left(ServerFailure()));
      });
    });


  });
}
