import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Text(
              'Profile',
              style: GoogleFonts.redHatDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 90,
              width: 90,
              child: Stack(
                children: [
                  Align(
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Dustin Warren',
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.edit),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          item('About'),
          const Divider(),
          item('Settings'),
          const Divider(),
        ],
      ),
    );
  }

  Padding item(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        name,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
