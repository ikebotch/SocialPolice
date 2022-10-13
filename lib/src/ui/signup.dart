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
import 'package:socialpolice/src/ui/bottm_nav.dart';
import 'package:socialpolice/src/ui/components/buttons.dart';
import 'package:socialpolice/src/ui/components/input_text.dart';
import 'package:socialpolice/src/utils/dialogs.dart';
import 'package:socialpolice/src/utils/navigations.dart';
import 'package:socialpolice/src/utils/utils.dart';

class Signup extends StatefulWidget {
  final SecuredStorage? securedStorage;
  const Signup({
    Key? key,
    this.securedStorage,
  }) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with Dialogs {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  SecuredStorage? _sec;
  TextEditingController? usernameContrl, emailCtrlr, passCtrlr, fName, lName;
  bool _loading = false;
  final LoginBloc _loginBloc = LoginBloc();
  String token = '';

  Account? _account;

  @override
  void initState() {
    super.initState();
    usernameContrl = TextEditingController();
    emailCtrlr = TextEditingController();
    passCtrlr = TextEditingController();
    fName = TextEditingController();
    lName = TextEditingController();

    listener();
  }

  loading(String username) {
    print(_account?.user.token);
    _loginBloc.loading(username, _account?.user.token ?? token);
  }

  signup() {
    if (!Utils.isEmptyOrNull(usernameContrl!.text) &&
        !Utils.isEmptyOrNull(emailCtrlr!.text) &&
        !Utils.isEmptyOrNull(passCtrlr!.text) &&
        !Utils.isEmptyOrNull(lName!.text) &&
        !Utils.isEmptyOrNull(fName!.text)) {
      setState(() {
        _loading = true;
      });

      User singup = User()
        ..email = emailCtrlr!.text
        ..password = passCtrlr!.text
        ..firstname = fName!.text
        ..lastname = lName!.text
        ..username = usernameContrl!.text;

      _loginBloc.signUp(singup);
    }
  }

  listener() {
    _loginBloc.signUpFetcher.listen((event) {
      token = event;
      _account?.user.token = event;
      _sec!.setUserToken(event);
      loading(usernameContrl!.text);
      setState(() {
        _loading = true;
      });
    }).onError((error) {
      setState(() {
        _loading = false;
      });
    });

    _loginBloc.loadingFetcher.listen((event) {
      _account = event;
      // _sec!.setAppData(_account!);
      _sec!.setUserPass(passCtrlr!.text);
      _sec!.saveUser(_account!.user);
      showInSnackBar("Sign up Successfully", context, _key);
      context.read<ServicesProv>().addAllServicess(_account!.service);
      setState(() {
        _loading = false;
      });
      AppRoute.navigateReplace(context,
          BottomNav(account: _account, securedStorage: widget.securedStorage));
    }).onError((error) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SecuredStorage>(
        create: (_) => SecuredStorage(),
        builder: (BuildContext ctx, view) {
          _sec = Provider.of<SecuredStorage>(ctx);
          return Scaffold(
            key: _key,
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
                      SizedBox(height: Dimens.screenHeight * 0.05), //5%
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: Dimens.screenHeight * 0.03,
                        ),
                        child: InputText(
                          placeholder: 'Username',
                          controller: usernameContrl,
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
                          placeholder: 'First Name',
                          controller: fName,
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
                          placeholder: 'Last Name',
                          controller: lName,
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
                          placeholder: 'Email',
                          controller: emailCtrlr,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: Dimens.screenHeight * 0.03),
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
                          onPressed: signup,
                          text: 'Sign Up',
                          size: ButtonSize.FULL,
                          primaryColor: AppColors.colorPrimary,
                          radius: 60,
                          isLoading: _loading,
                        ),
                      ),
                      SizedBox(height: Dimens.screenHeight * 0.03),
                      Center(
                        child: InkWell(
                          onTap: () => AppRoute.pop(context),
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
                                  text: ' Login',
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
