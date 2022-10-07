import 'package:socialpolice/src/model/service.dart';
import 'package:socialpolice/src/repository/services_repository.dart';
import 'package:rxdart/subjects.dart';

class ServiceBloc {
  final _servicesRepository = ServicesRepository();
  final getServicesFetcher = PublishSubject<List<Service>>();

  Stream<List<Service>> get servicesResponse => getServicesFetcher.stream;

  getServices() async {
    final apiResponse = await _servicesRepository.getServices();

    if (apiResponse.status == 200 || apiResponse.status == 201) {
      print(apiResponse.data);
      List<Service> service = [];
      for (var item in apiResponse.data) {
        Service serv = Service.fromJson(item);
        service.add(serv);
      }
      getServicesFetcher.sink.add(service);
    } else {
      getServicesFetcher.sink.addError(apiResponse.error!.errorMessage!);
    }
  }
}
