import 'package:intl/intl.dart';
import 'package:socialpolice/src/utils/constants.dart';
import 'package:socialpolice/src/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateUtil {
  static bool isTokenExpired(String expiry) {
    try {
      final expiryDate = DateUtil.parse(expiry);
      final now = DateTime.now();
      final difference = expiryDate.difference(now).inHours;
      return difference <= 1;
    } catch (e) {
      Utils.log(e);
      return true;
    }
  }

  static String timeUntil(DateTime date) {
    var locale = 'en';
    return timeago.format(date, locale: locale, allowFromNow: true);
  }

  static String amPm(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static DateTime parseDateTime(dynamic value, [DateTime? defaultValue]) {
    if (Utils.isEmptyOrNull(value)) return defaultValue!;
    return DateUtil.parse(value);
  }

  static String getReadableDate(String dateString, {String locale = 'en'}) {
    return formatDateTimeString(dateString, "d MMM, yyyy.", locale: locale);
  }

  static String getReadableDateAndTime(String dateString,
      {String locale = 'en'}) {
    return formatDateTimeString(dateString, "d MMM, yyyy HH:mm",
        locale: locale);
  }

  static DateTime parseDateTimeString(String dateString,
      {String? sourceFormat}) {
    const List<String> possibleFormats = const [
      Constants.DEFAULT_TIMESTAMP_FORMAT,
      'yyyy-MM-dd',
      'dd MMM yyyy',
      'yyyy-MM-dd HH:mm:ss.SSS',
      'yyyy-MM-dd HH:mm:ss.SSSS',
      'yyyy-MM-ddTHH:mm:ss',
      'yyyy-MM-dd"T"HH:mm:ss"Z"',
      'MMM dd, yyyy hh:mm:ss a',
    ];

    // initializeDateFormatting('en');

    if (sourceFormat != null) {
      // use that format instead
      return DateFormat(sourceFormat).parseUTC(dateString);
    }

    // try local parsing
    if (dateString.contains('T')) {
      try {
        return DateTime.parse(dateString);
      } catch (e) {
        // Utils.log('DATE => ' + e.toString());
      }
    }

    for (var possibleFormat in possibleFormats) {
      try {
        return DateFormat(possibleFormat).parseUTC(dateString);
      } catch (e) {
        // Utils.log('DATE => ' + e.toString());
      }
    }
    Utils.log('Date format not in possible dates formats array: $dateString');
    return DateTime.now();
  }

  static DateTime parse(dynamic object, {String? format}) {
    if (object is String) {
      return parseDateTimeString(object, sourceFormat: format);
    }

    if (object is int) {
      return parseEpoch(object);
    }

    return DateTime.now();
  }

  static String formatDateTimeString(String dateString, String format,
      {String locale = 'en'}) {
    final parsedDate = parseDateTimeString(dateString);
    return parsedDate != null
        ? DateFormat(format, locale).format(parsedDate)
        : '';
  }

  static DateTime parseEpoch(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds * 1000);
  }

  static String formatDateTime(DateTime date,
      {String format = Constants.DEFAULT_TIMESTAMP_FORMAT,
      String locale = 'en',
      bool dateAgo = false}) {
    // show today, yesterday ...
    if (dateAgo) {
      var now = DateTime.now();
      if (date.day == now.day &&
          date.month == now.month &&
          date.year == now.year) {
        return 'Today';
      }
      var yesterday = DateTime.now().subtract(const Duration(days: 1));
      if (date.day == yesterday.day &&
          date.month == yesterday.month &&
          date.year == yesterday.year) {
        return 'Yesterday';
      }
    }

    // change the format o to the day number suffix if any
    if (format.contains('do')) {
      format = format.replaceAll('do', '_');
    }
    var formattedString = DateFormat(format, locale).format(date);

    // change the format o to the day number suffix if any
    if (formattedString.contains('_')) {
      var daySuffix = Utils.getNumberSuffix(date.day);
      formattedString = formattedString.replaceAll('_', daySuffix);
    }
    return formattedString;
  }

  static int toUnixTimestamp(DateTime dateTime) {
    return (dateTime.millisecondsSinceEpoch / 1000).ceil();
  }

  static String getOnlyTimeFromDate(DateTime date) {
    return DateFormat.Hms().format(date);
  }

  static bool isInSameMinute(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day &&
        date1.hour == date2.hour &&
        date1.minute == date2.minute;
  }

  ///
  /// strips off the time from a DateTime
  ///
  static DateTime stripOffTimeFromDate(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  ///
  /// converts a duration to time format mm:ss
  ///
  static String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

///
/// DATETIME EXTENSIONS
///

extension DateTimeExtension on DateTime {
  int get unixTimestamp => DateUtil.toUnixTimestamp(this);
}
