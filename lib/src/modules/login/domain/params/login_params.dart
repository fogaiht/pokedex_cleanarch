import '../../../../shared/object_values/email.dart';
import '../../../../shared/object_values/password.dart';

class LoginParams {
  final Email email;
  final Password password;

  LoginParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toBodyRequest() => {
        'email': email.value,
        'password': password.value,
      };

  factory LoginParams.fromJson(Map<String, dynamic> json) => LoginParams(
        email: Email(json['email']),
        password: Password(json['password']),
      );
}
