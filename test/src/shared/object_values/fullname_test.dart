import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_cleanarch/src/shared/shared_files.dart';

void main() {
  late FullName fullname;
  setUp(() {
    fullname = FullName('Thiago Fernandes');
  });
  group('FullName ObjectValue ->', () {
    test('get First Name', () {
      expect(fullname.firstName, 'Thiago');
    });
    test("don't return errorMessage", () {
      expect(fullname.hasError(), null);
    });

    test('return empty field message', () {
      fullname = FullName('');
      expect(fullname.hasError(), PokedexTexts.requiredField);
    });
    test('return errorMessage', () {
      fullname = FullName('Thiago');
      expect(fullname.hasError(), fullname.errorMessage);
    });
  });
}
