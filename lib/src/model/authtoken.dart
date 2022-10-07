import 'package:socialpolice/src/utils/utils.dart';
import 'package:socialpolice/src/utils/utils_date.dart';

class AuthToken {
  String? value = "";
  String? expiration = "";
  String? tokenType = "";
  bool? userBlocked = false;
  String? refreshToken;
  List<dynamic>? scope;

  AuthToken();

  AuthToken.fromJson(Map<String, dynamic> json) {
    value = json['token'];
    expiration = json['expiry'];
    if (json['refreshToken'] != null) {
      refreshToken = json['refreshToken'];
    }
  }

  Map<String, dynamic> toJson() => {
        'token': value,
        'expiry': expiration,
        'token_type': tokenType,
        'refreshToken': refreshToken,
      };

  bool isTokenValid() {
    return !Utils.isEmptyOrNull(value!) &&
        !DateUtil.isTokenExpired(expiration!);
  }
}

class RefreshToken {
  String expiration = "";
  String value = "";

  RefreshToken.fromJson(Map<String, dynamic> json) {
    expiration = json['expiration'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() => {
        'expiration': expiration,
        'value': value,
      };
}

class AdditionalInformation {
  String organization = "";

  AdditionalInformation.fromJson(Map<String, dynamic> json) {
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() => {
        'organization': organization,
      };
}
