import 'package:socialpolice/src/model/api_models.dart';
import 'package:socialpolice/src/network/app_api.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/utils/constants.dart';

class ServicesRepository with AppApi {
  String SERVICE_BASE_URL = Constants.service;

  Future<ApiResponse> getServices() async {
    var apiRequest =
        ApiRequest("", Constants.GET, authTokenType: AuthTokenType.CLIENT);

    ApiResponse apiResponse = await makeRequest(SERVICE_BASE_URL, apiRequest);
    return apiResponse;
  }
}
