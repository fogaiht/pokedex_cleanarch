import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late IValidator validator;
  late String value, confirmValue;
  setUp(() {
    value = 'teste@teste.com';
    confirmValue = 'teste@teste.com';

    validator = ConfirmEmailValidator();
  });
  group('ConfirmEmailValidator ->', () {
    test('isValid', () {
      expect(
        (validator as ConfirmEmailValidator).validate(value, confirmValue),
        true,
      );
    });

    test('isNotValid - value != confirmValue', () {
      confirmValue = 'teste@teste.co';
      expect(
        (validator as ConfirmEmailValidator).validate(value, confirmValue),
        false,
      );
    });
    test('isNotValid - value is invalid', () {
      value = 'teste';
      expect(
        (validator as ConfirmEmailValidator).validate(value, confirmValue),
        false,
      );
    });
  });
}
