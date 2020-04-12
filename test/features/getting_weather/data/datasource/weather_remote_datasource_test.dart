import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/features/getting_weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/getting_weather/data/models/weather_model.dart';

import '../../../../fixtures/json_reader.dart';

class HttpClient extends Mock implements http.Client {}

class MockGeolocator extends Mock implements Geolocator {}

main() {
  HttpClient httpClient;
  WeatherRemoteDataImpl weatherRemoteDataImpl;
  MockGeolocator mockGeolocator;
  setUp(() {
    httpClient = HttpClient();
    mockGeolocator = MockGeolocator();
    weatherRemoteDataImpl =
        WeatherRemoteDataImpl(client: httpClient, geolocator: mockGeolocator);
  });

  final WeatherModel tWeatherModel = WeatherModel.fromJson(
      jsonDecode(convertJsonToString(fileName: 'weather.json')));

  arrangeAvaildResponse() {
    when(httpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async {
      return http.Response(convertJsonToString(fileName: 'weather.json'), 200);
    });
  }

  arrangeUnvalidResponse() {
    when(httpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('error', 404));
  }

  group('get weather by city name ', () {
    final cityName = 'cairo';
    test('shold call http.clinet.get function ', () async {
      arrangeAvaildResponse();

      await weatherRemoteDataImpl.getWeatherByCityName(cityName);

      String link = weatherUrl + 'q=$cityName' + '&appid=$apiKey' + units;

      verify(
          httpClient.get(link, headers: {'Content-Type': 'application/json'}));
    });
    test('shold return weather model from api request t when code 200',
        () async {
      arrangeAvaildResponse();

      final result = await weatherRemoteDataImpl.getWeatherByCityName(cityName);

      expect(result, tWeatherModel);
    });

    test('should throw a Server Exception when status code isn\'t 200',
        () async {
      arrangeUnvalidResponse();
      try {
        await weatherRemoteDataImpl.getWeatherByCityName(cityName);
        fail("exception not thrown");
      } catch (e) {
        expect(e, isA<ServerException>());
      }
    });

    test('check if url for WeatherApi by cityname is right ', () async {
      String url = weatherUrl + 'q=cairo' + '&appid=$apiKey' + units;
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final weatherModel = WeatherModel.fromJson(jsonDecode(response.body));
        print(weatherModel.cityName +
            " " +
            weatherModel.description +
            " " +
            weatherModel.temprature.toString());
      } else {
        print("ServerException url is not right");
      }
    });
  });

  group('get weather by location ', () {
    Position position = Position(latitude: 30, longitude: 30);

    test('should throw LocationDisabledException when service in not enabled',
        () async {
      when(mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async =>false);
      try {
        await weatherRemoteDataImpl.getWeatherBylocation();
        fail('done without exception');
      } catch (e) {
        expect(e, isA<LocationDisabledException>());
      }
    });
   
    test(
        'should return a weather model if locatoin enabled and statud code is right',
        () async {
      when(mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockGeolocator.getCurrentPosition(
              desiredAccuracy: anyNamed("desiredAccuracy")))
          .thenAnswer((_) async => position);
      when(httpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        return http.Response(
            convertJsonToString(fileName: 'weather.json'), 200);
      });
      final result = await weatherRemoteDataImpl.getWeatherBylocation();
      expect(result, equals(tWeatherModel));
    });

    test('should throw server exception when status code isn\'t 200', () async {
      when(mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async =>true);
      when(mockGeolocator.getCurrentPosition(
              desiredAccuracy: anyNamed("desiredAccuracy")))
          .thenAnswer((_) async => position);
      when(httpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('error', 404));
      try {
        await weatherRemoteDataImpl.getWeatherBylocation();
        fail('done without exception');
      } catch (e) {
        expect(e, isA<ServerException>());
      }
    });
    test('check if url for WeatherApi by location is right', () async {
      final latitude = position.latitude;
      final longitude = position.longitude;

      String url = weatherUrl +
          'lat=$latitude&' +
          'lon=$longitude' +
          '&appid=$apiKey' +
          units;

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final weatherModel = WeatherModel.fromJson(jsonDecode(response.body));
        print(weatherModel.cityName +
            " " +
            weatherModel.description +
            " " +
            weatherModel.temprature.toString());
      } else {
        print("ServerException url is not right");
      }
    });
  });
}
