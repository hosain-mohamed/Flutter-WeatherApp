import 'package:flutter/material.dart';
import 'package:weather_app/core/utilities/const.dart';
import 'package:weather_app/core/utilities/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.blockHeight * 5,
        ),
        Container(
          //height: SizeConfig.blockHeight * 20,
          width: SizeConfig.deviceWidth,
          child: Center(
            child: SpinKitChasingDots(
              color : kSearchColor ,
              size : SizeConfig.blockHeight * 7,
            )
          ),
        ),
      ],
    );
  }
}
