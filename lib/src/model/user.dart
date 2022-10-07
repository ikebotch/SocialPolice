import 'package:socialpolice/src/utils/utils.dart';

class User {
  String? firstname = '';
  String? lastname = '';
  String primaryImage = '';
  String username = '';
  String email = '';
  bool isActive = false;

  User();

  String showName() {
    return '$firstname $lastname';
  }

  bool hasUserSignedUp() {
    if (!Utils.isEmptyOrNull(email)) {
      return true;
    } else {
      return false;
    }
  }

  User.fromJson(Map<String, dynamic> json) {
    firstname = json["firstname"];
    lastname = json["lastname"];
    primaryImage = json["primaryImage"];
    username = json["username"];
    email = json["email"];
    isActive = json["isActive"];
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'primaryImage': primaryImage,
        'username': username,
        'email': email,
        'isActive': isActive,
      };
}
