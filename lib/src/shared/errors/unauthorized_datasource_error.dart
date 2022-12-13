import '../analytics/error_report.dart';
import '../data/export/shared_data.dart';
import 'datasource_error.dart';

class UnauthorizedDatasourceError extends DataSourceError {
  final bool? isLogout;

  UnauthorizedDatasourceError({
    required String message,
    required StackTrace stackTrace,
    this.isLogout,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          reportTag: '-> UnauthorizationDatasourceError <-',
          indexedCode: IndexedUtilsErrors.unauthorizedDatasourceError,
        ) {
    _errorReport();
    // goToLogin(isLogout: isLogout);
  }

  factory UnauthorizedDatasourceError.fromError(
    dynamic data,
    StackTrace stackTrace,
  ) {
    if (data == null || data.isEmpty || data['message'] == null) {
      throw UnauthorizedDatasourceError(
        stackTrace: stackTrace,
        message: PokedexTexts.unexpectedError,
      );
    } else {
      if (data['path'] != null && data['path'].toString().contains('logout')) {
        throw UnauthorizedDatasourceError(
          stackTrace: stackTrace,
          message: data['message'],
          isLogout: true,
        );
      } else {
        throw UnauthorizedDatasourceError(
          stackTrace: stackTrace,
          message: data['message'],
        );
      }
    }
  }

  void _errorReport() {
    ErrorReport.externalFailureError(
      message,
      stackTrace,
      reportTag!,
      indexedCode!,
    );
  }

  // void goToLogin({bool? isLogout}) {
  //   if (isLogout == true) {
  //     return;
  //   }

  //   if (!(Platform.environment.containsKey('FLUTTER_TEST'))) {
  //     OrbeBotToast.showModalError(
  //       onTapConfirm: () async {
  //         await Future.delayed(const Duration(milliseconds: 300));
  //         Modular.to.pushReplacementNamed(
  //           '/login/',
  //           arguments: {'returning': true},
  //         );
  //       },
  //       errorMessage: message,
  //     );
  //   } else {
  //     debugPrint('Opened OrbeBotToast and sent to LoginPage');
  //   }
  // }
}
