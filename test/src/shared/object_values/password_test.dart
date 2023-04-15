import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late Password password;
  setUp(() {
    password = Password('123456');
  });
  group('Password ObjectValue ->', () {
    test("don't return errorMessage", () {
      expect(password.hasError(), null);
    });

    test('return empty field message', () {
      password = Password('');
      expect(password.hasError(), PokedexTexts.requiredField);
    });
    test('return errorMessage', () {
      password = Password('123');
      expect(password.hasError(), password.errorMessage);
    });
  });
}
