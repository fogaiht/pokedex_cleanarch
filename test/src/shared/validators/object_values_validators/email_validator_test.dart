import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late IValidator validator;
  late String value;
  setUp(() {
    value = 'teste@teste.com';
    validator = EmailValidator();
  });
  group('EmailValidator ->', () {
    test('isValid', () {
      expect(validator(value), true);
    });

    test('isNotValid - String', () {
      value = 'teste@123.';
      expect(validator(value), false);
    });
  });
}
