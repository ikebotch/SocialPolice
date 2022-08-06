import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/icons.dart';
import 'package:socialpolice/src/ui/home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  final PageController _pageCtrl = PageController();

  int page = 0;
  int _activePage = 0;

  _onTapped(int value) {
    setState(() {
      _activePage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 12,
              child: Container(
                child: PageView.builder(
                  itemCount: 5,
                  controller: _pageCtrl,
                  onPageChanged: _onTapped,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext ctx, index) {
                    if (index == 0) {
                      return const Home();
                    }
                    if (index == 1) {
                      return Container();
                    }
                    if (index == 2) {
                      return Container();
                    }
                    if (index == 3) {
                      return Container();
                    }
                    return Container();
                  },
                ),
              ),
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
              padding: const EdgeInsets.only(bottom: 8, top: 0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.colorBorderGrey, width: 0.3),
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
                        _pageCtrl.jumpToPage(2);
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
  }
}
