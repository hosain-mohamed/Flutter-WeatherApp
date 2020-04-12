import 'package:flutter/material.dart';


import 'package:weather_app/core/utilities/padding.dart';

import 'package:weather_app/core/utilities/size_config.dart';

class CityWidget extends StatelessWidget {
  final String cityName;
  CityWidget({@required this.cityName});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: pTempraturePadding,
        child: FittedBox(
            child: Text(cityName == '' ? ' ' : cityName,
                style: TextStyle(
                  fontSize: SizeConfig.blockHeight * 3.7,
                  color: Colors.white,
                  fontFamily: 'TitilliumWeb',
                ))),
      ),
    );
  }
}
