import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialpolice/src/model/account.dart';
import 'package:socialpolice/src/settings/secured_storage.dart';
import 'package:socialpolice/src/ui/components/image_download.dart';

class Profile extends StatefulWidget {
  final Account? account;
  final SecuredStorage? securedStorage;
  const Profile({
    Key? key,
    this.account,
    this.securedStorage,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        radius: 90,
                        child: AppImageDownload(
                          url: widget.account!.user.primaryImage,
                          placeHolder: widget.account!.user.showName(),
                          fit: BoxFit.cover,
                          size: 90,
                          height: 90,
                        ),
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
                    widget.account!.user.showName(),
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
          GestureDetector(
            onTap: () => widget.securedStorage!.logout(context),
            child: item('Logout'),
          ),
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
