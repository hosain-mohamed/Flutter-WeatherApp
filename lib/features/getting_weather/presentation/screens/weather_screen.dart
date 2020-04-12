import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/getting_weather/presentation/bloc/bloc/weather_bloc.dart';
import 'package:weather_app/features/getting_weather/presentation/widgets/error_widget.dart';
import 'package:weather_app/features/getting_weather/presentation/widgets/loading_widget.dart';
import 'package:weather_app/features/getting_weather/presentation/widgets/temprature_widget.dart';
import 'package:weather_app/core/utilities/size_config.dart';
import 'package:weather_app/features/getting_weather/presentation/widgets/Container.dart';
import 'package:weather_app/features/getting_weather/presentation/widgets/bottom_button_widget.dart';
import 'package:weather_app/features/getting_weather/presentation/widgets/city_text_wdget.dart';


class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: buildBody(),
      ),
    );
  }

  @override
  void initState() {
    
      BlocProvider.of<WeatherBloc>(context)
              .add(GetWeatherByLocation());
    super.initState();
  }
  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      // Continer to make a backroungImage
      child: Container(
        width: SizeConfig.deviceWidth,
        height: SizeConfig.deviceHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/moon.png'),
          fit: BoxFit.cover,
        )),
        // constraints: BoxConstraints.expand(),
        child: buildSafeArea(),
      ),
    );
  }

  SafeArea buildSafeArea() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UpperContiner(),
            ],
          ),
          // Temperature and Description
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (BuildContext context, state) {
              return getTemperatureAndDescription(state);
            },
          ),
          SizedBox(
            height: SizeConfig.blockHeight * 45,
          ),
          // City Name
          BlocBuilder<WeatherBloc, WeatherState>(
            condition: (previousState, state) {
              if (state is ErrorWeather) {
                return false;
              }else {
                return true;
              }
            },
            builder: (BuildContext context, state) {
              return getCityName(state);
            },
          ),
          SizedBox(
            height: SizeConfig.blockHeight * 4,
          ),
          // My location Method
          BottomButton(),
        ],
      ),
    );
  }

  Widget getTemperatureAndDescription(WeatherState state) {
    if (state is InitialWeather) {
      return TempratureText(
        description: '',
        temperature: '',
      );
    } else if (state is ErrorWeather) {
      return ErrorsWidget(message: state.errorMessage);
    } else if (state is LoadedWeather) {
      return TempratureText(
        description: state.weather.description,
        temperature: state.weather.temprature.toString(),
      );
    } else if (state is LoadingWeather) {
      return LoadingWidget();
    } else {
      return ErrorsWidget(message: "Un expected Error");
    }
  }

  Widget getCityName(WeatherState state) {
    if (state is InitialWeather) {
      return CityWidget(cityName: '');
    } else if (state is ErrorWeather) {
      return CityWidget(cityName: '');
    } else if (state is LoadedWeather) {
      return CityWidget(cityName: state.weather.cityName);
    } else if (state is LoadingWeather) {
      return CityWidget(cityName: '');
    } else {
      return ErrorsWidget(message: "Un expected Error");
    }
  }
}
