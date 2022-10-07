import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:socialpolice/src/model/api_models.dart';
import 'package:socialpolice/src/model/authtoken.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/settings/secured_storage.dart';
import 'package:socialpolice/src/utils/utils.dart';

class AppApi {
  Future makeRequest<T>(String apiBase, ApiRequest apiRequest,
      {externalCall = false, bool rent = true}) async {
    // ignore: prefer_typing_uninitialized_variables
    var request;

    // not a file upload request
    if (apiRequest.file == null) {
      // this checks prevents the addition of the invm url we took from firestore
      // because we sometimes make a call to outside servers,
      // we need to exclude the firestor url
      request = http.Request(
          apiRequest.method!, Uri.parse("$apiBase${apiRequest.path}"));

      var resolvedHeaders = await resolveHeaders(
        apiRequest.headers,
        apiRequest.authTokenType!,
      );
      resolvedHeaders.forEach((key, value) {
        request.headers[key] = value;
      });
      if (apiRequest.body != null && apiRequest.body != "") {
        request.body = apiRequest.body;
      }
      _logRequest(request, apiRequest.body ?? "", apiRequest);
    } else {
      // file upload request
      request = http.MultipartRequest(
          apiRequest.method!, Uri.parse("$apiBase${apiRequest.path}"));

      if (apiRequest.file!.isEmpty) {
        var resolvedHeaders =
            await resolveHeaders(apiRequest.headers, apiRequest.authTokenType!);
        resolvedHeaders.forEach((key, value) {
          request.headers[key] = value;
        });
        Utils.log("value");
        apiRequest.bodyMap!.keys
            .where((k) {
              Utils.log(k);
              return apiRequest.bodyMap![k].isEmpty;
            })
            .toList()
            .forEach(apiRequest.bodyMap!.remove);

        apiRequest.bodyMap!.forEach((key, value) {
          if (key != "attachement") {
            if (key == "reply") {
              Utils.log(key);
              Utils.log(value);
              request.fields[key] = json.encode(value);
            } else {
              Utils.log(key);
              Utils.log(value);
              request.fields[key] = value;
            }
          }
        });
        Utils.log(request);
        Utils.log(request.fields);

        _logRequest(request, basename(""), apiRequest);
      } else {
        for (var i = 0; i < apiRequest.file!.length; i++) {
          // var stream = http.ByteStream(
          //     DelegatingStream.typed(apiRequest.file![i].openRead()));
          // var length = await apiRequest.file![i].length();

          var resolvedHeaders = await resolveHeaders(
              apiRequest.headers, apiRequest.authTokenType!);
          resolvedHeaders.forEach((key, value) {
            request.headers[key] = value;
          });

          http.MultipartFile multipartFile;

          if (rent) {
            multipartFile = await http.MultipartFile.fromPath(
                "image", apiRequest.file![i].path);
          } else {
            // profile
            multipartFile = await http.MultipartFile.fromPath(
                "attachment", apiRequest.file![i].path);
          }

          request.files.add(multipartFile);
          apiRequest.bodyMap!.keys
              .where((k) => apiRequest.bodyMap![k].isEmpty) // filter keys
              .toList() // create a copy to avoid concurrent modifications
              .forEach(apiRequest.bodyMap!.remove);

          apiRequest.bodyMap!.forEach((key, value) {
            if (key != "cached_images") {
              Utils.log(key);
              Utils.log(value);
              request.fields[key] = value;
            }
          });
          Utils.log(request);
          Utils.log(request.fields);

          _logRequest(request, basename(apiRequest.file![i].path), apiRequest);
        }
      }
    }

    try {
      final response = await _client().send(request);

      final String responseBody =
          await response.stream.transform(utf8.decoder).join();

      _logResponse(response, responseBody, "$apiBase${apiRequest.path!}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _logPasredResponse(responseBody);

        var responses = ApiResponse.fromJson(json.decode(responseBody));
        if (responses.hasError) {
          // return with error localization instead
          responses = await _getError(responses.error!.errorCode!,
              message: responses.error!.errorMessage);
        }
        return responses;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        _logPasredResponse(responseBody);
        // return with error localization instead
        var responses =
            await _getError(response.statusCode, message: "Unauthorized");
        return responses;
      } else {
        _logPasredResponse(responseBody);
        var encodedRs = json.decode(responseBody);
        var responses =
            await _getError(response.statusCode, message: encodedRs["message"]);
        return responses;
      }
    } catch (e) {
      if (e is TimeoutException) {
        var tmpResponse = await _getError(100003); // timeout

        return tmpResponse;
      }

      if (e is SocketException) {
        var tmpResponse = await _getError(100002); // couldnt connect
        // if (T == AuthToken) {
        //   Utils.log(tmpResponse.error.errorMessage);
        //   return AuthToken()..setTokenInvalidError(tmpResponse.error.errorMessage);
        // }
        return tmpResponse;
      }

      return _getError(100001);
    }
  }

  /// ### NEW IMPLEMENTATION
  static Future<ApiResponse> _getError(int status, {String? message}) async {
    // get settings cache
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // UserSettings userSettings = UserSettings(prefs);

    message = message ?? 'Something went wrong. Try again';

    // get error from code
    // String errorLocale = userSettings.getAppErrorList().getError('$status', userSettings.getLanguage(), defaultMessage: message);

    BaseError error = BaseError();
    error.errorCode = status;
    error.errorMessage = message;

    ApiResponse apiResponse = ApiResponse();
    apiResponse.status = -1;
    // apiResponse.statusMessage =  message;
    apiResponse.error = error;

    return apiResponse;
  }

  http.Client _client() {
    // hack to allow all https request cert signing - (avoid CERTIFICATE_VERIFY_FAILED exception)
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    // var ioClient = new HttpClient(context: securityContext)
    //     ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    var ioClient = HttpClient(context: securityContext)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        // var host = "https://iam-service-kblk4htkuq-uc.a.run.app";
        // return (host == host);
        return true;
      });
    return IOClient(ioClient);
  }

  void _logRequest(http.BaseRequest request, String jsonBody,
      [ApiRequest? apiRequest]) {
    Utils.log(
        "AppApi: >>>> INFO Request URL: ${request.method} : ${request.url}");
    Utils.log("AppApi: >>>> INFO Request TOKEN: ${apiRequest!.authTokenType}");
    if (!Utils.isEmptyOrNull(jsonBody)) {
      Utils.log("AppApi: >>>> INFO Request Body: $jsonBody");
    }
    request.headers.forEach((key, value) {
      Utils.log("AppApi: >>>> INFO Request Header Parameter: $key = $value");
    });
  }

  void _logResponse(http.StreamedResponse response, String json, String path) {
    response.headers.forEach((key, value) {
      Utils.log("AppApi: <<<< INFO Response Header Parameter: $key = $value");
    });
    Utils.log("AppApi: <<<< INFO Response Status Code: ${response.statusCode}");
    Utils.log("AppApi: <<<< INFO Response URL: $path");
    Utils.log("AppApi: <<<< INFO Response: $json");
  }

  void _logPasredResponse(String parsedResponse) {
    Utils.log("AppApi: <<<< INFO Parsed Response: $parsedResponse");
  }

  // MAKE SURE TO REMOVE THE UTILITY PARAM
  Future<Map<dynamic, dynamic>> resolveHeaders(
      Map<String, String>? includeHeaders, AuthTokenType authTokenType) async {
    SecuredStorage se = SecuredStorage();
    AuthToken userauth = await se.getUserAuthToken();
    AuthToken clientauth = await se.getClientAuthToken();
    final String? bearerToken =
        AuthTokenType.USER == authTokenType ? userauth.value : clientauth.value;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var resolvedheaders = {}
      ..addAll(headers)
      ..addAll(includeHeaders ?? {});
    // remove empty or null values from map ie resolvedheaders
    resolvedheaders.keys
        .where((k) => resolvedheaders[k].isEmpty) // filter keys
        .toList() // create a copy to avoid concurrent modifications
        .forEach(resolvedheaders.remove);

    return resolvedheaders;
  }
}
