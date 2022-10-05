import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:phone_number/phone_number.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import 'dart:developer' as devlog;

class Utils {
  static bool isEmptyOrNull(Object obj, {bool nullStrings = true}) {
    // return true if obj is null
    if (obj == null) {
      return true;
    }

    // if its a number and is zero
    if (obj is int || obj is double) {
      return obj == 0;
    }

    // if its an empty string
    if (obj is String) {
      return obj.trim() == '';
    }

    // if its an empty array
    if (obj is Iterable) {
      return obj.length == 0;
    }

    return false;
  }

  static bool isBlank(String? string) {
    return string == null || string == "" || string.trim() == "";
  }

  static String formatMoney(double money) {
    final currencyFormat = new NumberFormat("#,##0.00", "en_US");
    return currencyFormat.format(money);
  }

  static String getRandomCharacters(int length) {
    Random _rnd = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static String getInitails(String? text) {
    text = text?.trim();
    if (isEmptyOrNull(text!) || isBlank(text)) return "";

    var item = text.trim();

    try {
      item = item.replaceAll(RegExp("[^a-zA-Z0-9\\s]"), "");

      var initials = StringBuffer();
      if (item.contains(" ")) {
        var parts = item.split(" ");

        initials.write(parts[0][0]); // [0][0]
        initials.write(parts[1][0]); //[1][0]
      } else {
        initials.write(item.substring(0, 2));
      }
      return initials.toString().toUpperCase();
    } catch (e) {
      if (item.isNotEmpty) {
        return item[0].toString() == " " ? "ÀB" : item[0].toString();
      }
    }

    return '-';
  }

  static isProductionMode() {
    // return (Constants.POS_API_BASE_URL == Constants.POS_API_BASE_URL_LIVE);
    return kReleaseMode; // if we built for release
  }

  static log(Object value) {
    if (!isProductionMode()) {
      // print('CONSOLE :: ' + value.toString());
      devlog.log('CONSOLE :: ' + value.toString());
    }
    print('CONSOLE :: ' + value.toString());
  }

  static logAll(Object value) {
    if (!isProductionMode()) {
      final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
      var all = pattern.allMatches(value.toString());
      for (int i = 0; i < all.length; i++) {
        if (i == 0) {
          print('CONSOLE :: ' + all.elementAt(i).group(0).toString());
        } else {
          print(all.elementAt(i).group(0).toString());
        }
      }
    }
  }

  static String generateGUID() {
    return Uuid().v4();
  }

  static String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  static Future<PhoneNumber?> parsePhoneNumber(
      String phone, String? countryCode) async {
    if (Utils.isEmptyOrNull(phone)) {
      return null;
    }

    try {
      final value =
          await PhoneNumberUtil().parse(phone, regionCode: countryCode);
      // var _phone = ParsedPhone.fromJson(value);
      // return _phone;
      return value;
    } catch (e) {}

    return null;
  }

  static String getNumberSuffix(int digit) {
    if (digit >= 11 && digit <= 13) {
      return '${digit}th';
    }

    switch (digit % 10) {
      case 1:
        return '${digit}st';
      case 2:
        return '${digit}nd';
      case 3:
        return '${digit}rd';
      default:
        return '${digit}th';
    }
  }
}
