import 'package:flutter/material.dart';
import 'package:weather_app/core/utilities/size_config.dart';

class ErrorsWidget extends StatelessWidget {
  final String message;
  ErrorsWidget({@required this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: SizeConfig.blockHeight * 10,
        width: SizeConfig.deviceWidth,
        child: Center(
          child: FittedBox(
            child: Text(message,
                style: TextStyle(
                    fontSize: SizeConfig.blockHeight * 2.8,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
