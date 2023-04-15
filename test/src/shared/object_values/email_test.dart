import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late Email email;
  setUp(() {
    email = Email('teste@teste.com');
  });
  group('Email ObjectValue ->', () {
    test("don't return errorMessage", () {
      expect(email.hasError(), null);
    });

    test('return empty field message', () {
      email = Email('');
      expect(email.hasError(), PokedexTexts.requiredField);
    });
    test('return errorMessage', () {
      email = Email('teste@123.');
      expect(email.hasError(), email.errorMessage);
    });
  });
}
