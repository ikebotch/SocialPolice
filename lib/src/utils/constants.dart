class Constants {
  static String API_BASE_URL = "https://sleec-api-icnbotbi4q-uc.a.run.app";

  static String login = '';
  static String signup = '';
  static String user = '';
  static String service = '';
  static String subService = '';
  static String incident = '';
  static String auth = '';

  static init({bool? isTest}) {
    if (isTest!) {
      // test environment
      user = '$API_BASE_URL/users';
      service = '$API_BASE_URL/service';
      subService = '$API_BASE_URL/sub-service';
      incident = '$API_BASE_URL/incident';
      auth = '$API_BASE_URL/auth';
    } else {
      // live environment
    }
  }

  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String PUT = 'PUT';
  static const String DELETE = 'DELETE';

  static const String FALLBACK_ERROR_MESSAGE =
      'Something went wrong. Please try again later.';

  static const String DEFAULT_TIMESTAMP_FORMAT = "yyyy-MM-ddTHH:mm:ss'Z'";
  static const String DISPLAY_TIMESTAMP_FORMAT = 'yyyy-MM-dd hh:mm a';
  static const String DISPLAY_TIMESTAMP_SIMPLE_FORMAT = 'dd MMM, yyyy';
  static const String EMAIL_REGEX =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static const int DEFAULT_PAGE_SIZE = 20;
}
