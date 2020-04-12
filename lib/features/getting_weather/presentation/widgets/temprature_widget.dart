import 'package:flutter/material.dart';
import 'package:weather_app/core/utilities/const.dart';
import 'package:weather_app/core/utilities/size_config.dart';
import 'package:weather_app/core/utilities/padding.dart';

class TempratureText extends StatelessWidget {
  final String temperature;
  final String description;

  TempratureText({@required this.temperature, @required this.description, String temprature});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockHeight * 15,
      child: Padding(
        padding: pTempraturePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  temperature,
                  style: kTemperatureTextStyle,
                ),
                Text(
                  temperature == '' ? '' : ' \u2103',
                  style: kDgreeTextStyle,
                ),
              ],
            ),
            Text(description, style: kDescriptionTextStyle),
          ],
        ),
      ),
    );
  }
}
