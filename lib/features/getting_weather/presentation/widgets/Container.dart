import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utilities/const.dart';
import 'package:weather_app/core/utilities/padding.dart';
import 'package:weather_app/core/utilities/size_config.dart';
import 'package:weather_app/features/getting_weather/presentation/bloc/bloc/weather_bloc.dart';

class UpperContiner extends StatefulWidget {
  @override
  _UpperContinerState createState() => _UpperContinerState();
}

class _UpperContinerState extends State<UpperContiner> {
  static String cityName;
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: SizeConfig.blockHeight * 10,
          width: SizeConfig.blockWidth * 82,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
          ),
          child: Center(
            child: Container(
              width: SizeConfig.blockWidth * 50,
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (_) {
              searchCityName();
                },
                controller: controller,
                onChanged: (value) {
                  cityName = value;
                },
                style: kInputTextStyle,
                decoration: kInputDecoration,
              ),
            ),
          ),
        ),
        Container(
          height: SizeConfig.blockHeight * 17,
          width: SizeConfig.blockWidth * 18,
          decoration: BoxDecoration(
            color: kSearchColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(85),
            ),
          ),
          child: FlatButton(
            child: Padding(
                padding: pSearchIconPadding,
                child: LayoutBuilder(builder: (context, constraints) {
                  return Icon(
                    Icons.search,
                    color: Colors.white,
                    size: constraints.biggest.height * 0.5,
                  );
                })),
            onPressed: () {
              searchCityName();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(85),
              ),
            ),
          ),
        )
      ],
    );
  }

  void searchCityName() {
    controller.clear();
    FocusScope.of(context).requestFocus(new FocusNode());
    BlocProvider.of<WeatherBloc>(context)
        .add(GetWeatherByCityName(cityName: cityName));
    
  }
}
