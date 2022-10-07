import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socialpolice/src/model/authtoken.dart';
import 'package:socialpolice/src/model/user.dart';
import 'package:socialpolice/src/ui/login.dart';

const _storage = FlutterSecureStorage();

class SecuredSettings {
  void setAndSaveString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getStringFromPrefs(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      return "";
    }
  }

  removeFromSecured(String key) async {
    await _storage.delete(key: key);
  }
}

class SecuredStorage extends SecuredSettings {
  static const String User_INFO = "user_info";
  static const String CLIENT_AUTH_TOKEN = "client_auth_token";
  static const String USER_AUTH_TOKEN = "user_auth_token";
  static const String SIGN_UP = "sign_up";
  static const String DEVICE = "device";
  static const String NEW_USER = "new_user";
  static const String DARK_THEME = "dark_theme";
  static const String SERVICES = "SERVICES";

  // Future<bool> isLoggedIn() async {
  //   Account? user = await getUser();
  //   return !Utils.isEmptyOrNull(user.id);
  // }
  Future<bool> isLoggedIn() async {
    User? user = await getUserN();
    bool valid = (user.hasUserSignedUp());
    return valid;
  }

  // setDarkTheme(bool value) {
  //   darkThem = value;
  //   setAndSaveString(DARK_THEME, json.encode(value));
  //   // notifyListeners();
  // }

  setUser(User user) {
    setAndSaveString(NEW_USER, json.encode(user));
  }

  saveUser(User account) {
    setAndSaveString(User_INFO, json.encode(account));
  }

  saveSignup(User signUp) {
    setAndSaveString(SIGN_UP, json.encode(signUp));
  }

  setClientAuthToken(AuthToken authToken) {
    setAndSaveString(CLIENT_AUTH_TOKEN, json.encode(authToken));
  }

  setUserAuthToken(AuthToken authToken) {
    setAndSaveString(USER_AUTH_TOKEN, json.encode(authToken));
  }

  // saveDevice(Device device) {
  //   setAndSaveString(DEVICE, json.encode(device));
  // }

  Future<bool> isDarkTheme() async {
    String? tokenMap = await getStringFromPrefs(DARK_THEME);
    if (tokenMap != null) {
      bool user = json.decode(tokenMap);
      return user;
    } else {
      return false;
    }
  }

  // Future<SignUp> getSignup() async {
  //   String? tokenMap = await getStringFromPrefs(SIGN_UP);
  //   if (tokenMap != null) {
  //     SignUp user = SignUp.fromJson(json.decode(tokenMap));
  //     return user;
  //   } else {
  //     return SignUp();
  //   }
  // }

  Future<AuthToken> getClientAuthToken() async {
    String? tokenMap = await getStringFromPrefs(CLIENT_AUTH_TOKEN);
    if (tokenMap != null) {
      AuthToken user = AuthToken.fromJson(json.decode(tokenMap));
      return user;
    } else {
      return AuthToken();
    }
  }

  Future<AuthToken> getUserAuthToken() async {
    String? tokenMap = await getStringFromPrefs(USER_AUTH_TOKEN);
    if (tokenMap != null) {
      AuthToken user = AuthToken.fromJson(json.decode(tokenMap));
      return user;
    } else {
      return AuthToken();
    }
  }

  Future<User> getUser() async {
    String? tokenMap = await getStringFromPrefs(User_INFO);
    if (tokenMap != null) {
      User user = User.fromJson(json.decode(tokenMap));
      return user;
    } else {
      return User();
    }
  }

  Future<User> getUserN() async {
    String? tokenMap = await getStringFromPrefs(NEW_USER);
    if (tokenMap != null) {
      User user = User.fromJson(json.decode(tokenMap));
      return user;
    } else {
      return User();
    }
  }

  logout(BuildContext context) async {
    removeFromSecured(User_INFO);
    removeFromSecured(NEW_USER);
    // removeFromSecured(CLIENT_AUTH_TOKEN);
    removeFromSecured(USER_AUTH_TOKEN);
    removeFromSecured(SIGN_UP);
    removeFromSecured(DEVICE);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const Login();
      },
    ), (Route<dynamic> route) => false);
  }
}