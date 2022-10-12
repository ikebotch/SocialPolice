import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialpolice/src/model/account.dart';
import 'package:socialpolice/src/providers/login_provider.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/icons.dart';
import 'package:socialpolice/src/settings/secured_storage.dart';
import 'package:socialpolice/src/ui/bottom_nav/home.dart';
import 'package:socialpolice/src/ui/bottom_nav/message.dart';
import 'package:socialpolice/src/ui/bottom_nav/profile.dart';
import 'package:socialpolice/src/ui/bottom_nav/search.dart';
import 'package:socialpolice/src/ui/incident_report_old.dart';

class BottomNav extends StatefulWidget {
  final Account? account;
  // final bool isLoggedIn;
  // final User? user;
  const BottomNav({
    Key? key,
    this.account,
    // this.isLoggedIn = false,
    // this.user,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  final PageController _pageCtrl = PageController();
  final LoginBloc _loginBloc = LoginBloc();
  SecuredStorage? _securedStorage;
  Account? _account;
  // User? user;

  int page = 0;
  int _activePage = 0;

  _onTapped(int value) {
    setState(() {
      _activePage = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _setUp();

    // listener();
  }

  // loading() {
  //   _loginBloc.loading(widget.user!.username, widget.user!.token);
  // }

  // _setUp() {
  //   // user = await _securedStorage!.getUserN();
  //   if (widget.user != null && widget.isLoggedIn) {
  //     _loginBloc.login(widget.user!);
  //   }
  // }

  // listener() {
  //   _loginBloc.loginFetcher.listen((value) {
  //     // user!.token = value;
  //     _securedStorage!.setUserToken(value);
  //     loading();
  //   }).onError((error) {});

  //   _loginBloc.loadingFetcher.listen((event) {
  //     _account = event;
  //     // _sec!.setAppData(_account!);
  //     _securedStorage!.saveUser(event.user);
  //     // showInSnackBar("Login Successfully", context, _key);
  //     context.read<ServicesProv>().addAllServicess(_account!.service);
  //   }).onError((error) {});
  // }

  @override
  Widget build(BuildContext context) {
    return Provider<SecuredStorage>(
        create: (_) => SecuredStorage(),
        builder: (BuildContext ctx, view) {
          _securedStorage = Provider.of<SecuredStorage>(ctx);
          return Scaffold(
              backgroundColor: Colors.white,
              // appBar: AppBar(
              //   backgroundColor: Colors.black,
              //   elevation: 0,
              //   automaticallyImplyLeading: false,
              // ),
              body: SafeArea(
                top: false,
                // bottom: false,
                child: Column(
                  children: [
                    Expanded(
                      flex: 12,
                      child: PageView.builder(
                        itemCount: 5,
                        controller: _pageCtrl,
                        onPageChanged: _onTapped,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext ctx, index) {
                          if (index == 0) {
                            return Home(account: widget.account);
                          }
                          if (index == 1) {
                            return const Search();
                          }
                          // if (index == 2) {
                          //   return const IncidentReportOld();
                          // }
                          if (index == 3) {
                            return const Message();
                          }
                          return const Profile();
                        },
                      ),
                    ),
                    Container(
                      height: 60,
                      margin:
                          const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                      padding: const EdgeInsets.only(bottom: 8, top: 0),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: AppColors.colorBorderGrey, width: 0.3),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              child: Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(15),
                                  height: MediaQuery.of(context).size.height,
                                  child: AppIcon.home.drawSvg(
                                    color: _activePage == 0
                                        ? AppColors.colorPrimary
                                        : AppColors.colorSecondary,
                                  )),
                              onTap: () {
                                _pageCtrl.jumpToPage(0);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height: MediaQuery.of(context).size.height,
                                  child: AppIcon.search.drawSvg(
                                    color: _activePage == 1
                                        ? AppColors.colorPrimary
                                        : AppColors.colorSecondary,
                                  )),
                              onTap: () {
                                _pageCtrl.jumpToPage(1);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height: MediaQuery.of(context).size.height,
                                  child: AppIcon.cap.drawSvg(
                                    color: _activePage == 2
                                        ? AppColors.colorPrimary
                                        : AppColors.colorSecondary,
                                  )),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IncidentReportOld(
                                      account: widget.account,
                                      serviceType: 'Police',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height: MediaQuery.of(context).size.height,
                                  child: AppIcon.messageNav.drawSvg(
                                    color: _activePage == 3
                                        ? AppColors.colorPrimary
                                        : AppColors.colorSecondary,
                                  )),
                              onTap: () {
                                _pageCtrl.jumpToPage(3);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height: MediaQuery.of(context).size.height,
                                  child: AppIcon.profile.drawSvg(
                                    color: _activePage == 4
                                        ? AppColors.colorPrimary
                                        : AppColors.colorSecondary,
                                  )),
                              onTap: () {
                                _pageCtrl.jumpToPage(4);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              // body: SafeArea(
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Container(
              //             margin: const EdgeInsets.only(left: 20),
              //             height: 40,
              //             width: 40,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: Colors.white,
              //               border: Border.all(
              //                 color: AppColors.colorButton,
              //                 width: 1,
              //               ),
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              );
        });
  }
}
