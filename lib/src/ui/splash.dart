import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/dimens.dart';
import 'package:socialpolice/src/ui/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Dimens().init(context);
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
  }
}
