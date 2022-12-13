import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late IValidator validator;
  late int value;
  setUp(() {
    value = 1;
    validator = NumValidator();
  });
  group('NumValidator ->', () {
    test('isValid', () {
      expect(validator(value), true);
    });

    test('isNotValid - value less than 0', () {
      value = -1;
      expect(validator(value), false);
    });
  });
}
