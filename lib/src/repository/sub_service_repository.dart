import 'package:socialpolice/src/model/api_models.dart';
import 'package:socialpolice/src/network/app_api.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/utils/constants.dart';

class SubServiceRepository with AppApi {
  String SUB_SERVICE_BASE_URL = Constants.subService;

  Future<ApiResponse> getSubServiceByServiceName(String serviceName) async {
    var apiRequest = ApiRequest("/service/$serviceName", Constants.GET,
        authTokenType: AuthTokenType.CLIENT);

    ApiResponse apiResponse =
        await makeRequest(SUB_SERVICE_BASE_URL, apiRequest);
    return apiResponse;
  }

  Future<ApiResponse> getSubServiceByID(String id) async {
    var apiRequest =
        ApiRequest("/$id", Constants.GET, authTokenType: AuthTokenType.CLIENT);

    ApiResponse apiResponse =
        await makeRequest(SUB_SERVICE_BASE_URL, apiRequest);
    return apiResponse;
  }
}
