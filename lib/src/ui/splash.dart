import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialpolice/src/providers/service_provider.dart';
import 'package:socialpolice/src/providers/services_prov.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/ui/bottom_nav/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final ServiceBloc _serviceBloc = ServiceBloc();
  @override
  void initState() {
    super.initState();
    getService();

    listener(context);
  }

  next(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      });
    });
  }

  getService() {
    _serviceBloc.getServices();
  }

  listener(BuildContext context) {
    _serviceBloc.getServicesFetcher.listen((event) {
      context.read<ServicesProv>().addAllServicess(event);
      if (kDebugMode) {
        print(event[0].servicename);
      }
      next(context);
    }).onError((error) {});
  }

  @override
  Widget build(BuildContext context) {
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
