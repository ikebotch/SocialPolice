class Incident {
  String username = '';
  String subservicename = '';
  String primaryImage = '';
  String description = '';
  String primaryVideo = '';
  String location = '';
  String assignedOfficer = '';

  Incident();

  Incident.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    subservicename = json["subservicename"];
    primaryImage = json["primaryImage"];
    description = json["description"];
    primaryVideo = json["primaryVideo"];
    location = json["location"];
    if (json["assignedOfficer"] != null) {
      assignedOfficer = json["assignedOfficer"];
    }
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'subservicename': subservicename,
        'primaryImage': primaryImage,
        'description': description,
        'primaryVideo': primaryVideo,
        'location': location,
      };
}
