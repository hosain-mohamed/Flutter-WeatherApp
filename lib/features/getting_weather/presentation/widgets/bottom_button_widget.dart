import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utilities/const.dart';
import 'package:weather_app/core/utilities/size_config.dart';
import 'package:weather_app/features/getting_weather/presentation/bloc/bloc/weather_bloc.dart';

class BottomButton extends StatelessWidget {
  static String cityName = 'shs';
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: SizeConfig.blockHeight * 8,
          child: MaterialButton(
            color: kSearchColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            minWidth: SizeConfig.safeDeviceWidth,
            child: Text(
              'My Weather',
              style: kMylocationButtonStyle,
            ),
            onPressed: () {
               BlocProvider.of<WeatherBloc>(context)
              .add(GetWeatherByLocation());
            },
          ),
        ),
      ),
    );
  }
}
