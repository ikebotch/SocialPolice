import 'package:socialpolice/src/model/service.dart';
import 'package:socialpolice/src/model/user.dart';

class Account {
  User user = User();
  List<Service> service = [];
  List<SubService> subService = [];

  Account();

  Account.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }
    if (json['service'] != null) {
      List<Service> serv = [];
      for (var item in json['service']) {
        Service services = Service.fromJson(item);
        serv.add(services);
      }
      service = serv;
    }
    if (json['subService'] != null) {
      List<SubService> subSer = [];
      for (var item in json['subService']) {
        SubService subServices = SubService.fromJson(item);
        subSer.add(subServices);
      }
      subService = subSer;
    }
  }
}
