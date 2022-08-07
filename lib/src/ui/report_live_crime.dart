import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/icons.dart';

class ReportLiveCrime extends StatelessWidget {
  const ReportLiveCrime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/pexels_cop.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 100,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppIcon.flashOff.drawSvg(size: 28),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: AppIcon.close.drawSvg(size: 28),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/pictures.png',
                        width: 41,
                        height: 43,
                      ),
                      Container(child: AppIcon.camera.drawSvg(size: 41)),
                      Image.asset(
                        'assets/images/rotate.png',
                        width: 41,
                        height: 43,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
