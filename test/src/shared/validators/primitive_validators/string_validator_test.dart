import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late IValidator validator;
  late String value;
  setUp(() {
    value = '1';
    validator = StringValidator();
  });
  group('StringValidator ->', () {
    test('isValid', () {
      expect(validator(value), true);
    });

    test('isNotValid - value is empty', () {
      value = '';
      expect(validator(value), false);
    });
  });
}
