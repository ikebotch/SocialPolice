class Constants {
  static String API_BASE_URL = "";

  static String login = '';
  static String signup = '';

  static init({bool? isTest}) {
    if (isTest!) {
      // test environment
    } else {
      // live environment
    }
  }
}
