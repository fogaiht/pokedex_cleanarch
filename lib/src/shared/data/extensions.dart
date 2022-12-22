import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextExtension on BuildContext {
  double get constSize1 {
    return MediaQuery.of(this).size.height * 0.000981675392670157;
  }

  double get height => (MediaQuery.of(this).size.height);
  double get width => (MediaQuery.of(this).size.width);
  double get statusBarHeight => (MediaQuery.of(this).padding.top);
}

extension MaterialColorGen on Color {
  MaterialColor get genColor {
    return MaterialColor(value, {
      50: tintColor(this, 0.9),
      100: tintColor(this, 0.8),
      200: tintColor(this, 0.6),
      300: tintColor(this, 0.4),
      400: tintColor(this, 0.2),
      500: this,
      600: shadeColor(this, 0.1),
      700: shadeColor(this, 0.2),
      800: shadeColor(this, 0.3),
      900: shadeColor(this, 0.4),
    });
  }

  int _tintValue({required int value, required double factor}) => max(
        0,
        min((value + ((255 - value) * factor)).round(), 255),
      );

  Color tintColor(Color color, double factor) {
    return Color.fromRGBO(
      _tintValue(value: color.red, factor: factor),
      _tintValue(value: color.green, factor: factor),
      _tintValue(value: color.blue, factor: factor),
      1,
    );
  }

  int shadeValue(int value, double factor) {
    return max(0, min(value - (value * factor).round(), 255));
  }

  Color shadeColor(Color color, double factor) {
    return Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1,
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension StringsExtensions on String {
  double? get toDouble => double.tryParse(this);

  String get toCurrency {
    final valueToDouble = double.tryParse(this) ?? 0.0;
    return valueToDouble.toCurrency;
  }

  String get toBase64 {
    final bytes = utf8.encode(this);
    final base64Str = base64.encode(bytes);
    return base64Str;
  }

  String get cleanSpecialCharacters {
    var value = this;
    var comAcento =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var semAcento =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (var i = 0; i < comAcento.length; i++) {
      value = value.replaceAll(comAcento[i], semAcento[i]);
    }

    return value;
  }

  String get firstWord {
    var value = this;
    final list = value.split(' ');

    try {
      return list[0];
    } catch (e) {
      return '';
    }
  }

  bool get toBool => toLowerCase() == 'true';

  String get cleanCpf {
    final value = this;
    return value.replaceAll('.', '').replaceAll('-', '');
  }

  String get capitalizeFirst {
    final value = this;

    return value
        .split(' ')
        .map(
          (str) => '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  String get toPhoneFormatted {
    var value = this;
    return value.length == 8
        ? '${value.substring(0, 4)}-${value.substring(4)}'
        : '${value.substring(0, 5)}-${value.substring(5)}';
  }

  String get normalizeDate {
    final value = this;
    if (value.isEmpty) {
      return '';
    } else {
      DateTime date;

      try {
        date = DateFormat('dd/MM/yy').parse(value);
      } on FormatException {
        return '';
      }

      final valueDay = value.split('/').first;
      final day = date.day < 10 ? '0${date.day}' : date.day.toString();
      final formattedValueDay = valueDay.length == 1 ? '0$valueDay' : valueDay;

      if (formattedValueDay != day) {
        return '';
      }

      var month = date.month.toString();
      month = month.length == 1 ? '0$month' : month;

      return '${date.year}-$month-$day';
    }
  }

  String errorCode(String code) =>
      contains('%s') ? replaceAll('%s', code) : this;
}

extension IntExtensions on int {
  String get normalizeInt => this < 10 ? '0$this' : '$this';
}

extension DateTimeExtensions on DateTime {
  String get formatDateWithHour {
    try {
      return '${day.normalizeInt}/${month.normalizeInt}/$year ${hour.normalizeInt}:${minute.normalizeInt}';
    } catch (e) {
      return '00/00/0000 00:00';
    }
  }

  String get fullDate {
    try {
      return '${day.normalizeInt}/${month.normalizeInt}/$year';
    } catch (e) {
      return '00/00/0000';
    }
  }

  String get formatDate {
    try {
      return '${day.normalizeInt}/${month.normalizeInt}/${year.toString().substring(2)}';
    } catch (e) {
      return '00/00/0000';
    }
  }

  String get formatHour {
    try {
      var newHour = (hour < 10) ? '0$hour' : '$hour';
      var newMinute = (minute < 10) ? '0$minute' : '$minute';

      return '$newHour:$newMinute';
    } catch (e) {
      return '00:00';
    }
  }

  String get formatDateToQueryParams {
    try {
      var newDay = (day < 10) ? '0$day' : '$day';
      var newMonth = (month < 10) ? '0$month' : '$month';

      return '$year-$newMonth-$newDay';
    } catch (e) {
      return '0000-00-00';
    }
  }
}

extension DoubleExt on double {
  String get toCurrency {
    try {
      final formatCurrency = NumberFormat.simpleCurrency(
        decimalDigits: 2,
        locale: 'pt_BR',
      );
      final unicodeSpace = String.fromCharCode(160);

      final value = formatCurrency.format(this).replaceAll(unicodeSpace, ' ');
      return value;
    } catch (e) {
      return 'R\$ -';
    }
  }

  String get thousandFormatted {
    try {
      var formatter = NumberFormat.decimalPattern('pt_BR');
      final value = formatter.format(this);
      return !value.contains(',') ? '$value,00' : value;
    } catch (e) {
      return '-';
    }
  }

  DateTime get toDateTime {
    try {
      var date = DateTime.fromMicrosecondsSinceEpoch(toInt() * 1000).toLocal();

      return date;
    } catch (e) {
      return DateTime(0);
    }
  }
}

class EnumValues<T> {
  Map<String, T> map;
  EnumValues(this.map);
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <Id>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
