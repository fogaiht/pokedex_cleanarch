import '../data/extensions.dart';
import '../data/pokedex_texts.dart';
import 'datasource_error.dart';

class MapperError extends DataSourceError {
  final String errorMessage;
  final String mapperName;

  MapperError({
    required String errorCode,
    required StackTrace stackTrace,
    required this.errorMessage,
    required this.mapperName,
    bool? showInDebugTest,
  }) : super(
          message: PokedexTexts.unexpectedErrorCode.errorCode(errorCode),
          stackTrace: stackTrace,
          reportTag: '$errorCode $mapperName -> $errorMessage',
          indexedCode: errorCode,
          showInDebugTest: showInDebugTest,
        );
}
