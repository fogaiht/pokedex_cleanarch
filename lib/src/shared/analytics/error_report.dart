import 'dart:io';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../data/indexed_utils_errors.dart';

class ErrorReport {
  static Future<void> _report(
    dynamic exception,
    StackTrace stackTrace,
    String tag,
    String errorCode,
    bool? showInDebugTest
  ) async {
    print('$errorCode ${tag.split('\n').first}');
    if (Platform.environment.containsKey('FLUTTER_TEST') &&
        showInDebugTest == true) {
      debugPrint('$tag \n$errorCode - $exception');
    }
    if (!(Platform.environment.containsKey('FLUTTER_TEST')) &&
        exception != null) {
      final errorTag = '$errorCode $tag ${exception.toString()}';
      print(tag);
      debugPrintStack(stackTrace: stackTrace);
      // await FirebaseCrashlytics.instance.setCustomKey(
      //   _errorTag,
      //   exception.toString(),
      // );
      // await FirebaseCrashlytics.instance.log(exception.toString());
      // await FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    }
  }

  static Future<void> internalFailureError(
      dynamic exception, StackTrace stackTrace, String tag, String errorCode,
      [bool? showInDebugTest]) async {
    await _report(exception, stackTrace, 'INTERNAL_FAILURE: $tag', errorCode,
        showInDebugTest);
  }

  static Future<void> externalFailureError(
      dynamic exception, StackTrace stackTrace, String tag, String errorCode,
      [bool? showInDebugTest]) async {
    await _report(exception, stackTrace, 'EXTERNAL_FAILURE: $tag', errorCode,
        showInDebugTest);
  }

  static Future<void> zonedGuardedError(
      dynamic exception, StackTrace stackTrace, String errorCode,
      [bool? showInDebugTest]) async {
    await _report(
        exception, stackTrace, 'ZONED_GUARDED', errorCode, showInDebugTest);
  }

  static Future<void> flutterError(FlutterErrorDetails errorDetails,
      [bool? showInDebugTest]) async {
    await _report(
      errorDetails.exception,
      errorDetails.stack ?? StackTrace.current,
      errorDetails.context.toString(),
      IndexedUtilsErrors.flutterError,
      showInDebugTest,
    );
  }
}
