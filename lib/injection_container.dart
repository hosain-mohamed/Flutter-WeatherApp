import 'package:get_it/get_it.dart';
import 'package:weather_app/core/utilities/input_checker.dart';
import 'package:weather_app/features/getting_weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/getting_weather/domain/usecases/get_weather_data_by_cityname.dart';
import 'package:weather_app/features/getting_weather/domain/usecases/get_weather_data_by_location.dart';

import 'core/network/network_info.dart';
import 'features/getting_weather/data/datasources/weather_remote_data_source.dart';
import 'features/getting_weather/domain/repositories/weather_repository.dart';
import 'features/getting_weather/presentation/bloc/bloc/weather_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async{
  //! Features - weather
  //bloc 
  sl.registerFactory(
      () => WeatherBloc(checker: sl(), cityName: sl(), location: sl()));
  //Use Cases 
  sl.registerLazySingleton(() => GetWeatherDataByCityName(sl()));
  sl.registerLazySingleton(() => GetWeatherDataBylocation(sl()));
  // Repository 
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl()));
  // Data sources 
  sl.registerLazySingleton<WeatherRemoteDataSource>(() =>
      WeatherRemoteDataImpl(client: sl(), geolocator: sl()));

  //! core
  sl.registerLazySingleton(() => InputChecker());
  sl.registerLazySingleton<NetworkInfo>(()=> NetworkInfoImpl( dataConnectionChecker: sl()));
  //! External

  //geoLocator
  sl.registerLazySingleton(()=> Geolocator());
  // Client
  sl.registerLazySingleton(()=> http.Client());
  // ConnectionChecker 
  sl.registerLazySingleton(()=> DataConnectionChecker());

}
