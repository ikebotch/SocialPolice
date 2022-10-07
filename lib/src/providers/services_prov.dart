import 'package:flutter/material.dart';
import 'package:socialpolice/src/model/service.dart';

class ServicesProv with ChangeNotifier {
  final List<Service> _services = [];

  List<Service> get getService => _services;

  void addAllServicess(List<Service> ser) {
    if (ser.isNotEmpty) {
      if (ser.length != _services.length) {
        _services.addAll(ser);
      }
      notifyListeners();
    }
  }
}
