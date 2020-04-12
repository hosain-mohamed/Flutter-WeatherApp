import 'package:flutter/material.dart';
import 'package:weather_app/core/utilities/size_config.dart';

const Color kSearchColor = Color(0xffF6436E);

final kInputDecoration = InputDecoration(
  border: InputBorder.none,
  hintText: 'Enter City Name ',
  hintStyle: TextStyle(
    color: Colors.grey[700],
    fontSize: SizeConfig.blockHeight * 2.5
  ),
);

final kInputTextStyle = TextStyle(
  color: Colors.black,
  fontSize: SizeConfig.blockHeight * 2.5
);

final kTemperatureTextStyle = TextStyle(
  fontSize: SizeConfig.blockHeight * 6.5,
  color: Colors.white,
  fontFamily: 'SourceCodePro',
);

final kDgreeTextStyle = TextStyle(
  fontSize: SizeConfig.blockHeight * 2.5,
  color: Colors.white,
);
final kDescriptionTextStyle = TextStyle(
  fontSize: SizeConfig.blockHeight * 2.6,
  color: Colors.white,
  fontWeight: FontWeight.w200,
  letterSpacing: 1
);
final kCityTextStyle = TextStyle(
  fontSize: SizeConfig.blockHeight * 2,
  color: Colors.white,
  fontFamily: 'TitilliumWeb',
);

final kMylocationButtonStyle = TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.blockHeight * 2.4,
          );