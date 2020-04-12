import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/utilities/input_checker.dart';

main() {
  InputChecker inputChecker = InputChecker();
  test(
      'return a string when the input is containing [a-z] only',
      () {
        String value = "shs";
        final result = inputChecker.checkOfStringInput(value);
        expect(result,right(value));
      });
test(
      'return a string when the input is containing [A-Z] only',
      () {
        String value = "Shs";
        final result = inputChecker.checkOfStringInput(value);
        expect(result,right('shs'));
      });
  test(
      'return a failure when the input is empty',
      () {
        String value = " ";
        final result = inputChecker.checkOfStringInput(value);
        expect(result,left(InvalidInputFailure()));
      });
  test(
      'return a failure when the input is containing number',
      () {
        String value = "123";
        final result = inputChecker.checkOfStringInput(value);
        expect(result,left(InvalidInputFailure()));
      });

      test(
      'return a failure when the input is containing other char other than [a-z]',
      () {
        String value = ".=)";
        final result = inputChecker.checkOfStringInput(value);
        expect(result,left(InvalidInputFailure()));
      });
}
