import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialpolice/src/res/colors.dart';

class IncidentReport extends StatelessWidget {
  const IncidentReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 40),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 75,
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Incident Report',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dustin Warren',
                          style: GoogleFonts.redHatDisplay(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '12-08-22',
                          style: GoogleFonts.redHatDisplay(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  'Description',
                  style: GoogleFonts.redHatDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'My name is Dustin, I’m a young designer from Dublin. I practice for 4 years now, worked with small and big agencies. Blablabla',
                  style: GoogleFonts.publicSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  'Location',
                  style: GoogleFonts.redHatDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 194,
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Image.asset(
                  'assets/images/map.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  'Media',
                  style: GoogleFonts.redHatDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 10),
                height: 130,
                child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext cts, int index) {
                    return Container(
                      width: (MediaQuery.of(context).size.width - 30) / 2,
                      height: 100,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: AppColors.colorBorderGrey3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            index == 0
                                ? 'assets/images/media.jpg'
                                : 'assets/images/media1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
