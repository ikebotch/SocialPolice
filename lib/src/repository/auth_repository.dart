import 'dart:convert';

import 'package:socialpolice/src/model/api_models.dart';
import 'package:socialpolice/src/model/user.dart';
import 'package:socialpolice/src/network/app_api.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/utils/constants.dart';

class AuthRepository with AppApi {
  String AUTH_BASE_URL = Constants.auth;
  String LOADING_BASE_URL = Constants.user;

  Future<ApiResponse> login(User login) async {
    var apiRequest = ApiRequest(
      "/login",
      Constants.POST,
      authTokenType: AuthTokenType.CLIENT,
      body: json.encode(login.loginToJson()),
    );

    ApiResponse apiResponse = await makeRequest(AUTH_BASE_URL, apiRequest);
    return apiResponse;
  }

  Future<ApiResponse> loading(String username, String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    // brings token, use token to mk phone rquest.
    var apiRequest =
        ApiRequest("/loading/$username", Constants.GET, headers: headers);

    ApiResponse apiResponse = await makeRequest(LOADING_BASE_URL, apiRequest);
    return apiResponse;
  }

  Future<ApiResponse> signup(User signUp) async {
    // brings token, use token to mk phone rquest.
    var apiRequest = ApiRequest(
      "/create",
      Constants.POST,
      authTokenType: AuthTokenType.CLIENT,
      body: json.encode(signUp.toJson()),
    );

    ApiResponse apiResponse = await makeRequest(AUTH_BASE_URL, apiRequest);
    return apiResponse;
  }
}
