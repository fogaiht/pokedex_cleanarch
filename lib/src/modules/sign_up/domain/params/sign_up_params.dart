import '../../../../shared/object_values/email.dart';
import '../../../../shared/object_values/fullname.dart';
import '../../../../shared/object_values/password.dart';

class SignUpParams {
  final FullName fullName;
  final Email email;
  final Password password;

  SignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toBodyRequest() => {
        'email': email.value,
        'password': password.value,
        'name': fullName.value,
      };
}
