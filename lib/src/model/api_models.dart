import 'dart:io';

import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/utils/constants.dart';

class ApiRequest {
  ApiRequest(this.path, this.method,
      {String? body,
      List<File>? file,
      Map<String, String>? headers,
      AuthTokenType authTokenType = AuthTokenType.USER,
      bool encryptBody = true,
      Map<String, dynamic>? bodyMap}) {
    if (headers != null) {
      this.headers = headers;
    }
    this.encryptBody = encryptBody;
    this.authTokenType = authTokenType;
    // this.bodyMap = bodyMap!;

    if (Constants.POST == method) {
      if (file != null) {
        this.file = file;
        this.bodyMap = bodyMap;
        this.body = body;
      } else {
        this.body = body!;
        this.bodyMap = bodyMap;
      }
    }
  }

  String? method;
  String? path;
  String? body;
  Map<String, dynamic>? bodyMap;
  List<File>? file;
  AuthTokenType? authTokenType;
  Map<String, String> headers = {};
  bool? encryptBody;
}

class ApiResponse {
  ApiResponse();

  int? status;
  dynamic? data;
  BaseError? error;
  int? totalPages;

  bool get hasError => error != null;

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? json["statusCode"];
    data = json['data'];

    if (json['error'] != null) {
      error = BaseError.fromJson(json['error']);
    }
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'data': data, 'error': error!.toJson()};
}

class BaseError {
  BaseError();

  String? url;
  int? errorCode;
  String? errorMessage;

  BaseError.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    errorCode = json['error_code'];
    errorMessage = json['message'];
  }

  Map<String, dynamic> toJson() =>
      {'url': url, 'error_code': errorCode, 'error_message': errorMessage};
}
