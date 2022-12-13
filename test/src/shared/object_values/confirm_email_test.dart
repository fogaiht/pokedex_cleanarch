import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late ConfirmEmail confirmEmail;
  setUp(() {
    confirmEmail = ConfirmEmail('teste@teste.com', 'teste@teste.com');
  });
  group('ConfirmEmail ObjectValue ->', () {
    test("don't return errorMessage", () {
      expect(confirmEmail.hasError(), null);
    });

    test('return empty field message', () {
      confirmEmail = ConfirmEmail('', 'a');
      expect(confirmEmail.hasError(), PokedexTexts.requiredField);
    });
    test('return errorMessage', () {
      confirmEmail = ConfirmEmail('teste@teste.com', 'teste@teste.co');
      expect(confirmEmail.hasError(), confirmEmail.errorMessage);
    });
  });
}
