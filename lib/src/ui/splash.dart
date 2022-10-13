import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialpolice/src/model/account.dart';
import 'package:socialpolice/src/model/user.dart';
import 'package:socialpolice/src/providers/login_provider.dart';
import 'package:socialpolice/src/providers/services_prov.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/settings/secured_storage.dart';
import 'package:socialpolice/src/ui/bottm_nav.dart';
import 'package:socialpolice/src/ui/login.dart';
import 'package:socialpolice/src/utils/navigations.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // final ServiceBloc _serviceBloc = ServiceBloc();
  SecuredStorage? _securedStorage;
  final LoginBloc _loginBloc = LoginBloc();
  Account? _account;
  User? user;

  setup() async {
    user = await _securedStorage!.getUserN();

    bool isLoggedIn = await _securedStorage!.isLoggedIn();
    if (isLoggedIn) {
      if (user!.token != '') {
        // user!.password = 'password';
        _loginBloc.login(user!);

        return;
      }
    } else {
      ///route to login page
      next(const Login());
    }
  }

  loading() {
    _loginBloc.loading(user!.username, user!.token);
  }

  @override
  void initState() {
    super.initState();
    // getService();

    // listener(context);
    listener();
  }

  listener() {
    _loginBloc.loginFetcher.listen((value) {
      // user!.token = value;
      _securedStorage!.setUserToken(value);
      loading();
    }).onError((error) {});

    _loginBloc.loadingFetcher.listen((event) {
      _account = event;
      // _sec!.setAppData(_account!);
      _securedStorage!.saveUser(event.user);
      // showInSnackBar("Login Successfully", context, _key);
      context.read<ServicesProv>().addAllServicess(_account!.service);
      next(BottomNav(account: _account, securedStorage: _securedStorage));
    }).onError((error) {});
  }

  next(Widget page) {
    Future.delayed(const Duration(milliseconds: 300), () {
      AppRoute.navigateReplace(context, page);
    });
  }

  // getService() {
  //   _serviceBloc.getServices();
  // }

  // listener(BuildContext context) {
  //   _serviceBloc.getServicesFetcher.listen((event) {
  //     context.read<ServicesProv>().addAllServicess(event);
  //     if (kDebugMode) {
  //       print(event[0].servicename);
  //     }
  //     next(context);
  //   }).onError((error) {});
  // }

  @override
  Widget build(BuildContext context) {
    return Provider<SecuredStorage>(
        create: (_) => SecuredStorage(),
        builder: (BuildContext ctx, view) {
          _securedStorage = Provider.of<SecuredStorage>(ctx);
          setup();
          return Scaffold(
            body: SafeArea(
              top: false,
              bottom: false,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.gradientApp,
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Text(
                        'SLEECS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: const [
                          Center(
                            child: Text(
                              'Your Safety is Our \n Priority ________',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.98,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
