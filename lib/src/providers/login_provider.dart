import 'package:socialpolice/src/model/account.dart';
import 'package:socialpolice/src/model/user.dart';
import 'package:socialpolice/src/repository/auth_repository.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc {
  final _authRepository = AuthRepository();
  final loginFetcher = PublishSubject<String>();
  final loadingFetcher = PublishSubject<Account>();
  final signUpFetcher = PublishSubject<String>();

  Stream<String> get users => loginFetcher.stream;

  login(User login) async {
    final apiResponse = await _authRepository.login(login);

    if (apiResponse.status == 200 || apiResponse.status == 201) {
      loginFetcher.sink.add(apiResponse.data['access_token']);
    } else {
      loginFetcher.sink.addError('Wrong username or password');
    }
  }

  loading(String username, String token) async {
    final apiResponse = await _authRepository.loading(username, token);
    if (apiResponse.status == 200 || apiResponse.status == 201) {
      loadingFetcher.sink.add(Account.fromJson(apiResponse.data));
    } else {
      loadingFetcher.sink.addError('Something went wrong');
    }
  }

  signUp(User signUp) async {
    final apiResponse = await _authRepository.signup(signUp);
    // print(apiResponse.data['access_token']);
    if (apiResponse.status == 200 || apiResponse.status == 201) {
      signUpFetcher.sink.add(apiResponse.data['access_token']);
    } else {
      signUpFetcher.sink.addError(apiResponse.error!.errorMessage!);
    }
  }
}
