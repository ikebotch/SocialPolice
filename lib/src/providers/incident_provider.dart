import 'package:socialpolice/src/model/incident.dart';
import 'package:socialpolice/src/repository/incident_repository.dart';
import 'package:rxdart/subjects.dart';

class IncidentBloc {
  final _incidentRepository = IncidentRepository();
  final postIncidentFetcher = PublishSubject<dynamic>();
  final incidentByIdFetcher = PublishSubject<Incident>();
  final incidentByUserFetcher = PublishSubject<List<Incident>>();

  Stream<dynamic> get postedIncident => postIncidentFetcher.stream;
  Stream<Incident> get incidentById => incidentByIdFetcher.stream;
  Stream<List<Incident>> get incidentByUsername => incidentByUserFetcher.stream;

  postIncident(Incident incident, String token) async {
    final apiResponse = await _incidentRepository.postIncident(incident, token);

    if (apiResponse.status == 200 || apiResponse.status == 201) {
      postIncidentFetcher.sink.add(apiResponse.data);
    } else {
      postIncidentFetcher.sink.addError(apiResponse.error!.errorMessage!);
    }
  }

  getIncidentByUsername(String username, String token) async {
    final apiResponse =
        await _incidentRepository.getIncidentByUsername(username, token);
    if (apiResponse.status == 200 || apiResponse.status == 201) {
      List<Incident> inc = [];
      for (var item in apiResponse.data) {
        Incident incident = Incident.fromJson(item);
        inc.add(incident);
      }
      incidentByUserFetcher.sink.add(inc);
    } else {
      incidentByUserFetcher.sink.addError(apiResponse.error!.errorMessage!);
    }
  }

  geetIncidentById(String id, String token) async {
    final apiResponse = await _incidentRepository.getIncidentByID(id, token);

    if (apiResponse.status == 200 || apiResponse.status == 201) {
      incidentByIdFetcher.sink.add(Incident.fromJson(apiResponse.data));
    } else {
      incidentByIdFetcher.sink.addError(apiResponse.error!.errorMessage!);
    }
  }
}
