import 'package:flutter/material.dart';
import 'package:socialpolice/src/res/colors.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
    );
  }
}
