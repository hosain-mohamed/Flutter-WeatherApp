import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Weather extends Equatable{

final int temprature ;
final String description ;
final String cityName ; 

Weather({@required this.temprature , @required this.description ,@required this.cityName });

  @override
  List<Object> get props => [temprature , description ,cityName];


}