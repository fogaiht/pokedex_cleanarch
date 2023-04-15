import '../../contracts/i_validator.dart';

class NumValidator implements IValidator<num> {
  @override
  bool call(value) => validator(value);

  @override
  bool validator(value) => value >= 0;
}
