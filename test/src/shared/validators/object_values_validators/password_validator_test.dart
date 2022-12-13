import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late IValidator validator;
  late String value;
  setUp(() {
    value = '123456';
    validator = PasswordValidator();
  });
  group('PasswordValidator ->', () {
    test('isValid', () {
      expect(validator(value), true);
    });

    test('isNotValid - value length < 6', () {
      value = '12345';
      expect(validator(value), false);
    });
  });
}
