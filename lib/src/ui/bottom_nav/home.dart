import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/res/icons.dart';
import 'package:socialpolice/src/ui/news_alert.dart';
import 'package:socialpolice/src/ui/report_live_crime.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: AppColors.gradientApp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 48,
                    width: 48,
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.asset('assets/images/avatar.png'),
                    ),
                  ),
                  Text(
                    'Fransica Sika',
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportLiveCrime(),
                        ),
                      );
                    },
                    child: const Icon(Icons.camera_alt,
                        size: 41, color: Colors.white),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                choose(
                  'Police',
                  context,
                  AppIcon.cap.drawSvg(size: 32, color: Colors.white),
                ),
                choose(
                  'Ambulance',
                  context,
                  AppIcon.ambulance.drawSvg(size: 32),
                ),
              ],
            ),
            const SizedBox(height: 20),
            choose(
              'Fire',
              context,
              AppIcon.fire.drawSvg(size: 32),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Latest News',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsAlert(),
                ),
              ),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 77,
                width: double.infinity,
                color: AppColors.colorRed1,
                child: Center(
                  child: Text(
                    'News Alert',
                    style: GoogleFonts.montserrat(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container choose(String name, BuildContext context, Widget icon) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: 100,
      width: (MediaQuery.of(context).size.width - 30) / 2,
      decoration: BoxDecoration(
        color: AppColors.cardColor1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: icon,
            ),
            Text(
              name,
              style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
