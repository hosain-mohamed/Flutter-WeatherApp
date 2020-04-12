import 'package:flutter/material.dart';

class SizeConfig {
  static double _deviceWidth;
  static double _deviceHeight;
  static double _safeDeviceWidth;
  static double _safeDeviceHeight;
  static double _blockWidth;
  static double _blockHeight;
  static double _aspectRatio;

  static bool initSizeConfig(BuildContext context) {
    MediaQueryData deviceData = MediaQuery.of(context);
    Size deviceSizeData = deviceData.size;
    _aspectRatio = deviceSizeData.aspectRatio;
    _deviceWidth = deviceSizeData.width;
    _deviceHeight = deviceSizeData.height;
    double horizontalOutsideSafeArea =
        deviceData.padding.left + deviceData.padding.right;
    double verticalOutsideSafeArea =
        deviceData.padding.left + deviceData.padding.right;
    _safeDeviceWidth = _deviceWidth - horizontalOutsideSafeArea;
    _safeDeviceHeight = _deviceHeight - verticalOutsideSafeArea;
    _blockWidth = _deviceWidth / 100;
    _blockHeight = _deviceHeight / 100;
    return true;
  }

  static double  get  deviceWidth => _deviceWidth;
  static double  get  deviceHeight => _deviceHeight;
  static double  get  safeDeviceWidth => _safeDeviceWidth;
  static double  get  safeDeviceHeight => _safeDeviceHeight;
  static double  get  blockWidth => _blockWidth;
  static double  get  blockHeight => _blockHeight;
  static double  get  aspectRatio => _aspectRatio;


}
