import '../../contracts/i_validator.dart';

class StringValidator implements IValidator<String> {
  @override
  bool call(value) => validator(value);

  @override
  bool validator(value) => value.isNotEmpty;
}
