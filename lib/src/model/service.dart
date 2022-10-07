class ServiceList {
  String? serviceName = '';
  List<SubService> subServices = [];

  ServiceList({this.serviceName});

  addItem(SubService subSer) {
    subServices.add(subSer);
  }
}

class Service {
  String servicename = '';
  String description = '';
  String primaryImage = '';

  Service();

  Service.fromJson(Map<String, dynamic> json) {
    servicename = json['servicename'];
    description = json['description'];
    primaryImage = json['primaryImage'];
  }
}

class SubService {
  String id = '';
  String servicename = '';
  String subservicename = '';
  String subservicedescription = '';

  SubService();

  SubService.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    servicename = json["servicename"];
    subservicename = json["subservicename"];
    subservicedescription = json["subservicedescription"];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'servicename': servicename,
        'subservicename': subservicename,
        'subservicedescription': subservicedescription,
      };
}
