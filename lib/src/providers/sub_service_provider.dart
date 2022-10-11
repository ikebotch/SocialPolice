import 'package:socialpolice/src/model/service.dart';
import 'package:socialpolice/src/repository/sub_service_repository.dart';
import 'package:rxdart/subjects.dart';

class SubServiceBloc {
  final _subServiceRepository = SubServiceRepository();
  final getSubServiceFetcher = PublishSubject<List<SubService>>();

  Stream<List<SubService>> get subServicesResponse =>
      getSubServiceFetcher.stream;

  getsubServiceByServiceName(String serviceName) async {
    final apiResponse =
        await _subServiceRepository.getSubServiceByServiceName(serviceName);

    if (apiResponse.status == 200 || apiResponse.status == 201) {
      print(apiResponse.data);
      List<SubService> subService = [];
      for (var item in apiResponse.data) {
        SubService subServ = SubService.fromJson(item);
        subService.add(subServ);
      }
      getSubServiceFetcher.sink.add(subService);
    } else {
      getSubServiceFetcher.sink.addError(apiResponse.error!.errorMessage!);
    }
  }
}
