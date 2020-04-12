import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/getting_weather/presentation/screens/weather_screen.dart';
import 'package:weather_app/core/utilities/size_config.dart';
import 'features/getting_weather/presentation/bloc/bloc/weather_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.initSizeConfig(context);
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xffF6436E),
      ),
      home: BlocProvider(
        child: WeatherScreen(),
        create: (BuildContext context) => sl<WeatherBloc>(),
      ),
    );
  }
}
