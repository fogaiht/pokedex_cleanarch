import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late IValidator validator;
  late String value;
  setUp(() {
    value = 'Thiago Fernandes';
    validator = FullNameValidator();
  });
  group('FullNameValidator ->', () {
    test('isValid', () {
      expect(validator(value), true);
    });

    test("isNotValid - don't have more than 2 names", () {
      value = 'Thiago';
      expect(validator(value), false);
    });
    test("isNotValid - don't have numbers", () {
      value = 'Thiago Fernandes1';
      expect(validator(value), false);
    });
  });
}
