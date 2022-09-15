import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialpolice/src/res/colors.dart';
import 'package:socialpolice/src/ui/components/search_bar.dart';
import 'package:socialpolice/src/ui/incident_report.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> data = [
    'Police Brutality',
    'Theft',
    'Robbery',
    'Cybercrime',
    'Arson',
    'Burglary',
    'Rape',
    'Domestic Violence',
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.colorBackground,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.only(top: 40),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 10),
            const SearchBar(),
            Expanded(
              flex: 1,
              child: ListView.separated(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IncidentReport(),
                      ),
                    ),
                    child: item(index),
                  );
                },
                separatorBuilder: (BuildContext ctx, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 46),
                    child: const Divider(
                      thickness: 0.8,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container item(int index) {
    return Container(
      height: 80,
      // color: Colors.white,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data[index],
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'loren loren',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
