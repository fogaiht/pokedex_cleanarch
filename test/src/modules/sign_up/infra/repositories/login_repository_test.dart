import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_cleanarch/src/modules/sign_up/sign_up_module.dart';
import 'package:pokedex_cleanarch/src/shared/errors/datasource_error.dart';
import 'package:pokedex_cleanarch/src/shared/object_values/export/object_values.dart';

class SignUpDatasourceMock extends Mock implements ISignUpDatasource {}

class SignUpParamsFake extends Fake implements SignUpParams {}

class SignUpResponseMock extends Mock implements SignUpResponse {}

void main() {
  late SignUpRepository repository;
  late ISignUpDatasource datasource;
  late SignUpParams params;
  late SignUpResponse response;

  setUpAll(() {
    datasource = SignUpDatasourceMock();
    repository = SignUpRepository(datasource);
    params = SignUpParams(
      fullName: FullName('Full Name'),
      password: Password('password'),
      email: Email('notifi@cationo.ken'),
    );
    response = SignUpResponseMock();
    registerFallbackValue(SignUpParamsFake());
  });

  group('SignUpRepository ->', () {
    test('Return an instance of SignUpResponse', () async {
      when(() => datasource(any())).thenAnswer((_) async => response);

      final result = await repository(params);
      expect(result, isA<Right>());
      expect(result.fold(id, id), isA<SignUpResponse>());
      verify(() => datasource(any())).called(1);
    });
    test('Return an error of DataSourceError', () async {
      when(() => datasource(any())).thenThrow(DataSourceError(
        message: 'Error',
        stackTrace: StackTrace.current,
      ));

      final result = await repository(params);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DataSourceError>());
      verify(() => datasource(any())).called(1);
    });
    test('Return an instance of DataSourceError when Exception', () async {
      when(() => datasource(any())).thenThrow(Exception('DataSourceError'));

      final result = await repository(params);
      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<DataSourceError>());
      verify(() => datasource(any())).called(1);
    });
  });
}
