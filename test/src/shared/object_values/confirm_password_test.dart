import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late ConfirmPassword confirmPassword;
  setUp(() {
    confirmPassword = ConfirmPassword('1234', '1234');
  });
  group('ConfirmPassword ObjectValue ->', () {
    test("don't return errorMessage", () {
      expect(confirmPassword.hasError(), null);
    });

    test('return empty field message', () {
      confirmPassword = ConfirmPassword('', 'a');
      expect(confirmPassword.hasError(), PokedexTexts.requiredField);
    });
    test('return errorMessage', () {
      confirmPassword = ConfirmPassword('1234', '123');
      expect(confirmPassword.hasError(), confirmPassword.errorMessage);
    });
  });
}
