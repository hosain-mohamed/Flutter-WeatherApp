import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';

class InputChecker {
  Either<Failure,String> checkOfStringInput(String value) {
    value = value.toLowerCase();
    List<String> values = value.split(" ");
    RegExp expLower = RegExp(r'^[a-z]+$');
    
    for(String val in values){
      if(!expLower.hasMatch(val) ){
        return Left(InvalidInputFailure());
      }
    }
    return Right(value.trim());
  }
}

