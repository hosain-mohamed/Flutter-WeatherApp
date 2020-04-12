import 'dart:io';

import 'package:flutter/material.dart';

String convertJsonToString({@required String fileName}) {
  return File('test/fixtures/$fileName').readAsStringSync();
}
