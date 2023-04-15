import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late IValidator validator;
  late String value, confirmValue;
  setUp(() {
    value = '1234';
    confirmValue = '1234';

    validator = ConfirmPasswordValidator();
  });
  group('ConfirmPasswordValidator ->', () {
    test('isValid', () {
      expect(
        (validator as ConfirmPasswordValidator).validate(value, confirmValue),
        true,
      );
    });

    test('isNotValid - value != confirmValue', () {
      confirmValue = '123';
      expect(
        (validator as ConfirmPasswordValidator).validate(value, confirmValue),
        false,
      );
    });
  });
}
