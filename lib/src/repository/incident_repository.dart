import 'dart:convert';

import 'package:socialpolice/src/model/api_models.dart';
import 'package:socialpolice/src/model/incident.dart';
import 'package:socialpolice/src/network/app_api.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/utils/constants.dart';

class IncidentRepository with AppApi {
  String INCIDENT_BASE_URL = Constants.incident;

  Future<ApiResponse> postIncident(Incident incident, String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var apiRequest = ApiRequest(
      "",
      Constants.POST,
      headers: headers,
      authTokenType: AuthTokenType.CLIENT,
      body: json.encode(incident.toJson()),
    );

    ApiResponse apiResponse = await makeRequest(INCIDENT_BASE_URL, apiRequest);
    return apiResponse;
  }

  Future<ApiResponse> getIncidentByUsername(
      String username, String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    // brings token, use token to mk phone rquest.
    var apiRequest = ApiRequest("/$username", Constants.GET, headers: headers);

    ApiResponse apiResponse = await makeRequest(INCIDENT_BASE_URL, apiRequest);
    return apiResponse;
  }

  Future<ApiResponse> getIncidentByID(String id, String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    // brings token, use token to mk phone rquest.
    var apiRequest = ApiRequest("/$id", Constants.GET, headers: headers);

    ApiResponse apiResponse = await makeRequest(INCIDENT_BASE_URL, apiRequest);
    return apiResponse;
  }

  Future<ApiResponse> getIncidentBySubService(
      String subService, String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    // brings token, use token to mk phone rquest.
    var apiRequest =
        ApiRequest("/$subService", Constants.GET, headers: headers);

    ApiResponse apiResponse = await makeRequest(INCIDENT_BASE_URL, apiRequest);
    return apiResponse;
  }

  Future<ApiResponse> getIncident(String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    // brings token, use token to mk phone rquest.
    var apiRequest = ApiRequest("", Constants.GET, headers: headers);

    ApiResponse apiResponse = await makeRequest(INCIDENT_BASE_URL, apiRequest);
    return apiResponse;
  }
}
