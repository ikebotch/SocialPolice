import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socialpolice/src/model/account.dart';
import 'package:socialpolice/src/model/user.dart';
import 'package:socialpolice/src/providers/login_provider.dart';
import 'package:socialpolice/src/providers/services_prov.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/dimens.dart';
import 'package:socialpolice/src/res/enums.dart';
import 'package:socialpolice/src/settings/secured_storage.dart';
import 'package:socialpolice/src/ui/components/buttons.dart';
import 'package:socialpolice/src/ui/components/input_text.dart';
import 'package:socialpolice/src/ui/signup.dart';
import 'package:socialpolice/src/utils/dialogs.dart';
import 'package:socialpolice/src/utils/navigations.dart';
import 'package:socialpolice/src/utils/utils.dart';

import 'bottm_nav.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with Dialogs {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  SecuredStorage? _sec;

  final LoginBloc _loginBloc = LoginBloc();
  TextEditingController userCtrlr = TextEditingController();
  TextEditingController passCtrlr = TextEditingController();
  bool _loading = false;
  final bool _showPwd = false;
  String token = '';

  Account? _account;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listener();
  }

  login() {
    if (!Utils.isEmptyOrNull(userCtrlr.text) &&
        !Utils.isEmptyOrNull(passCtrlr.text)) {
      User login = User()
        ..username = userCtrlr.text
        ..password = passCtrlr.text;

      _loginBloc.login(login);
      setState(() {
        _loading = true;
      });
    }
  }

  loading(String token) {
    _loginBloc.loading(userCtrlr.text, token);
  }

  listener() {
    _loginBloc.loginFetcher.listen((value) {
      _account?.user.token = value;
      _sec!.setUserToken(value);
      loading(value);
    }).onError((error) {
      showMessage(context, error, dismissLabel: 'Ok');
      setState(() {
        _loading = false;
      });
    });

    _loginBloc.loadingFetcher.listen((event) {
      _account = event;
      // _sec!.setAppData(_account!);
      _sec!.saveUser(event.user);
      // showInSnackBar("Login Successfully", context, _key);
      context.read<ServicesProv>().addAllServicess(_account!.service);
      setState(() {
        _loading = false;
      });
      AppRoute.navigateReplace(context, BottomNav(account: _account));
    }).onError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SecuredStorage>(
        create: (_) => SecuredStorage(),
        builder: (BuildContext ctx, view) {
          _sec = Provider.of<SecuredStorage>(ctx);
          return Scaffold(
            body: SafeArea(
              top: false,
              bottom: false,
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: AppColors.gradientApp,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimens.screenHeight * 0.1), //10%
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'SLEECS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Keeping the',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'street',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 32,
                              color: Colors.white,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: ' Safer',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Dimens.screenHeight * 0.1), //10%
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: Dimens.screenHeight * 0.03,
                        ),
                        child: InputText(
                          placeholder: 'Username',
                          controller: userCtrlr,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: Dimens.screenHeight * 0.03,
                        ),
                        child: InputText(
                          placeholder: 'Password',
                          controller: passCtrlr,
                          secureTextEntry: true,
                        ),
                      ),
                      Container(
                        alignment: FractionalOffset.bottomCenter,
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: AppButton(
                          onPressed: () async {
                            if (userCtrlr.text.isNotEmpty &&
                                passCtrlr.text.isNotEmpty) {
                              login();
                            } else {
                              showMessage(
                                context,
                                'Please username and password is required',
                                dismissLabel: 'Ok',
                              );
                            }
                          },
                          text: 'Login',
                          size: ButtonSize.FULL,
                          primaryColor: AppColors.colorPrimary,
                          radius: 60,
                          isLoading: _loading,
                        ),
                      ),
                      SizedBox(height: Dimens.screenHeight * 0.03),
                      Center(
                        child: InkWell(
                          onTap: () => AppRoute.navigatePush(
                              context: context, page: const Signup()),
                          child: RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ' Signup',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                    color: AppColors.colorPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimens.screenHeight * 0.03),
                      Center(
                        child: InkWell(
                          onTap: () => AppRoute.navigatePush(
                              context: context, page: const Signup()),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: RichText(
                              text: TextSpan(
                                text: 'By signing up, you are agree with our ',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: ' Terms & Conditions',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      color: AppColors.colorlemonGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
